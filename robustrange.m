function lims = robustrange(s,plims)
% lims = robustrange(s,plims)
%
% Return percentile range of image intensities
%
% ARGS :
% s     = image data
% plims = lower and upper percentile limits [plow phi]
%
% AUTHOR : Mike Tyszka, Ph.D.
% PLACE  : CHLA Los Angeles, CA
% DATES  : 07/16/2002 From scratch

% Flatten the image data
s = s(:);
n = length(s);

% Sort pixel values
s = sort(s);

% Calculate nearest indices to percentile limits
inds = round(plims/100 * n);
lims = s(inds)';
