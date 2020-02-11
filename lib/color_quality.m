function [a b] = color_quality(I,J)
a = psnr(I,J);
b = 0;
b = ssim(I,J);