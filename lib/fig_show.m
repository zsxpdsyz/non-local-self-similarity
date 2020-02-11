v=11;
h=138;
SR=10;
%methodname    = {'Observed' 'Tmac','LRTC-TVI','BCPF','logDet','TNN','PSTNN','t-TNN','WSTNN','P3_Y1'};
enList = [1 2 4 5 6 7];
%%
%Y_tensorT = transdir1(Y_tensorT);
%for i = 1 : length(enList)
%    Re_tensor{enList(i)} = transdir1(Re_tensor{enList(i)});
%end
%% videos:
imnameOr = ['D:\doc\Mathdoc\图像处理\NL-LRTC\Els_paper\figure\Or_',num2str(v),'_',num2str(h),'_',num2str(SR),'.eps'];
imnameOb = ['D:\doc\Mathdoc\图像处理\NL-LRTC\Els_paper\figure\Ob_',num2str(v),'_',num2str(h),'_',num2str(SR),'.eps'];
imnameTMac = ['D:\doc\Mathdoc\图像处理\NL-LRTC\Els_paper\figure\TMac_',num2str(v),'_',num2str(h),'_',num2str(SR),'.eps'];
imnameTVII = ['D:\doc\Mathdoc\图像处理\NL-LRTC\Els_paper\figure\TVII_',num2str(v),'_',num2str(h),'_',num2str(SR),'.eps'];
imnameTNN = ['D:\doc\Mathdoc\图像处理\NL-LRTC\Els_paper\figure\TNN_',num2str(v),'_',num2str(h),'_',num2str(SR),'.eps'];
imnameSPC_QV = ['D:\doc\Mathdoc\图像处理\NL-LRTC\Els_paper\figure\SPC_QV_',num2str(v),'_',num2str(h),'_',num2str(SR),'.eps'];
imnameNLS_LR = ['D:\doc\Mathdoc\图像处理\NL-LRTC\Els_paper\figure\NLS_LR_',num2str(v),'_',num2str(h),'_',num2str(SR),'.eps'];
% %% videos
% imnameOr=['C:\Users\yugang\Desktop\AMMrevise1\figs\videos\Or_',num2str(v),'_',num2str(h),'_',num2str(SR),'.eps'];
% imnameOb=['C:\Users\yugang\Desktop\AMMrevise1\figs\videos\Ob_',num2str(v),'_',num2str(h),'_',num2str(SR),'.eps'];
% imnameTMac=['C:\Users\yugang\Desktop\AMMrevise1\figs\videos\TMac_',num2str(v),'_',num2str(h),'_',num2str(SR),'.eps'];
% imnameTV=['C:\Users\yugang\Desktop\AMMrevise1\figs\videos\TV_',num2str(v),'_',num2str(h),'_',num2str(SR),'.eps'];
% imnameF=['C:\Users\yugang\Desktop\AMMrevise1\figs\videos\F_',num2str(v),'_',num2str(h),'_',num2str(SR),'.eps'];
% imnameSPC=['C:\Users\yugang\Desktop\AMMrevise1\figs\videos\SPC_',num2str(v),'_',num2str(h),'_',num2str(SR),'.eps'];
% imnameTCTV=['C:\Users\yugang\Desktop\AMMrevise1\figs\videos\TCTV_',num2str(v),'_',num2str(h),'_',num2str(SR),'.eps'];
% imnameFT=['C:\Users\yugang\Desktop\AMMrevise1\figs\videos\FT_',num2str(v),'_',num2str(h),'_',num2str(SR),'.eps'];
% 



%% MRI:
%imnameOr = ['D:\doc\Mathdoc\图像处理\paper\MRI\Or_',num2str(v),'_',num2str(h),'_',num2str(SR),'.eps'];
%imnameOb = ['D:\doc\Mathdoc\图像处理\paper\MRI\Ob_',num2str(v),'_',num2str(h),'_',num2str(SR),'.eps'];
%imnameTMac = ['D:\doc\Mathdoc\图像处理\paper\MRI\Tmac_',num2str(v),'_',num2str(h),'_',num2str(SR),'.eps'];
%imnameTVI = ['D:\doc\Mathdoc\图像处理\paper\MRI\TVI_',num2str(v),'_',num2str(h),'_',num2str(SR),'.eps'];
%imnameTNN = ['D:\doc\Mathdoc\图像处理\paper\MRI\TNN_',num2str(v),'_',num2str(h),'_',num2str(SR),'.eps'];
%imnameNL_LRTC = ['D:\doc\Mathdoc\图像处理\paper\MRI\P3_Y1_',num2str(v),'_',num2str(h),'_',num2str(SR),'.eps'];

%% MSI:
%imnameOr = ['D:\doc\Mathdoc\图像处理\paper\MSI\Or_',num2str(v),'_',num2str(h),'_',num2str(SR),'.eps'];
%imnameOb = ['D:\doc\Mathdoc\图像处理\paper\MSI\Ob_',num2str(v),'_',num2str(h),'_',num2str(SR),'.eps'];
%imnameTMac = ['D:\doc\Mathdoc\图像处理\paper\MSI\Tmac_',num2str(v),'_',num2str(h),'_',num2str(SR),'.eps'];
%imnameTVI = ['D:\doc\Mathdoc\图像处理\paper\MSI\TVI_',num2str(v),'_',num2str(h),'_',num2str(SR),'.eps'];
%imnameTNN = ['D:\doc\Mathdoc\图像处理\paper\MSI\TNN_',num2str(v),'_',num2str(h),'_',num2str(SR),'.eps'];
%imnameNL_LRTC = ['D:\doc\Mathdoc\图像处理\paper\MSI\P3_Y1_',num2str(v),'_',num2str(h),'_',num2str(SR),'.eps'];


%%
% figure,
% imshow(Y_tensorT(:,:,h),'border','tight','initialmagnification','fit'),%title('Original','fontname','Times New Roman','fontsize',72,'fontweight','bold')
% set(gcf,'PaperPosition',[0,0,18,22]);
% %axis normal
% print(gcf,'-depsc',imnameOr)
% 
% figure,imshow(Y_tensor0(:,:,h),'border','tight','initialmagnification','fit'),%title('Observed','fontname','Times New Roman','fontsize',72,'fontweight','bold')
% set(gcf,'PaperPosition',[0,0,18,22]);
% %axis normal
% print(gcf,'-depsc',imnameOb)
% 
% 
% figure, 
% imshow(Y_tensor_yin(:,:,h),'border','tight','initialmagnification','fit'),%title('TMac','fontname','Times New Roman','fontsize',72,'fontweight','bold')
% set(gcf,'PaperPosition',[0,0,18,22]);
% %axis normal
% print(gcf,'-depsc',imnameTMac)
% 
% 
% figure,imshow(Y_TV(:,:,h),'border','tight','initialmagnification','fit'),%title('TV','fontname','Times New Roman','fontsize',72,'fontweight','bold')
% set(gcf,'PaperPosition',[0,0,18,22]);
% %axis normal
% print(gcf,'-depsc',imnameTV)
% 
% 
% figure,imshow(Y_tensor_F(:,:,h),'border','tight','initialmagnification','fit'),%title('Framelet','fontname','Times New Roman','fontsize',72,'fontweight','bold')
% set(gcf,'PaperPosition',[0,0,18,22]);
% %axis normal
% print(gcf,'-depsc',imnameF)
% 
% 
% 
% figure,imshow(Re_tensor{5}(:,:,h)/255,'border','tight','initialmagnification','fit'),%title('Framelet','fontname','Times New Roman','fontsize',72,'fontweight','bold')
% set(gcf,'PaperPosition',[0,0,18,22]);
% %axis normal
% print(gcf,'-depsc',imnameSPC)
% 
% 
% figure,imshow(Re_tensor{6}(:,:,h),'border','tight','initialmagnification','fit'),%title('Framelet','fontname','Times New Roman','fontsize',72,'fontweight','bold')
% set(gcf,'PaperPosition',[0,0,18,22]);
% %axis normal
% print(gcf,'-depsc',imnameTCTV)
% 
% 
% 
% figure,imshow(Re_SMF(:,:,h),'border','tight','initialmagnification','fit'),%title('SMF-LRTC','fontname','Times New Roman','fontsize',72,'fontweight','bold')
% set(gcf,'PaperPosition',[0,0,18,22]);
% %axis normal
% print(gcf,'-depsc',imnameFT)
% %%


%%
figure,
imshow(Y_tensorT(:,:,h),'border','tight','initialmagnification','fit'),%title('Original','fontname','Times New Roman','fontsize',72,'fontweight','bold')
set(gcf,'PaperPosition',[0,0,22,22]);
axis normal
%axis square
print(gcf,'-depsc',imnameOr)

figure,imshow(Re_tensor{1}(:,:,h),'border','tight','initialmagnification','fit'),%title('Observed','fontname','Times New Roman','fontsize',72,'fontweight','bold')
set(gcf,'PaperPosition',[0,0,22,22]);
axis normal
%axis square
print(gcf,'-depsc',imnameOb)


figure, 
imshow(Re_tensor{2}(:,:,h),'border','tight','initialmagnification','fit'),%title('TMac','fontname','Times New Roman','fontsize',72,'fontweight','bold')
set(gcf,'PaperPosition',[0,0,22,22]);
axis normal
%axis square
print(gcf,'-depsc',imnameTMac)


figure,imshow(Re_tensor{4}(:,:,h),'border','tight','initialmagnification','fit'),%title('TV','fontname','Times New Roman','fontsize',72,'fontweight','bold')
set(gcf,'PaperPosition',[0,0,22,22]);
axis normal
%axis square
print(gcf,'-depsc',imnameTVII)


figure,imshow(Re_tensor{5}(:,:,h),'border','tight','initialmagnification','fit'),%title('Framelet','fontname','Times New Roman','fontsize',72,'fontweight','bold')
set(gcf,'PaperPosition',[0,0,22,22]);
axis normal
%axis square
print(gcf,'-depsc',imnameSPC_QV)


figure,imshow(Re_tensor{6}(:,:,h),'border','tight','initialmagnification','fit'),%title('Framelet','fontname','Times New Roman','fontsize',72,'fontweight','bold')
set(gcf,'PaperPosition',[0,0,22,22]);
axis normal
%axis square
print(gcf,'-depsc',imnameTNN)

figure,imshow(Re_tensor{7}(:,:,h),'border','tight','initialmagnification','fit'),%title('Framelet','fontname','Times New Roman','fontsize',72,'fontweight','bold')
set(gcf,'PaperPosition',[0,0,22,22]);
axis normal
%axis square
print(gcf,'-depsc',imnameNLS_LR)


