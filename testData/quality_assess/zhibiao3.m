
num = 0;
load train
warning = 0;
RPCA = 5;
clear PSNRV SSIMV UQIV GMSDV
%%
num = 1;
methodname{1} = 'noisy';
runingtime(num) = 0;
disp('*********************** noisy ************************'); 
[PSNR3D(num), PSNRV(:,num),MPSNR(num),SSIMV(:,num),MSSIM(num),UQIV(:,num),MUQI(num),GMSDV(:,num),MGMSD(num),SAM(num)] = QuanAsse(img_clean,img_noisy); 

disp(['PNSR3D : ' num2str(PSNR3D(num) ),'  MPSNR: ',num2str(MPSNR(num)), '   MSSIM: ',num2str(MSSIM(num) ),...
    '   MUQI: ',num2str(MUQI(num)  ),'   MGMSD: ',num2str(MGMSD(num)),'   SAM: ',num2str(SAM(num)), '   time: ',num2str(runingtime(num))]);

%%    Denoising Hyperspectral Image With Non-i.i.d. Noise Structure  IEEE TCyb
num = 7;
methodname{num} = 'NMoG';
runingtime(num) = time_NMoG;
disp('*********************** NMoG ************************'); 
[PSNR3D(num), PSNRV(:,num),MPSNR(num),SSIMV(:,num),MSSIM(num),UQIV(:,num),MUQI(num),GMSDV(:,num),MGMSD(num),SAM(num)] = QuanAsse(img_clean,img_NMoG); 
disp(['PNSR3D : ' num2str(PSNR3D(num) ),'  MPSNR: ',num2str(MPSNR(num)), '   MSSIM: ',num2str(MSSIM(num) ),...
         '   MUQI: ',num2str(MUQI(num)  ),'   MGMSD: ',num2str(MGMSD(num)),'   SAM: ',num2str(SAM(num)), '   time: ',num2str(runingtime(num))]);
if warning; sound(y,Fs);end
% %% RPCA
% num = 2;
% methodname{num} = 'RPCA';
% runingtime(num) = time_RPCA;
% disp('***********************RPCA ********************'); 
% [PSNR3D(num), PSNRV(:,num),MPSNR(num),SSIMV(:,num),MSSIM(num),UQIV(:,num),MUQI(num),GMSDV(:,num),MGMSD(num),SAM(num)] = QuanAsse(img_clean,img_RPCA); 
% disp(['PNSR3D : ' num2str(PSNR3D(num) ),'  MPSNR: ',num2str(MPSNR(num)), '   MSSIM: ',num2str(MSSIM(num) ),...
%          '   MUQI: ',num2str(MUQI(num)  ),'   MGMSD: ',num2str(MGMSD(num)),'   SAM: ',num2str(SAM(num)), '   time: ',num2str(runingtime(num))]);
% if warning sound(y,Fs);end
%%   LRMR
num = 6;
methodname{num} = 'LRMR';
runingtime(num) = time_LRMR;
disp('*********************** LRMR ************************'); 
[PSNR3D(num), PSNRV(:,num),MPSNR(num),SSIMV(:,num),MSSIM(num),UQIV(:,num),MUQI(num),GMSDV(:,num),MGMSD(num),SAM(num)] = QuanAsse(img_clean,img_LRMR); 
disp(['PNSR3D : ' num2str(PSNR3D(num) ),'  MPSNR: ',num2str(MPSNR(num)), '   MSSIM: ',num2str(MSSIM(num) ),...
         '   MUQI: ',num2str(MUQI(num)  ),'   MGMSD: ',num2str(MGMSD(num)),'   SAM: ',num2str(SAM(num)), '   time: ',num2str(runingtime(num))]);
if warning sound(y,Fs);end

 %% NAILRMA
% num = 4;
% methodname{num} = 'NAILRMA';
% runingtime(num) = time_NAI;
% disp('*********************** NAILRMA************************'); 
% [PSNR3D(num), PSNRV(:,num),MPSNR(num),SSIMV(:,num),MSSIM(num),UQIV(:,num),MUQI(num),GMSDV(:,num),MGMSD(num),SAM(num)] = QuanAsse(img_clean,img_NAI); 
% disp(['PNSR3D : ' num2str(PSNR3D(num) ),'  MPSNR: ',num2str(MPSNR(num)), '   MSSIM: ',num2str(MSSIM(num) ),...
%          '   MUQI: ',num2str(MUQI(num)  ),'   MGMSD: ',num2str(MGMSD(num)),'   SAM: ',num2str(SAM(num)), '   time: ',num2str(runingtime(num))]);
% if warning sound(y,Fs);end

%% NAILRMA + RPCA
% num = num+1;
% methodname{num} = 'NAILRMA+RPCA';
% 
% M=20;
% stepsize=8;
% 
% tStart = tic;
% if RPCA==5
% [img_RPCA ] = reshape(inexact_alm_rpca(reshape(img_noisy,M*N,p)),M,N,p);
% end
%  opts.r = 5;
%  opts.s = 0.15;
% [img_NAIRPCA,rsvdPSNR,rsvdSSIM] = NAILRMR_denosing(img_RPCA,img_clean,M,stepsize,1,opts);
% %NAIRLMA_denosing(img_RPCA,img_clean,M,stepsize,1);  %NAIRSVD
% runingtime(num) = toc(tStart);
% 
% disp('***********RPCA******** NAILRMA************************'); 
% [PSNR3D(num), PSNRV(:,num),MPSNR(num),SSIMV(:,num),MSSIM(num),UQIV(:,num),MUQI(num),GMSDV(:,num),MGMSD(num),SAM(num)] = QuanAsse(img_clean,img_NAIRPCA); 
% disp(['PNSR3D : ' num2str(PSNR3D(num) ),'  MPSNR: ',num2str(MPSNR(num)), '   MSSIM: ',num2str(MSSIM(num) ),...
%          '   MUQI: ',num2str(MUQI(num)  ),'   MGMSD: ',num2str(MGMSD(num)),'   SAM: ',num2str(SAM(num)), '   time: ',num2str(runingtime(num))]);
% if warning sound(y,Fs);end

%% NonLRMA
% num = 5;
% methodname{num} = 'NonLRMA';
% runingtime(num) = time_Non;
% disp('*********************NonLRMA************************'); 
% [PSNR3D(num), PSNRV(:,num),MPSNR(num),SSIMV(:,num),MSSIM(num),UQIV(:,num),MUQI(num),GMSDV(:,num),MGMSD(num),SAM(num)] = QuanAsse(img_clean,img_Non); 
% disp(['PNSR3D : ' num2str(PSNR3D(num) ),'  MPSNR: ',num2str(MPSNR(num)), '   MSSIM: ',num2str(MSSIM(num) ),...
%          '   MUQI: ',num2str(MUQI(num)  ),'   MGMSD: ',num2str(MGMSD(num)),'   SAM: ',num2str(SAM(num)), '   time: ',num2str(runingtime(num))]);
% if warning; sound(y,Fs);end
%% LRTV denoising
% num = 6;
% methodname{num} = 'LRTV';
% runingtime(num) = time_LRTV;
% disp('***********************LRTV ************************'); 
% [PSNR3D(num), PSNRV(:,num),MPSNR(num),SSIMV(:,num),MSSIM(num),UQIV(:,num),MUQI(num),GMSDV(:,num),MGMSD(num),SAM(num)] = QuanAsse(img_clean,img_LRTV); 
% disp(['PNSR3D : ' num2str(PSNR3D(num) ),'  MPSNR: ',num2str(MPSNR(num)), '   MSSIM: ',num2str(MSSIM(num) ),...
%          '   MUQI: ',num2str(MUQI(num)  ),'   MGMSD: ',num2str(MGMSD(num)),'   SAM: ',num2str(SAM(num)), '   time: ',num2str(runingtime(num))]);
% if warning sound(y,Fs);end
%% Tensor Dictionary Learning
num = 3;
methodname{num} = 'TDL';
runingtime(num) = time_TDL;
disp('*********************** TDL  ************************'); 
[PSNR3D(num), PSNRV(:,num),MPSNR(num),SSIMV(:,num),MSSIM(num),UQIV(:,num),MUQI(num),GMSDV(:,num),MGMSD(num),SAM(num)] = QuanAsse(img_clean,img_TDL); 
disp(['PNSR3D : ' num2str(PSNR3D(num) ),'  MPSNR: ',num2str(MPSNR(num)), '   MSSIM: ',num2str(MSSIM(num) ),...
         '   MUQI: ',num2str(MUQI(num)  ),'   MGMSD: ',num2str(MGMSD(num)),'   SAM: ',num2str(SAM(num)), '   time: ',num2str(runingtime(num))]);
if warning sound(y,Fs);end

% %% TDL + RPCA
% num = num+1;
% methodname{num} = 'TDL';
% 
% [M,N,p] = size(img_noisy);
% tStart = tic;
% 
% % [oriData3_noise ] = reshape(inexact_alm_rpca(reshape(img_noisy,M*N,p)),M,N,p);
% % addpath(genpath('./tensor_dl'));
% vstbmtf_params.peak_value = 1;
% % vstbmtf_params.nsigma = mean(sigma);
% % img_TDL = TensorDL(oriData3_noise, vstbmtf_params);
% img_TDL = TensorDL(img_noisy, vstbmtf_params);
% runingtime(num) = toc(tStart);
% 
% disp('*********************** TDL  ************************'); 
% [PSNR3D(num), PSNRV(:,num),MPSNR(num),SSIMV(:,num),MSSIM(num),UQIV(:,num),MUQI(num),GMSDV(:,num),MGMSD(num),SAM(num)] = QuanAsse(img_clean,img_TDL); 
% disp(['PNSR3D : ' num2str(PSNR3D(num) ),'  MPSNR: ',num2str(MPSNR(num)), '   MSSIM: ',num2str(MSSIM(num) ),...
%          '   MUQI: ',num2str(MUQI(num)  ),'   MGMSD: ',num2str(MGMSD(num)),'   SAM: ',num2str(SAM(num)), '   time: ',num2str(runingtime(num))]);
% if warning sound(y,Fs);end
% 
%% BM4D 
num = 2;
methodname{num} = 'BM4D';
runingtime(num) = time_BM4D;
disp('*********************** BM4D  ************************'); 
[PSNR3D(num), PSNRV(:,num),MPSNR(num),SSIMV(:,num),MSSIM(num),UQIV(:,num),MUQI(num),GMSDV(:,num),MGMSD(num),SAM(num)] = QuanAsse(img_clean,img_BM4D); 
disp(['PNSR3D : ' num2str(PSNR3D(num) ),'  MPSNR: ',num2str(MPSNR(num)), '   MSSIM: ',num2str(MSSIM(num) ),...
         '   MUQI: ',num2str(MUQI(num)  ),'   MGMSD: ',num2str(MGMSD(num)),'   SAM: ',num2str(SAM(num)), '   time: ',num2str(runingtime(num))]);
if warning sound(y,Fs);end
%% LLRGTV  
num = 8;
methodname{num} = 'LLRGTV';
runingtime(num) = time_LLRGTV;
disp('*********************** LLRGTV  ************************'); 
[PSNR3D(num), PSNRV(:,num),MPSNR(num),SSIMV(:,num),MSSIM(num),UQIV(:,num),MUQI(num),GMSDV(:,num),MGMSD(num),SAM(num)] = QuanAsse(img_clean,img_LLRGTV); 
disp(['PNSR3D : ' num2str(PSNR3D(num) ),'  MPSNR: ',num2str(MPSNR(num)), '   MSSIM: ',num2str(MSSIM(num) ),...
         '   MUQI: ',num2str(MUQI(num)  ),'   MGMSD: ',num2str(MGMSD(num)),'   SAM: ',num2str(SAM(num)), '   time: ',num2str(runingtime(num))]);
if warning sound(y,Fs);end
%% LRRSDS
num = 5;
methodname{num} = 'LRRSDS';
runingtime(num) = time_LRRSDS;
disp('*********************** LRRSDS  ************************'); 
[PSNR3D(num), PSNRV(:,num),MPSNR(num),SSIMV(:,num),MSSIM(num),UQIV(:,num),MUQI(num),GMSDV(:,num),MGMSD(num),SAM(num)] = QuanAsse(img_clean,img_LRRSDS); 
disp(['PNSR3D : ' num2str(PSNR3D(num) ),'  MPSNR: ',num2str(MPSNR(num)), '   MSSIM: ',num2str(MSSIM(num) ),...
         '   MUQI: ',num2str(MUQI(num)  ),'   MGMSD: ',num2str(MGMSD(num)),'   SAM: ',num2str(SAM(num)), '   time: ',num2str(runingtime(num))]);
if warning sound(y,Fs);end

%% SSAHTV +RPCA
% num = num+1;
% methodname{num} = 'SSAHTV+RPCA';
% 
% [M,N,p] = size(img_noisy);
% tStart = tic;
% [oriData3_noise ] = reshape(inexact_alm_rpca(reshape(img_noisy,M*N,p)),M,N,p);
% lambda = 0.6;
% sa = 1;
% img_SSAHTVRPCA = tvdenoise(oriData3_noise,lambda,sa,'l1');
% runingtime(num) = toc(tStart);
% 
% disp('********RPCA********** SSAHTV  ************************'); 
% [PSNR3D(num), PSNRV(:,num),MPSNR(num),SSIMV(:,num),MSSIM(num),UQIV(:,num),MUQI(num),GMSDV(:,num),MGMSD(num),SAM(num)] = QuanAsse(img_clean,img_SSAHTVRPCA); 
% disp(['PNSR3D : ' num2str(PSNR3D(num) ),'  MPSNR: ',num2str(MPSNR(num)), '   MSSIM: ',num2str(MSSIM(num) ),...
%          '   MUQI: ',num2str(MUQI(num)  ),'   MGMSD: ',num2str(MGMSD(num)),'   SAM: ',num2str(SAM(num)), '   time: ',num2str(runingtime(num))]);
% 
% if warning sound(y,Fs);end
%% SSAHTV 
% num = 11;
% methodname{num} = 'SSAHTV';
% runingtime(num) = time_SSAHTV;
% disp('*********************** SSAHTV  ************************'); 
% [PSNR3D(num), PSNRV(:,num),MPSNR(num),SSIMV(:,num),MSSIM(num),UQIV(:,num),MUQI(num),GMSDV(:,num),MGMSD(num),SAM(num)] = QuanAsse(img_clean,img_SSAHTV); 
% disp(['PNSR3D : ' num2str(PSNR3D(num) ),'  MPSNR: ',num2str(MPSNR(num)), '   MSSIM: ',num2str(MSSIM(num) ),...
%          '   MUQI: ',num2str(MUQI(num)  ),'   MGMSD: ',num2str(MGMSD(num)),'   SAM: ',num2str(SAM(num)), '   time: ',num2str(runingtime(num))]);
% if warning sound(y,Fs);end
%% BM3D
% num = num+1;
% methodname{num} = 'BM3D';
% 
% [M,N,p] = size(img_noisy);
% tStart = tic;
% img_BM3D   =  img_noisy;
% for k = 1:size(img_noisy,3)
%     [~,  img_BM3D(:,:,k)] = BM3D(1,img_noisy(:,:,k), 255*sigma(k));
% end
% runingtime(num) = toc(tStart);
%     
% disp('******************* band wise BM3D ********************'); 
% [PSNR3D(num), PSNRV(:,num),MPSNR(num),SSIMV(:,num),MSSIM(num),UQIV(:,num),MUQI(num),GMSDV(:,num),MGMSD(num),SAM(num)] = QuanAsse(img_clean,img_BM3D); 
% disp(['PNSR3D : ' num2str(PSNR3D(num) ),'  MPSNR: ',num2str(MPSNR(num)), '   MSSIM: ',num2str(MSSIM(num) ),...
%          '   MUQI: ',num2str(MUQI(num)  ),'   MGMSD: ',num2str(MGMSD(num)),'   SAM: ',num2str(SAM(num)), '   time: ',num2str(runingtime(num))]);
% if warning sound(y,Fs);end

%% SSTV
num = 4;
methodname{num} = 'SSTV';
runingtime(num) = time_SSTV;
disp('************************* SSTV ***************************'); 
[PSNR3D(num), PSNRV(:,num),MPSNR(num),SSIMV(:,num),MSSIM(num),UQIV(:,num),MUQI(num),GMSDV(:,num),MGMSD(num),SAM(num)] = QuanAsse(img_clean,img_SSTV); 
disp(['PNSR3D : ' num2str(PSNR3D(num) ),'  MPSNR: ',num2str(MPSNR(num)), '   MSSIM: ',num2str(MSSIM(num) ),...
         '   MUQI: ',num2str(MUQI(num)  ),'   MGMSD: ',num2str(MGMSD(num)),'   SAM: ',num2str(SAM(num)), '   time: ',num2str(runingtime(num))]);

%% AdHyDe 
num = 10;
methodname{num} = 'AdHyDe';
runingtime(num) = time_adhyde;
disp('***********************AdHyDe ********************'); 
[PSNR3D(num), PSNRV(:,num),MPSNR(num),SSIMV(:,num),MSSIM(num),UQIV(:,num),MUQI(num),GMSDV(:,num),MGMSD(num),SAM(num)] = QuanAsse(img_clean,img_adhyde); 
disp(['PNSR3D : ' num2str(PSNR3D(num) ),'  MPSNR: ',num2str(MPSNR(num)), '   MSSIM: ',num2str(MSSIM(num) ),...
    '   MUQI: ',num2str(MUQI(num)  ),'   MGMSD: ',num2str(MGMSD(num)),'   SAM: ',num2str(SAM(num)), '   time: ',num2str(runingtime(num))]);
%% AdHyDe 
num = 9;
methodname{num} = 'DeepHyDe';
runingtime(num) = time_deep;
disp('*********************DeepHyDe ********************'); 
[PSNR3D(num), PSNRV(:,num),MPSNR(num),SSIMV(:,num),MSSIM(num),UQIV(:,num),MUQI(num),GMSDV(:,num),MGMSD(num),SAM(num)] = QuanAsse(img_clean,img_deep); 
disp(['PNSR3D : ' num2str(PSNR3D(num) ),'  MPSNR: ',num2str(MPSNR(num)), '   MSSIM: ',num2str(MSSIM(num) ),...
    '   MUQI: ',num2str(MUQI(num)  ),'   MGMSD: ',num2str(MGMSD(num)),'   SAM: ',num2str(SAM(num)), '   time: ',num2str(runingtime(num))]);
%%

if warning==-3; sound(y,Fs);end
    
    
    
    
    
    
    