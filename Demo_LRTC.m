%% =================================================================
% This script compares low-rank tensor completion methods
% listed as follows:
%     1. TMac       
%     2. LRTC-TV-I     
%     3. LRTC-TV-II          
%     4. SPC-QV        
%     5. TNN           t-SVD based method                                                                                                                                                       
%     6. NL-LRTC       our proposed model
% You can:
%     1. Type 'Demo_LRTC' to to run various methods and see the pre-computed results.
%     2. Select competing methods by turn on/off the enable-bits in Demo_LRTC.m
%
% More detail can be found in [1]
% [1] Xiao-Tong Li, Xi-Le Zhao, Tai-Xiang Jiang, Yu-Bang Zheng, Teng-Yu Ji, Ting-Zhu Huang, 
%     Low-rank tensor completion via combined non-local self-similarity and low-rank regularization
%
% Please make sure Your data is in range [0, 1].
%
% Created by Xiao-Tong Li £¨lixiaotong0283@163.com£©
% 1/3/2019

%% =================================================================
%clc;
clear;
close all;
addpath(genpath('lib'));
addpath(genpath('testData'));

% Set enable bits
EN_TMac       = 0;
EN_LRTC_TVI   = 0;
EN_LRTC_TVII  = 0;
EN_SPC_QV     = 0;
EN_TNN        = 0;
EN_NL_LRTC    = 1;
methodname    = {'Observed' 'TMac','LRTC-TVI','LRTC-TVII','SPC-QV','TNN','NL-LRTC'};
Mnum = length(methodname);
Re_tensor  =  cell(Mnum,1);
psnr       =  zeros(Mnum,1);
ssim       =  zeros(Mnum,1);
fsim       =  zeros(Mnum,1);
time       =  zeros(Mnum,1);

%% Load initial data
for data_num = 4
switch data_num
    case 1
        load('barbara.mat');
        data_name = 'barbara';
    case 2
        load('house.mat');
        data_name = 'house';
    case 3 
        load('house2.mat');
        data_name = 'house2';
    case 4
        load('lena.mat');
        data_name = 'lena';
    case 5
        load('Panda.mat');
        data_name = 'Panda';
    case 6
        load('pepper.mat');
        data_name = 'pepper';
    case 7
        load('sailboat.mat');
        data_name = 'sailboat';
    case 8
        load('facade.mat');
        data_name = 'facade';
    case 9
        load('fruits.mat');
        data_name = 'fruits';
    case 10
        load('baboon.mat');
        data_name = 'baboon';
    case 11
        load('Butterfly.mat');
        data_name = 'Butterfly';
    case 12
        load('airplane.mat');
        data_name = 'airplane';
    case 13
        load('sails.mat');
        data_name = 'sails';
    case 14
        load('tulips.mat');
        data_name = 'tulips'; 
    case 15
        load('watch.mat');
        data_name = 'watch';
end
%if max(X(:))>1
%    X = my_normalized(X);
%end
%X=X(30:80,40:100,:);
sr_list = [0.2]; %sampling rates
%% Sampling with random position
for ll = 1 :length(sr_list)

rand('seed',0);

sample_ratio = sr_list(ll);
fprintf('===The sample ratio is %4.2f === data_num is %d === \n',sample_ratio,data_num);
Y_tensorT = X;
Ndim      = ndims(Y_tensorT);
Nway      = size(Y_tensorT);
Omega     = find(rand(prod(Nway),1)<sample_ratio);

ratio = 0.005;
known = Omega;
%R=AdapN_Rank(X,ratio);
R = fix(Nway/2); R(3) = 3; %tesnor rank
data = Y_tensorT(known);
[known, id]= sort(known); data= data(id);
Y_tensor0 = zeros(Nway);
Y_tensor0(Omega) = Y_tensorT(Omega);
Q=(Y_tensor0~=0);
r0 = min([10 10 3],R);%start point of tensor rank
%%
i  = 1;
Re_tensor{i} = Y_tensor0;
[psnr(i), ssim(i)] = color_quality(Y_tensorT, Re_tensor{i});
enList = 1;

%% get the initialization X and A
for n = 1:3
    coNway(n) = prod(Nway)/Nway(n);
end
for ii = 1:3
    Y0{ii} = Unfold(Y_tensor0,Nway,ii);
    Y0{ii} = Y0{ii}';
    X0{ii}= rand(coNway(ii), r0(ii));
    A0{ii}= rand(r0(ii),Nway(ii));
end
%% Perform  algorithms
%% Use Tmac
i = i+1;
if EN_TMac
    % initialization of the parameters
    opts=[];
    alpha=[1 1 1];
    opts.alpha=alpha/sum(alpha);
    opts.tol = 1e-4;
    opts.maxit = 1000;
    opts.rho = 1;
    opts.R = R;
    %opts.Xtrue=Y_tensorT;
    %%%%%
    fprintf('\n');
    disp(['performing ',methodname{i}, ' ... ']);
    t0= tic;
    [Re_tensor{i}] = LRTC_TMac(Y0, data, A0, X0,Y_tensor0, Nway, known, opts);
    time(i)= toc(t0);
    [psnr(i), ssim(i)] = color_quality(Y_tensorT, Re_tensor{i});
    enList = [enList,i];
end

%% Use LRTC-TV-I
i = i+1;
if  EN_LRTC_TVI
    % initialization of the parameters
    opts=[];
    alpha       = ones(Ndim,1);
    opts.alpha  = alpha/sum(alpha);
    opts.tol    = 1e-4;
    opts.maxit  = 300;
    opts.lambda = 0.02;
    opts.beta   = [1,1,0];
    %opts.Xtrue  = Y_tensorT;
    %%%%%
    fprintf('\n');
    disp(['performing ',methodname{i}, ' ... ']);
    t0= tic;
    [Re_tensor{i}]=LRTC_TV_I(Y_tensor0,Omega,opts);
    PreY_tensor0 = Re_tensor{i};
    time(i)= toc(t0);
    [psnr(i), ssim(i)] = color_quality(Y_tensorT, Re_tensor{i});
    enList = [enList,i];
end

%% LRTC-TV-II
i=i+1;
if  EN_LRTC_TVII
    % initialization of the parameters
    %%%%%
    fprintf('\n');
    disp(['performing ',methodname{i}, ' ... ']);
    opts.lambda_1=0.5;
    opts.lambda_2=1000;
    opts.alpha = [1/3 1/3 1/3];
    opts.beta=[1,1,0];
    t0= tic;
    [Re_tensor{i}]=LRTC_TV_II(Y_tensor0,Omega,opts);
    time(i)= toc(t0);
    [psnr(i), ssim(i)] = color_quality(Y_tensorT, Re_tensor{i});
    enList = [enList,i];
end

%% Use SPC-QV
i = i+1;
    if EN_SPC_QV 
    fprintf('\n');
    disp(['performing ',methodname{i}, ' ... ']);
    opts.TVQV    = 'qv';        % 'tv' or 'qv' ;
    opts.rho     = [0.5 0.5 0]; % smoothness (0.1 - 1.0) for 'qv' and (0.01 - 0.5) for 'tv' is recommended.
    opts.K       = 10;          % Number of components which are updated in one iteration. (typically 10)
    opts.SNR     = 25;          % error bound
    opts.nu      = 0.01;        % threshold for R <-- R + 1.
    opts.maxiter = 1000;        % maximum number of iteration
    opts.tol     = 1e-5;        % tolerance
    opts.out_im  = 1;           % you can monitor the process of 'image' completion if out == 1. 'saved' directory is necessary to save the individual rank images.
    
    t0= tic;
    Re_tensor{i} = SPC(Y_tensor0,Q,opts);
    %PreY_tensor0 = Re_tensor{i};
    time(i)= toc(t0);
    [psnr(i), ssim(i)] = color_quality(Y_tensorT, Re_tensor{i});
    enList = [enList,i];
    end

%% Use TNN
i = i+1;
if EN_TNN
    % initialization of the parameters
    opts=[];
    opts.tol = 1e-4;
    %opts.maxit = 200; 
    opts.max_iter = 200;
    opts.rho = 1.1;
    opts.mu = 1e-2;
    opts.max_mu = 1e10;
    opts.DEBUG =0;
    %opts.Xtrue=Y_tensorT;
    %%%%%
    fprintf('\n');
    disp(['performing ',methodname{i}, ' ... ']);
    t0= tic;
    [Re_tensor{i},~]=lrtc_tnn(Y_tensor0,Omega,opts);
    time(i)= toc(t0);
    %PreY_tensor0 = Re_tensor{i};
    [psnr(i), ssim(i)] = color_quality(Y_tensorT, Re_tensor{i});
    enList = [enList,i];
end


%% NL-LRTC
i = i+1;
if  EN_NL_LRTC
    % initialization of the parameters
    opts=[];
    opts.maxit=500;
    opts.Ytr= Y_tensorT;
    opts.tol=2e-4;
    alpha=[1 1 1];
    opts.alpha = alpha / sum(alpha);
    rho=0.1;
    opts.rho1=rho;
    opts.rho2=rho;
    opts.rho3=rho;
    opts.R = R;
    opts.sigma =10;%3 12%
    %%%%%
    fprintf('\n');
    disp(['performing ',methodname{i}, ' ... ']);
    t0= tic;
    [Re_tensor{i}, ~, ~, Out1]= NL_LRTC(Y0, data, A0, X0, Y_tensor0,Nway, known, opts);
    time(i)= toc(t0);
    [psnr(i), ssim(i)] = color_quality(Y_tensorT, Re_tensor{i});
    enList = [enList,i];
end

%% Show result
%enList = [4];
Nway = size(Y_tensorT);
methodname    = {'Observed' 'TMac','LRTC-TVI','LRTC-TVII','SPC-QV','TNN','NL-LRTC'};
fprintf('\n');
fprintf('================== Result =====================\n');
fprintf(' %8.8s    %5.4s    %5.4s       \n','method','PSNR', 'SSIM');
for i = 1:length(enList)
    fprintf(' %9.9s    %5.3f    %5.3f       \n',...
        methodname{enList(i)},psnr(enList(i)), ssim(enList(i)));
end
fprintf('================== Result =====================\n');
figure,
%showMSIResult(Re_tensor,Y_tensorT,min(Y_tensorT(:)),max(Y_tensorT(:)),methodname,enList,1,Nway(3))
showColorResult(Re_tensor,Y_tensorT,methodname,enList);
%save(['D:\doc\mathdoc\Í¼Ïñ´¦Àí\NL-LRTC\code\','sr',num2str(sample_ratio),data_name,'.mat'], 'Omega','psnr','ssim','fsim','time','Y_tensorT','Re_tensor');
end
end