v=23;
h=12;
SR=10;
methodname    = {'Observed' 'TMac','LRTC-TVI','LRTC-TVII','SPC-QV','TNN','PSTNN','t-TNN','WSTNN','NLS-LR'};;
enList = [1 2 4 5 6 7];
%%
%Y_tensorT = transdir1(Y_tensorT);
%for i = 1 : length(enList)
%    Re_tensor{enList(i)} = transdir1(Re_tensor{enList(i)});
%end
%% MSI:
imnameOr = ['D:\doc\mathdoc\图像处理\NL-LRTC\Els_paper\figure\Or_',num2str(v),'_',num2str(SR),'.eps'];
imnameOb = ['D:\doc\mathdoc\图像处理\NL-LRTC\Els_paper\figure\Ob_',num2str(v),'_',num2str(SR),'.eps'];
imnameTMac = ['D:\doc\mathdoc\图像处理\NL-LRTC\Els_paper\figure\TMac_',num2str(v),'_',num2str(SR),'.eps'];
imnameTVII = ['D:\doc\mathdoc\图像处理\NL-LRTC\Els_paper\figure\TVII_',num2str(v),'_',num2str(SR),'.eps'];
imnameSPC_QV = ['D:\doc\mathdoc\图像处理\NL-LRTC\Els_paper\figure\SPC_QV_',num2str(v),'_',num2str(SR),'.eps'];
imnameTNN = ['D:\doc\mathdoc\图像处理\NL-LRTC\Els_paper\figure\TNN_',num2str(v),'_',num2str(SR),'.eps'];
imnameNLS_LR = ['D:\doc\mathdoc\图像处理\NL-LRTC\Els_paper\figure\NLS_LR_',num2str(v),'_',num2str(SR),'.eps'];


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
%figure,
Y_tensorT = enlarge(Y_tensorT(:,:,h));
%imshow(Y_tensorT,'border','tight','initialmagnification','fit'),%title('Original','fontname','Times New Roman','fontsize',72,'fontweight','bold')
%set(gcf,'PaperPosition',[0,0,22,22]);
%axis normal
%axis square
print(gcf,'-depsc',imnameOr)

%figure,imshow(Re_tensor{1},'border','tight','initialmagnification','fit'),%title('Observed','fontname','Times New Roman','fontsize',72,'fontweight','bold')
%set(gcf,'PaperPosition',[0,0,22,22]);
%axis normal
%axis square
enlarge(Re_tensor{1}(:,:,h));
print(gcf,'-depsc',imnameOb)

enlarge(Re_tensor{2}(:,:,h));
print(gcf,'-depsc',imnameTMac)

enlarge(Re_tensor{4}(:,:,h));
print(gcf,'-depsc',imnameTVII)

enlarge(Re_tensor{5}(:,:,h));
print(gcf,'-depsc',imnameSPC_QV)

enlarge(Re_tensor{6}(:,:,h));
print(gcf,'-depsc',imnameTNN)

enlarge(Re_tensor{7}(:,:,h));
print(gcf,'-depsc',imnameNLS_LR)


