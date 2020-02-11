
num = 0;
load train
warning = 0;
RPCA = 5;
clear PSNRV SSIMV UQIV GMSDV
%%
num = 1;
methodname{1} = 'noisy';
runingtime(num) = 0;
img_clean_AT = img_clean;
img_noisy_AT = img_noisy;
img_clean = ori_clean;
img_noisy = ori_noisy;
disp('*********************** noisy ************************'); 
[PSNR3D(num), PSNRV(:,num),MPSNR(num),SSIMV(:,num),MSSIM(num),UQIV(:,num),MUQI(num),GMSDV(:,num),MGMSD(num),SAM(num)] = QuanAsse(img_clean,img_noisy); 

disp(['PNSR3D : ' num2str(PSNR3D(num) ),'  MPSNR: ',num2str(MPSNR(num)), '   MSSIM: ',num2str(MSSIM(num) ),...
    '   MUQI: ',num2str(MUQI(num)  ),'   MGMSD: ',num2str(MGMSD(num)),'   SAM: ',num2str(SAM(num)), '   time: ',num2str(runingtime(num))]);

%%    Denoising Hyperspectral Image With Non-i.i.d. Noise Structure  IEEE TCyb
num = 7;
img_NMoG_AT = img_NMoG;
img_NMoG = img_NMoG*max_val;
img_NMoG = (img_NMoG/2).^2-3/8;

methodname{num} = 'NMoG';
runingtime(num) = time_NMoG;
disp('*********************** NMoG ************************'); 
[PSNR3D(num), PSNRV(:,num),MPSNR(num),SSIMV(:,num),MSSIM(num),UQIV(:,num),MUQI(num),GMSDV(:,num),MGMSD(num),SAM(num)] = QuanAsse(img_clean,img_NMoG); 
disp(['PNSR3D : ' num2str(PSNR3D(num) ),'  MPSNR: ',num2str(MPSNR(num)), '   MSSIM: ',num2str(MSSIM(num) ),...
         '   MUQI: ',num2str(MUQI(num)  ),'   MGMSD: ',num2str(MGMSD(num)),'   SAM: ',num2str(SAM(num)), '   time: ',num2str(runingtime(num))]);
if warning; sound(y,Fs);end

%%   LRMR
num = 6;
img_LRMR_AT = img_LRMR;
img_LRMR = img_LRMR*max_val;
img_LRMR = (img_LRMR/2).^2-3/8;
methodname{num} = 'LRMR';
runingtime(num) = time_LRMR;
disp('*********************** LRMR ************************'); 
[PSNR3D(num), PSNRV(:,num),MPSNR(num),SSIMV(:,num),MSSIM(num),UQIV(:,num),MUQI(num),GMSDV(:,num),MGMSD(num),SAM(num)] = QuanAsse(img_clean,img_LRMR); 
disp(['PNSR3D : ' num2str(PSNR3D(num) ),'  MPSNR: ',num2str(MPSNR(num)), '   MSSIM: ',num2str(MSSIM(num) ),...
         '   MUQI: ',num2str(MUQI(num)  ),'   MGMSD: ',num2str(MGMSD(num)),'   SAM: ',num2str(SAM(num)), '   time: ',num2str(runingtime(num))]);
if warning sound(y,Fs);end

%% Tensor Dictionary Learning
num = 3;
img_TDL_AT = img_TDL;
img_TDL = img_TDL*max_val;
img_TDL = (img_TDL/2).^2-3/8;
methodname{num} = 'TDL';
runingtime(num) = time_TDL;
disp('*********************** TDL  ************************'); 
[PSNR3D(num), PSNRV(:,num),MPSNR(num),SSIMV(:,num),MSSIM(num),UQIV(:,num),MUQI(num),GMSDV(:,num),MGMSD(num),SAM(num)] = QuanAsse(img_clean,img_TDL); 
disp(['PNSR3D : ' num2str(PSNR3D(num) ),'  MPSNR: ',num2str(MPSNR(num)), '   MSSIM: ',num2str(MSSIM(num) ),...
         '   MUQI: ',num2str(MUQI(num)  ),'   MGMSD: ',num2str(MGMSD(num)),'   SAM: ',num2str(SAM(num)), '   time: ',num2str(runingtime(num))]);
if warning sound(y,Fs);end

%% BM4D 
num = 2;
img_BM4D_AT = img_BM4D;
img_BM4D = img_BM4D*max_val;
img_BM4D = (img_BM4D/2).^2-3/8;methodname{num} = 'BM4D';
runingtime(num) = time_BM4D;
disp('*********************** BM4D  ************************'); 
[PSNR3D(num), PSNRV(:,num),MPSNR(num),SSIMV(:,num),MSSIM(num),UQIV(:,num),MUQI(num),GMSDV(:,num),MGMSD(num),SAM(num)] = QuanAsse(img_clean,img_BM4D); 
disp(['PNSR3D : ' num2str(PSNR3D(num) ),'  MPSNR: ',num2str(MPSNR(num)), '   MSSIM: ',num2str(MSSIM(num) ),...
         '   MUQI: ',num2str(MUQI(num)  ),'   MGMSD: ',num2str(MGMSD(num)),'   SAM: ',num2str(SAM(num)), '   time: ',num2str(runingtime(num))]);
if warning sound(y,Fs);end
%% LLRGTV  
num = 8;
img_LLRGTV_AT = img_LLRGTV;
img_LLRGTV = img_LLRGTV*max_val;
img_LLRGTV = (img_LLRGTV/2).^2-3/8;
methodname{num} = 'LLRGTV';
runingtime(num) = time_LLRGTV;
disp('*********************** LLRGTV  ************************'); 
[PSNR3D(num), PSNRV(:,num),MPSNR(num),SSIMV(:,num),MSSIM(num),UQIV(:,num),MUQI(num),GMSDV(:,num),MGMSD(num),SAM(num)] = QuanAsse(img_clean,img_LLRGTV); 
disp(['PNSR3D : ' num2str(PSNR3D(num) ),'  MPSNR: ',num2str(MPSNR(num)), '   MSSIM: ',num2str(MSSIM(num) ),...
         '   MUQI: ',num2str(MUQI(num)  ),'   MGMSD: ',num2str(MGMSD(num)),'   SAM: ',num2str(SAM(num)), '   time: ',num2str(runingtime(num))]);
if warning sound(y,Fs);end
%% LRRSDS
num = 5;
img_LRRSDS_AT = img_LRRSDS;
img_LRRSDS = img_LRRSDS*max_val;
img_LRRSDS = (img_LRRSDS/2).^2-3/8;methodname{num} = 'LRRSDS';
runingtime(num) = time_LRRSDS;
disp('*********************** LRRSDS  ************************'); 
[PSNR3D(num), PSNRV(:,num),MPSNR(num),SSIMV(:,num),MSSIM(num),UQIV(:,num),MUQI(num),GMSDV(:,num),MGMSD(num),SAM(num)] = QuanAsse(img_clean,img_LRRSDS); 
disp(['PNSR3D : ' num2str(PSNR3D(num) ),'  MPSNR: ',num2str(MPSNR(num)), '   MSSIM: ',num2str(MSSIM(num) ),...
         '   MUQI: ',num2str(MUQI(num)  ),'   MGMSD: ',num2str(MGMSD(num)),'   SAM: ',num2str(SAM(num)), '   time: ',num2str(runingtime(num))]);
if warning sound(y,Fs);end

%% SSTV
img_SSTV_AT = img_SSTV;
img_SSTV = img_SSTV*max_val;
img_SSTV = (img_SSTV/2).^2-3/8;
num = 4;
methodname{num} = 'SSTV';
runingtime(num) = time_SSTV;
disp('************************* SSTV ***************************'); 
[PSNR3D(num), PSNRV(:,num),MPSNR(num),SSIMV(:,num),MSSIM(num),UQIV(:,num),MUQI(num),GMSDV(:,num),MGMSD(num),SAM(num)] = QuanAsse(img_clean,img_SSTV); 
disp(['PNSR3D : ' num2str(PSNR3D(num) ),'  MPSNR: ',num2str(MPSNR(num)), '   MSSIM: ',num2str(MSSIM(num) ),...
         '   MUQI: ',num2str(MUQI(num)  ),'   MGMSD: ',num2str(MGMSD(num)),'   SAM: ',num2str(SAM(num)), '   time: ',num2str(runingtime(num))]);

%% AdHyDe  
img_adhyde_AT = img_adhyde;
img_adhyde = img_adhyde*max_val;
img_adhyde = (img_adhyde/2).^2-3/8;
num = 10;
methodname{num} = 'AdHyDe';
runingtime(num) = time_adhyde;
disp('***********************AdHyDe ********************'); 
[PSNR3D(num), PSNRV(:,num),MPSNR(num),SSIMV(:,num),MSSIM(num),UQIV(:,num),MUQI(num),GMSDV(:,num),MGMSD(num),SAM(num)] = QuanAsse(img_clean,img_adhyde); 
disp(['PNSR3D : ' num2str(PSNR3D(num) ),'  MPSNR: ',num2str(MPSNR(num)), '   MSSIM: ',num2str(MSSIM(num) ),...
    '   MUQI: ',num2str(MUQI(num)  ),'   MGMSD: ',num2str(MGMSD(num)),'   SAM: ',num2str(SAM(num)), '   time: ',num2str(runingtime(num))]);
%% AdHyDe DEEP
img_deep_AT = img_deep;
img_deep = img_deep*max_val;
img_deep = (img_deep/2).^2-3/8;
num = 9;
methodname{num} = 'DeepHyDe';
runingtime(num) = time_deep;
disp('*********************DeepHyDe ********************'); 
[PSNR3D(num), PSNRV(:,num),MPSNR(num),SSIMV(:,num),MSSIM(num),UQIV(:,num),MUQI(num),GMSDV(:,num),MGMSD(num),SAM(num)] = QuanAsse(img_clean,img_deep); 
disp(['PNSR3D : ' num2str(PSNR3D(num) ),'  MPSNR: ',num2str(MPSNR(num)), '   MSSIM: ',num2str(MSSIM(num) ),...
    '   MUQI: ',num2str(MUQI(num)  ),'   MGMSD: ',num2str(MGMSD(num)),'   SAM: ',num2str(SAM(num)), '   time: ',num2str(runingtime(num))]);
%%
I = 1:10;% 2];
    disp('the reults after the inverse Anscombe transform:');
fprintf('                        method name  ');  for i = I; 	fprintf('& %s   ',methodname{i});   end; fprintf('\n');
fprintf('                           & MPSNR   ');  for i = I; 	fprintf('& %4.3f  ',MPSNR(i));      end; fprintf('\\\\\n');
fprintf('                          && MSSIM   ');  for i = I; 	fprintf('& %.5f ',MSSIM(i));        end; fprintf('\\\\\n');
fprintf('                          && MUQI    ');  for i = I; 	fprintf('& %.5f ',MUQI(i));         end; fprintf('\\\\\n');
fprintf('                          && SAM     ');  for i = I; 	fprintf('& %.5f ',SAM(i));          end; fprintf('\\\\\n');
fprintf('                          && MGMSD   ');  for i = I; 	fprintf('& %.5f ',MGMSD(i));        end; fprintf('\\\\\n');
fprintf('                     && running time ');  for i = I; 	fprintf('&  %.0f ',runingtime(i));  end; fprintf('\\\\\n');
if warning==-3; sound(y,Fs);end
    
    
    
    
    
    
    