%To assess the quality of a given image
% clear
templateModel = load('templateModel_AVIRIS.mat');
templateModel = templateModel.templateModel;
mu_prisparam = templateModel{1};
cov_prisparam = templateModel{2};
meanOfSampleData = templateModel{3};
principleVectors = templateModel{4};



% load tr_1
% tr_data=tr_data(1:512,1:512,1:162);
%load reconstrcucted
FI_HSI = img_noisy;
% FI_HSI = img_deep;%reconstructed;
% FI_HSI = img_BM4D;
% % FI_HSI = img_TDL;
% FI_HSI = img_SSTV;
% FI_HSI = img_LRRSDS;
% FI_HSI = img_DeepHyDe;
% FI_HSI = img_LRMR;
%  FI_HSI = img_NMoG;
% FI_HSI = img_LLRGTV;
%%
for num=1:size(FI_HSI,3)
    FI_HSI(:,:,num)=(FI_HSI(:,:,num)-min(min(FI_HSI(:,:,num))))/(max(max(FI_HSI(:,:,num)))-min(min(FI_HSI(:,:,num))));
end
% 	tmp(:,:,1)=FI_HSI(:,:,105);tmp(:,:,2)=FI_HSI(:,:,110);tmp(:,:,3)=FI_HSI(:,:,8);
  tmp(:,:,1)=FI_HSI(:,:,30);tmp(:,:,2)=FI_HSI(:,:,20);tmp(:,:,3)=FI_HSI(:,:,10);   % extract red, green, blue bands

imDis=tmp;data=FI_HSI;
metricValue2 = computequality(single(imDis),mu_prisparam,cov_prisparam,principleVectors,meanOfSampleData,single(data))

