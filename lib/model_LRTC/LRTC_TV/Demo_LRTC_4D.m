%% =================================================================
% This script compares low-rank tensor completion methods
% listed as follows:
%     1. HaLRTC £¨SNN£©
%     2. logDet-based LRTC 
%     3. t-SVD-based LRTC £¨TNN£©
%     4. PSTNN-based LRTC 
%     5. twist TNN-based LRTC (t-TNN) 
%     6. 3DTNN-based LRTC (the proposed method)
% You can:
%     1. Type 'Demo_LRTC_video' to to run various methods and see the pre-computed results.
%     2. Change test video by simply modifying variable 'tensor_num' in Demo_LRTC_video.m (NOTE: make sure your video
%        meets the format requirements).
%     3. Select competing methods by turn on/off the enable-bits in Demo_LRTC_video.m
%
% More detail can be found in [1][2]
% [1] Yu-Bang Zheng, Ting-Zhu Huang*, Xi-Le Zhao*,Tai-Xiang Jiang,Teng-Yu Ji,and Tian-Hui Ma. 
%     Tensor fibered rank and its convex relaxation for low-rank tensor completion.
% [2] Yu-Bang Zheng, Ting-Zhu Huang*, Xi-Le Zhao*,Tai-Xiang Jiang,Teng-Yu Ji,and Tian-Hui Ma. 
%     Tensor fibered rank and its convex relaxation for low-rank tensor recovery.
%
% Please make sure Your video is of size height * width * lengths and in range [0, 1].
% 
% Created by Yu-Bang Zheng £¨zhengyubang@163.com£©
% 6/20/2018

%% =================================================================
clc; 
clear; 
close all;
addpath(genpath('lib'));
addpath(genpath('data'));

%% Set enable bits
EN_HaLRTC     = 0;
EN_LRTC_TV_I  = 1;
EN_LRTC_TV_II = 1;
EN_logDet     = 0;
EN_TNN        = 0;
EN_PSTNN      = 0;
EN_t_TNN      = 0;
EN_WSTNN      = 0;
methodname    = { 'HaLRTC', 'LRTC-TV-I', 'LRTC-TV-II', 'logDet', 'TNN', 'PSTNN', 't-TNN', 'WSTNN'};
Mnum = length(methodname);

%% Load initial data
for tensor_num=1
    switch tensor_num
        case 1
            load('color_news.mat')    
        case 2
            load('color_hall.mat') 
    end
    frame = 50;
    X=X(:,:,:,1:frame);
    if max(X(:))>1
        X=X/max(X(:));
    end
    X=color2gray(X);
    %% Sampling with random position
    sss=[0.05,0.1,0.2];
    for i=2
    sample_ratio = sss(i);
    fprintf('=== The sample ratio is %4.2f ===\n', sample_ratio);
    Nway=size(X);
    Ndim=ndims(X);
    Y_tensorT = X;
    Omega=find(rand(prod(Nway)/3,1)<sample_ratio);
    Omega=[Omega;prod(Nway)/3+Omega;2*prod(Nway)/3+Omega];
    Y_tensor0=zeros(Nway);
    Y_tensor0(Omega)= X(Omega);
    temp_tensor0=zeros(Nway);
    temp_tensor0(Omega)= 1;
    B_T = gray2color( Y_tensorT,[144,176,3,frame]);
    B_0 = gray2color( Y_tensor0,[144,176,3,frame]);
    temp_tensor0 = gray2color(temp_tensor0,[144,176,3,frame]);
    Omega = find(temp_tensor0==1);
    imname=['cvideo',num2str(tensor_num),'_tensor0','_SR_',num2str(sample_ratio),'.mat'];
    save(imname,'B_T','B_0','Y_tensor0','Y_tensorT','Omega','Nway'); % save initial data
    %% Perform  algorithms
    %% Use HaLRTC
    i = 1;
    if EN_HaLRTC
        % initialization of the parameters
        opts=[];
        alpha=ones(Ndim,1);
        opts.alpha=alpha/sum(alpha);
        opts.tol = 1e-4;
        opts.maxit = 500;
        opts.rho = 1.1;
        opts.beta = 1e-2;
        opts.max_beta = 1e10;
        opts.Xtrue=Y_tensorT;
        %%%%%
        fprintf('\n');
        disp(['performing ',methodname{i}, ' ... ']);
        t0= tic;
        [Y_snn,Out_snn]=LRTC_HaLRTC(Y_tensor0,Omega,opts);
        time_snn= toc(t0);
        psnr_snn=PSNR(Y_snn, Y_tensorT);
        B_snn = gray2color(Y_snn,[144,176,3,frame]);
        imname=['cvideo',num2str(tensor_num),'SR_',num2str(sample_ratio),'result_snn_psnr_',num2str(psnr_snn), '.mat'];
        save(imname,'B_snn','Y_snn','opts','Out_snn','time_snn'); % save results
    end
    
    
    %% Use LRTC-TV-I
    i = i+1;
    if  EN_LRTC_TV_I
        % initialization of the parameters
        opts=[];
        alpha       = ones(Ndim,1);
        opts.alpha  = alpha/sum(alpha);
        opts.tol    = 1e-4;
        opts.maxit  = 500;
        opts.lambda = 0.02;
        opts.beta   = [1,1,0];
        opts.Xtrue  = Y_tensorT;
        %%%%%
        fprintf('\n');
        disp(['performing ',methodname{i}, ' ... ']);
        t0= tic;
        [Y_snn,Out_snn]=LRTC_TV_I(Y_tensor0,Omega,opts);
        time_snn= toc(t0);
        psnr_snn=PSNR(Y_snn, Y_tensorT);
        B_snn = gray2color(Y_snn,[144,176,3,frame]);
        imname=['cvideo',num2str(tensor_num),'SR_',num2str(sample_ratio),'result_snn_psnr_',num2str(psnr_snn), '.mat'];
        save(imname,'B_snn','Y_snn','opts','Out_snn','time_snn'); % save results
    end
    
    %% Use LRTC-TV-II
    i = i+1;
    if  EN_LRTC_TV_II
        % initialization of the parameters
        opts=[];
        alpha         = ones(Ndim,1);
        opts.alpha    = alpha/sum(alpha);
        opts.tol      = 1e-4;
        opts.maxit    = 500;
        opts.lambda_1 = 0.5;
        opts.lambda_2 = 1000;
        opts.beta     = [1,1,0];
        opts.Xtrue    = Y_tensorT;
        %%%%%
        fprintf('\n');
        disp(['performing ',methodname{i}, ' ... ']);
        t0= tic;
        [Y_snn,Out_snn]=LRTC_TV_II(Y_tensor0,Omega,opts);
        time_snn= toc(t0);
        psnr_snn=PSNR(Y_snn, Y_tensorT);
        B_snn = gray2color(Y_snn,[144,176,3,frame]);
        imname=['cvideo',num2str(tensor_num),'SR_',num2str(sample_ratio),'result_snn_psnr_',num2str(psnr_snn), '.mat'];
        save(imname,'B_snn','Y_snn','opts','Out_snn','time_snn'); % save results
    end
    
    
    
    %% Use logDet
    i = i+1;
    if EN_logDet
        % initialization of the parameters
        opts=[];
        opts.tol = 1e-4;
        opts.maxit = 500;0.
        opts.rho = 1.2;
        opts.beta = 1e-4;
        opts.max_beta = 1e10;
        opts.epsilon=100;
        opts.Xtrue=Y_tensorT;
        %%%%%
        fprintf('\n');
        disp(['performing ',methodname{i}, ' ... ']);
        t0= tic;
        [Y_log,Out_log]=LRTC_logDet(Y_tensor0,Omega,opts);
        time_log= toc(t0);
        psnr_log=PSNR(Y_log, Y_tensorT);
        B_log = gray2color(Y_log,[144,176,3,frame]);
        imname=['cvideo',num2str(tensor_num),'SR_',num2str(sample_ratio),'result_logDet_psnr_',num2str(psnr_log),'.mat'];
        save(imname,'B_log','Y_log','opts','Out_log','time_log'); % save results
        
    end
        
    %% Use TNN
    i = i+1;
    if EN_TNN
        % initialization of the parameters
        opts=[];
        opts.tol = 1e-4;
        opts.maxit = 500;
        opts.rho = 1.1;
        opts.beta = 1e-2;
        opts.max_beta = 1e10;
        opts.Xtrue=Y_tensorT;
        %%%%%
        fprintf('\n');
        disp(['performing ',methodname{i}, ' ... ']);
        t0= tic;
        [Y_tnn,Out_tnn]=LRTC_tnn(Y_tensor0,Omega,opts);
        time_tnn= toc(t0);
        psnr_tnn=PSNR(Y_tnn, Y_tensorT);
        B_tnn = gray2color(Y_tnn,[144,176,3,frame]);
        imname=['cvideo',num2str(tensor_num),'SR_',num2str(sample_ratio),'result_tnn_psnr_',num2str(psnr_tnn),'.mat'];
        save(imname,'B_tnn','Y_tnn','opts','Out_tnn','time_tnn'); % save results
    end
    
    %% Use PSTNN
    i = i+1;
    if EN_PSTNN
        % initialization of the parameters
        [rankN,~] = prox_rankN(X,0.01);
        opts=[];
        opts.beta = 1e-3;
        opts.tol = 1e-4;
        opts.rho = 1.2;
        opts.maxit = 500;
        opts.max_beta = 1e10;
        opts.Xtrue=Y_tensorT;
        %%%%%
        fprintf('\n');
        disp(['performing ',methodname{i}, ' ... ']);
        t0= tic;
        [Y_pstnn,Out_pstnn] =  LRTC_PSTNN(Y_tensor0,Omega,opts,rankN);
        time_pstnn= toc(t0);
        psnr_pstnn=PSNR(Y_pstnn, Y_tensorT);
        B_pstnn = gray2color(Y_pstnn,[144,176,3,frame]);
        imname=['cvideo',num2str(tensor_num),'SR_',num2str(sample_ratio),'result_PSTNN_psnr_',num2str(psnr_pstnn), '.mat'];
        save(imname,'B_pstnn','Y_pstnn','opts','Out_pstnn','time_pstnn'); % save results
    end
        
    %% Use t-TNN
    i = i+1;
    if EN_t_TNN
        % initialization of the parameters
        opts=[];
        opts.tol = 1e-4;
        opts.maxit = 500;
        opts.rho = 1.1;
        opts.beta = 1e-2;
        opts.max_beta = 1e10;
        opts.Xtrue=Y_tensorT;
        %%%%%
        fprintf('\n');
        disp(['performing ',methodname{i}, ' ... ']);
        t0= tic;
        [Y_t_tnn,Out_t_tnn]=LRTC_t_tnn(Y_tensor0,Omega,opts);
        time_t_tnn= toc(t0);
        psnr_t_tnn=PSNR(Y_t_tnn, Y_tensorT);
        B_t_tnn = gray2color(Y_t_tnn,[144,176,3,frame]);
        imname=['cvideo',num2str(tensor_num),'SR_',num2str(sample_ratio),'result_t_tnn_psnr_',num2str(psnr_t_tnn),'.mat'];
        save(imname,'B_t_tnn','Y_t_tnn','opts','Out_t_tnn','time_t_tnn'); % save results
    end
    
    %% Use WSTNN
    i = i+1;
    if EN_WSTNN
        % initialization of the parameters
        opts=[];
        alpha=[1,0.01,1,1];
        opts.alpha=alpha/sum(alpha);
        opts.tol = 1e-4;
        opts.maxit = 500;
        opts.rho = 1.1;
        opts.beta = opts.alpha/100;
        opts.max_beta = 1e10*[1,1,1,1];
        opts.Xtrue=B_T;
        %%%%%
        fprintf('\n');
        disp(['performing ',methodname{i}, ' ... ']);
        t0= tic;
        [Y_3Dtnn,Out_3Dtnn]=LRTC_WSTNN_ADMM(B_0,Omega,opts);
        time_3Dtnn= toc(t0);
        psnr_3Dtnn=PSNR(Y_3Dtnn,B_T);
        B_3Dtnn = gray2color(Y_3Dtnn,[144,176,3,frame]);
        imname=['cvideo',num2str(tensor_num),'SR_',num2str(sample_ratio),'result_3Dtnn_psnr_',num2str(psnr_3Dtnn), '.mat'];
        save(imname,'B_3Dtnn','Y_3Dtnn','opts','Out_3Dtnn','time_3Dtnn'); % save results
    end
    end
end
%% If you want to measure the quality (PSNR, SSIM, and FSIM) of the recovered results, please run Quality.m