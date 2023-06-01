function [outputfiles] = cvr_fd_glm(image, mask, pco2)
    % image         BOLD 4D data (x, y, z, t)
    % mask          brainmask 3D data; if the mask is not available, set a
    %               all-one matrix with the same size of BOLD (x, y, z).               
    % pco2          end-tidal pCO2 series
    
    % HRF Low-pass cutoff
    alpha = 0.15; 
    
    Nr = size(pco2, 1);
    if mod(Nr,2)==0
        omega=2*pi/Nr * [0:1:Nr/2,-(Nr/2-1):1:-1];
    else
        omega=2*pi/Nr * [0:(Nr-1)/2,-(Nr-1)/2:1:-1];
    end
    
    hrf = alpha./(alpha + 1j*omega);
   
    
    image_size = size(image);
    
    % normalize CO2 data
    pco2 = pco2 - mean(pco2);
    pco2 = pco2';
    % get Fourier coefficients of CO2
    f_pco2_hrf = fft(pco2).*hrf;
   

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
                    p = polyfit(abs(f_pco2_hrf), abs(fft(ts')), 1);
                    cvr(i,j,k) = p(1);
                end
            end
        end
    end
    
    %% output
    outputfiles = cvr;