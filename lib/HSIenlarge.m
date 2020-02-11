

band=131;
%index=[141,165,191,215];%4
%index=[121,145,151,175]; %17
%index =[221,245,221,245];%21
index = [201,245,201,245]; %23

%% HI
imnameOr=['C:\Users\yugang\Desktop\igarss_3DTNN\figs\','Or2_',num2str(band),'.pdf'];
imnameOb=['C:\Users\yugang\Desktop\igarss_3DTNN\figs\','Ob2_',num2str(band),'.pdf'];
imnameBM4D=['C:\Users\yugang\Desktop\igarss_3DTNN\figs\','BM4D2_',num2str(band),'.pdf'];
imnameSSTV=['C:\Users\yugang\Desktop\igarss_3DTNN\figs\','SSTV2_',num2str(band),'.pdf'];
imnameLRMR=['C:\Users\yugang\Desktop\igarss_3DTNN\figs\','LRMR2_',num2str(band),'.pdf'];
imnameLRTA=['C:\Users\yugang\Desktop\igarss_3DTNN\figs\','LRTA2_',num2str(band),'.pdf'];
imnameLRTR=['C:\Users\yugang\Desktop\igarss_3DTNN\figs\','LRTR2_',num2str(band),'.pdf'];
imnameour=['C:\Users\yugang\Desktop\igarss_3DTNN\figs\','our2_',num2str(band),'.pdf'];

%% Or
I = Ohsi(:,:,band);
I1 = ShowEnlargedRectangle(I,[index(1),index(3)], [index(2),index(4)], 3, 1);
figure;imshow(I1,'border','tight','initialmagnification','fit');
set(gcf,'Units','centimeters','Position',[0 0 3 3]); axis square;
screenposition = get(gcf,'Position');
set(gcf,'PaperPosition',[0 0 screenposition([3,3])],'PaperSize',screenposition([3,3]));
%print(imnameOr,'-dpdf');

%% Ob
I = Re_hsi{1}(:,:,band);
I1 = ShowEnlargedRectangle(I,[index(1),index(3)], [index(2),index(4)], 3, 1);
figure;imshow(I1,'border','tight','initialmagnification','fit');
set(gcf,'Units','centimeters','Position',[0 0 3 3]); axis square
screenposition = get(gcf,'Position');
set(gcf,'PaperPosition',[0 0 screenposition([3,3])],'PaperSize',screenposition([3,3]));
%print(imnameOb,'-dpdf');

%% BM4D
I = Re_hsi{2}(:,:,band);
I1 = ShowEnlargedRectangle(I,[index(1),index(3)], [index(2),index(4)], 3, 1);
figure;imshow(I1,'border','tight','initialmagnification','fit');
set(gcf,'Units','centimeters','Position',[0 0 3 3]); axis square;
screenposition = get(gcf,'Position');
set(gcf,'PaperPosition',[0 0 screenposition([3,3])],'PaperSize',screenposition([3,3]));
%print(imnameBM4D,'-dpdf');

%% SSTV
I = Re_hsi{5}(:,:,band);
I1 = ShowEnlargedRectangle(I,[index(1),index(3)], [index(2),index(4)], 3, 1);
figure;imshow(I1,'border','tight','initialmagnification','fit');
set(gcf,'Units','centimeters','Position',[0 0 3 3]); axis square;
screenposition = get(gcf,'Position');
set(gcf,'PaperPosition',[0 0 screenposition([3,3])],'PaperSize',screenposition([3,3]));
%print(imnameSSTV,'-dpdf');

%% LRMR
I = Re_hsi{7}(:,:,band);
I1 = ShowEnlargedRectangle(I,[index(1),index(3)], [index(2),index(4)], 3, 1);
figure;imshow(I1,'border','tight','initialmagnification','fit');
set(gcf,'Units','centimeters','Position',[0 0 3 3]); axis square;
screenposition = get(gcf,'Position');
set(gcf,'PaperPosition',[0 0 screenposition([3,3])],'PaperSize',screenposition([3,3]));
%print(imnameLRMR,'-dpdf');

%% LRTA
I = Re_hsi{4}(:,:,band);
I1 = ShowEnlargedRectangle(I,[index(1),index(3)], [index(2),index(4)], 3, 1);
figure;imshow(I1,'border','tight','initialmagnification','fit');
set(gcf,'Units','centimeters','Position',[0 0 3 3]); axis square;
screenposition = get(gcf,'Position');
set(gcf,'PaperPosition',[0 0 screenposition([3,3])],'PaperSize',screenposition([3,3]));
%print(imnameLRTA,'-dpdf');

%% LRTR
I = Re_hsi{8}(:,:,band);
I1 = ShowEnlargedRectangle(I,[index(1),index(3)], [index(2),index(4)], 3, 1);
figure;imshow(I1,'border','tight','initialmagnification','fit');
set(gcf,'Units','centimeters','Position',[0 0 3 3]); axis square;
screenposition = get(gcf,'Position');
set(gcf,'PaperPosition',[0 0 screenposition([3,3])],'PaperSize',screenposition([3,3]));
%print(imnameLRTR,'-dpdf');

%% our
I = Re_hsi{9}(:,:,band);
I1 = ShowEnlargedRectangle(I,[index(1),index(3)], [index(2),index(4)], 3, 1);
figure;imshow(I1,'border','tight','initialmagnification','fit');
set(gcf,'Units','centimeters','Position',[0 0 3 3]); axis square;
screenposition = get(gcf,'Position');
set(gcf,'PaperPosition',[0 0 screenposition([3,3])],'PaperSize',screenposition([3,3]));
%print(imnameour,'-dpdf');


