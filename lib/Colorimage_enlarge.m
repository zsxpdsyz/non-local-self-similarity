

num=1
%index=[141,165,191,215];%4
%index=[121,145,151,175]; %17
%index =[221,245,221,245];%21
index = [201,245,201,245]; %23

%% HI
imnameOr=['D:\doc\Mathdoc\图像处理\paper\colorimage','Or_',num2str(num),'.eps'];
imnameOb=['D:\doc\Mathdoc\图像处理\paper\colorimage','Ob_',num2str(num),'.eps'];
imnameTMac=['D:\doc\Mathdoc\图像处理\paper\colorimage','TMac_',num2str(num),'.eps'];
imnameTNN=['D:\doc\Mathdoc\图像处理\paper\colorimage','TNN_',num2str(num),'.eps'];
imnameLRTC_TV_II=['D:\doc\Mathdoc\图像处理\paper\colorimage','LRTC_TV_II_',num2str(num),'.eps'];
imnameSPC_QV=['D:\doc\Mathdoc\图像处理\paper\colorimage','SPC_QV_',num2str(num),'.eps'];
imnameour=['D:\doc\Mathdoc\图像处理\paper\colorimage','our_',num2str(num),'.eps'];

%% Or
I = Y_temsorT;
I1 = ShowEnlargedRectangle(I,[index(1),index(3)], [index(2),index(4)], 3, 1);
figure;imshow(I1,'border','tight','initialmagnification','fit');
set(gcf,'Units','centimeters','Position',[0 0 3 3]); axis square;
screenposition = get(gcf,'Position');
set(gcf,'PaperPosition',[0 0 screenposition([3,3])],'PaperSize',screenposition([3,3]));
%print(imnameOr,'-dpdf');

%% Ob
I = Re_hsi{1}(:,:,num);
I1 = ShowEnlargedRectangle(I,[index(1),index(3)], [index(2),index(4)], 3, 1);
figure;imshow(I1,'border','tight','initialmagnification','fit');
set(gcf,'Units','centimeters','Position',[0 0 3 3]); axis square
screenposition = get(gcf,'Position');
set(gcf,'PaperPosition',[0 0 screenposition([3,3])],'PaperSize',screenposition([3,3]));
%print(imnameOb,'-dpdf');

%% BM4D
I = Re_hsi{2}(:,:,num);
I1 = ShowEnlargedRectangle(I,[index(1),index(3)], [index(2),index(4)], 3, 1);
figure;imshow(I1,'border','tight','initialmagnification','fit');
set(gcf,'Units','centimeters','Position',[0 0 3 3]); axis square;
screenposition = get(gcf,'Position');
set(gcf,'PaperPosition',[0 0 screenposition([3,3])],'PaperSize',screenposition([3,3]));
%print(imnameBM4D,'-dpdf');

%% SSTV
I = Re_hsi{5}(:,:,num);
I1 = ShowEnlargedRectangle(I,[index(1),index(3)], [index(2),index(4)], 3, 1);
figure;imshow(I1,'border','tight','initialmagnification','fit');
set(gcf,'Units','centimeters','Position',[0 0 3 3]); axis square;
screenposition = get(gcf,'Position');
set(gcf,'PaperPosition',[0 0 screenposition([3,3])],'PaperSize',screenposition([3,3]));
%print(imnameSSTV,'-dpdf');

%% LRMR
I = Re_hsi{7}(:,:,num);
I1 = ShowEnlargedRectangle(I,[index(1),index(3)], [index(2),index(4)], 3, 1);
figure;imshow(I1,'border','tight','initialmagnification','fit');
set(gcf,'Units','centimeters','Position',[0 0 3 3]); axis square;
screenposition = get(gcf,'Position');
set(gcf,'PaperPosition',[0 0 screenposition([3,3])],'PaperSize',screenposition([3,3]));
%print(imnameLRMR,'-dpdf');

%% LRTA
I = Re_hsi{4}(:,:,num);
I1 = ShowEnlargedRectangle(I,[index(1),index(3)], [index(2),index(4)], 3, 1);
figure;imshow(I1,'border','tight','initialmagnification','fit');
set(gcf,'Units','centimeters','Position',[0 0 3 3]); axis square;
screenposition = get(gcf,'Position');
set(gcf,'PaperPosition',[0 0 screenposition([3,3])],'PaperSize',screenposition([3,3]));
%print(imnameLRTA,'-dpdf');

%% LRTR
I = Re_hsi{8}(:,:,num);
I1 = ShowEnlargedRectangle(I,[index(1),index(3)], [index(2),index(4)], 3, 1);
figure;imshow(I1,'border','tight','initialmagnification','fit');
set(gcf,'Units','centimeters','Position',[0 0 3 3]); axis square;
screenposition = get(gcf,'Position');
set(gcf,'PaperPosition',[0 0 screenposition([3,3])],'PaperSize',screenposition([3,3]));
%print(imnameLRTR,'-dpdf');

%% our
I = Re_hsi{9}(:,:,num);
I1 = ShowEnlargedRectangle(I,[index(1),index(3)], [index(2),index(4)], 3, 1);
figure;imshow(I1,'border','tight','initialmagnification','fit');
set(gcf,'Units','centimeters','Position',[0 0 3 3]); axis square;
screenposition = get(gcf,'Position');
set(gcf,'PaperPosition',[0 0 screenposition([3,3])],'PaperSize',screenposition([3,3]));
%print(imnameour,'-dpdf');


