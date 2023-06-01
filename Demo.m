clear; clc; close all;
load('DemoData.mat');

cvr_sine_fd = cvr_fd_glm(im_sine, mask, pco2_sine);
cvr_show(cvr_sine_fd);title('CVR Sine (FD-GLM)','FontSize', 18);

cvr_rest_fd = cvr_fd_glm(im_resting, mask, pco2_resting);
cvr_show(cvr_rest_fd);title('CVR Resting (FD-GLM)','FontSize', 18);

cvr_sine_cw = cvr_cw_glm(im_sine, mask, pco2_sine);
cvr_show(cvr_sine_cw);title('CVR Sine (CW-GLM)','FontSize', 18);

cvr_rest_cw = cvr_cw_glm(im_resting, mask, pco2_resting);
cvr_show(cvr_rest_cw);title('CVR Resting (CW-GLM)','FontSize', 18);