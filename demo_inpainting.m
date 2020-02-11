clc
clear all
close all
addpath(genpath('lib'));
addpath(genpath('testData'));
%% 第一类：曲线
% 可以用PPT先画出来自己想要的曲线，然后保存成 .png 格式的图片，由matlab读出来
load('sails.mat');
Ori = X.*255;
%Ori = double(imread('sailboat.bmp'));        % 原始清晰图像
X   = double(imread('ppt1.png'));    % 含有曲线的ppt保存的图片
X   = X( 19:274,44:299);                  % 将画的曲线截成 256*256 图像
%17:272, 1019:1274  656:911,108:363
X = 255 - X;
known = find( X < 255 );                  % 像素值可能在0到255之间，将像素值小于255的变成0
X(known) = 0;
XX = zeros(size(Ori));
XX(:,:,1) = X;
XX(:,:,2) = X;
XX(:,:,3) = X;
index = find( XX == 255 );               % 已知点的位置
data  = Ori(index);                      % 已知点的像素值
Obe   = zeros(size(Ori));
Obe(index) = data;                       % 产生观测图像
figure,imshow(uint8(Obe));

Y_tensorT = double(Ori)./255;
X = Y_tensorT;
data = double(data)./255;
known = index;
Y_tensor0 = double(Obe)./255;
%% 第二类：数字、字母

I = double(imread('house.bmp'))/255;
text_str = cell(3,1);
conf_val = [85.212 98.76 78.342]; 
for ii=1:3
   text_str{ii} = ['Confidence: ' num2str(conf_val(ii),'%0.2f') '%'];
end
position = [23 373;35 185;77 107]; 
RGB = insertText(I,position,text_str,'FontSize',18,'BoxColor',...
   'w','BoxOpacity',0,'TextColor','white');
figure
imshow(RGB)


%% 第三类：黑色条带
% 随机的

Ori = double(imread('house.bmp'));
[n1,n2,~] = size(Ori);
% 
X = ones( n1, n2 )*255;
a = [2:5, 44:46, 74:77, 80:81, 102:103, 134:135, 165:166, 183:184, 223:226, 246:247];    % 2:5 从第二行开始，宽度为4的条带    % 随机产生
b = [16:17, 26:30, 44:45, 54:55, 86:87, 136:137, 139:141, 200:201, 238:241, 249:250];    % 26:30 从第26列开始，宽度为5的条带
X(a,:) = 0;
X(:,b) = 0;

XX = ones(size(Ori))*255;
XX(:,:,1) = X;
XX(:,:,2) = X;
XX(:,:,3) = X;
index = find( XX == 255 );
data  = Ori(index);
Obe   = zeros(size(Ori));
Obe(index) = data;              % 产生观测图像
figure,imshow(uint8(Obe));

%% 第四类：标注图像某个区域
% 在MATLAB中，使用roipoly来选择一个感兴趣区域（ROI），该函数将生成一个多边形的ROI;
% 函数的用法为：B = roipoly（f，c，r）；
%     其中f为要处理的图像，c和r分别是ROI的顶点对应的列坐标和行坐标（按顺序排列）
%     B为一幅二值图像，大小与f相同，ROI之外为0，之内为1。
%     图像B通常用做将操作限制在感兴区域内的一个模板。
%     定点坐标的原点在左上角。

Ori = double(imread('house.bmp'));
roipoly
% figure, imshow(B);

XX = zeros(size(Ori));
XX(:,:,1) = B;
XX(:,:,2) = B;
XX(:,:,3) = B;

index = find( XX == 0 );
data  = Ori(index);
Obe   = zeros(size(Ori));
Obe(index) = data;              % 产生观测图像
figure,imshow(uint8(Obe));
