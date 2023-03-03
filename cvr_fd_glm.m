function [outputfiles] = cvr_fd_glm(image, mask, pco2, TR)
    % image         BOLD 4D data (x, y, z, t)
    % mask          brainmask 3D data; if the mask is not available, set a
    %               all-one matrix with the same size of BOLD (x, y, z).               
    % pco2          end-tidal pCO2 series
    % TR            BOLD MRI TR
    
    NyquistUnit = (1./TR)./(size(pco2, 1) - 1);
    
    % HRF Low-pass cutoff
    alpha = 0.15; 
    
    image_size = size(image);
    
    % normalize CO2 data
    pco2 = pco2 - mean(pco2);
    
    % get Fourier coefficients of CO2
    mag_co2 = abs(fft(pco2));
    center_index = ceil(size(pco2, 1)./2) - 1;
    scale_factor =1./abs((1:center_index-1).*NyquistUnit.*(-1i).*2.*pi + alpha.*2.*pi);
    
    %% calculate CVR map
    cvr = zeros(image_size(1:3));
    for i=1:image_size(1)
        for j=1:image_size(2)
            for k=1:image_size(3)
                if(mask(i,j,k) == 1)
                    ts = image(i,j,k,:); 
                    ts = reshape(ts,[image_size(4) 1]);
                    ts = (ts./mean(ts) - 1)*100; % normalize image (voxelwise)
                    ts(isnan(ts)) = 0;
                    mag_ts = abs(fft(ts));
                    b = polyfit(mag_co2(2:center_index).*scale_factor',mag_ts(2:center_index),1);
                    cvr(i,j,k) = b(1);
                end
            end
        end
    end
    
    %% output
    outputfiles = cvr;