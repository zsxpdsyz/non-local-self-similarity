function  [PSNR3D, PSNRV,MPSNR,SSIMV,MSSIM,UQIV,MUQI,GMSDV,MGMSD,SAM] = QuanAsse(Ori_H,Denoi_HSI)
[M,N,B] = size(Ori_H);
% T1 = reshape(Ori_H,M*N,B);

% T2 = reshape(Denoi_HSI,M*N,B);
% temp = reshape(sum((T1 -T2).^2),B,1)/(M*N);
% PSNRV = 20*log10(max(T1',[],2))-10*log10(temp);
PSNR3D = psnr(Denoi_HSI,Ori_H,max(Ori_H(:)));

 for i=1:B
     T1 = Ori_H(:,:,i);T2 = Denoi_HSI(:,:,i);
 PSNRV(i) = psnr(T2,T1,max(T1(:)));
[SSIMV(i) , ~]=ssim_index(Ori_H(:,:,i)*255, Denoi_HSI(:,:,i)*255);%ssim_index(Ori_H(:,:,i)*255, Denoi_HSI(:,:,i)*255);
[UQIV(i), ~] = img_qi(Ori_H(:,:,i),Denoi_HSI(:,:,i));
[GMSDV(i),~] = GMSD(Ori_H(:,:,i)*255, Denoi_HSI(:,:,i)*255);
 end
 MPSNR = mean(PSNRV);
 SAM = SpectAngMapper(Ori_H*255, Denoi_HSI*255);
 MSSIM = mean(SSIMV);
 MUQI = mean(UQIV);
 MGMSD = mean(GMSDV);
 
