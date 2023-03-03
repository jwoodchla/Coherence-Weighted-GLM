clear; clc; close all;
load('DemoData.mat');

TR = 1.5;
s = std(pco2_sine)./std(pco2_resting);

cvr1 = cvr_fd_glm(im_sine, mask, pco2_sine, TR);
cvr_sine_show= rot90(cvr1);
cvr_sine_lim = robustrange(cvr1,[5 95]);
figure, montage(cvr_sine_show(:,:,round(linspace(1,size(cvr_sine_show,3),12))),'DisplayRange', cvr_sine_lim),colorbar,colormap(jet);
title('Sinusoidal CVR (FD-GLM)','FontSize', 18);

cvr2 = cvr_fd_glm(im_resting, mask, pco2_resting, TR);
cvr_sine_show= rot90(cvr2./s);
cvr_sine_lim = robustrange(cvr2./s,[5 95]);
figure, montage(cvr_sine_show(:,:,round(linspace(1,size(cvr_sine_show,3),12))),'DisplayRange', cvr_sine_lim),colorbar,colormap(jet);
title('Resting CVR (FD-GLM)','FontSize', 18);

cvr3 = cvr_cw_glm(im_sine, mask, pco2_sine, TR);
cvr_sine_show= rot90(cvr3);
cvr_sine_lim = robustrange(cvr3,[5 95]);
figure, montage(cvr_sine_show(:,:,round(linspace(1,size(cvr_sine_show,3),12))),'DisplayRange', cvr_sine_lim),colorbar,colormap(jet);
title('Sinusoidal CVR (CW-GLM)','FontSize', 18);

cvr4 = cvr_cw_glm(im_resting, mask, pco2_resting, TR);
cvr_sine_show= rot90(cvr4./s);
cvr_sine_lim = robustrange(cvr4./s,[5 95]);
figure, montage(cvr_sine_show(:,:,round(linspace(1,size(cvr_sine_show,3),12))),'DisplayRange', cvr_sine_lim),colorbar,colormap(jet);
title('Resting CVR (CW-GLM)','FontSize', 18);
