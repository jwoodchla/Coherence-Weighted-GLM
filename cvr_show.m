function cvr_show(image)
cvr_show= rot90(image);
cvr_lim = robustrange(image,[5 95]);
figure, montage(cvr_show(:,:,round(linspace(1,size(cvr_show,3),12))),'DisplayRange', cvr_lim),colorbar,colormap(jet);
