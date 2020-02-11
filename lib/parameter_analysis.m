clear;
close all;
addpath(genpath('lib'));
addpath(genpath('testData'));

%rand('seed',0);

load('barbara.mat');

sample_ratio = 0.1;
Y_tensorT = X;
Ndim      = ndims(Y_tensorT);
Nway      = size(Y_tensorT);
Omega     = find(rand(prod(Nway),1)<sample_ratio);

ratio = 0.005;
known = Omega;
R=AdapN_Rank(X,ratio);
data = Y_tensorT(known);
[known, id]= sort(known); data= data(id);
Y_tensor0 = zeros(Nway);
Y_tensor0(Omega) = Y_tensorT(Omega);
Q=(Y_tensor0~=0);
r0 = min([10 10 10],R);
%R(3)=2;
%%
i  = 1;
Re_tensor{i} = Y_tensor0;
[psnr(i), ssim(i), fsim(i)] = quality(Y_tensorT*255, Re_tensor{i}*255);
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

%%   
list = [5 10 15 20 30];
for i = 1 : length(list)
opts=[];
    opts=[];
    opts.maxit=500;
    opts.Ytr= Y_tensorT;
    opts.tol=1e-4;
    alpha=[1 1 1];
    opts.alpha = alpha / sum(alpha);
    rho = 0.1;
    opts.rho1=rho;
    opts.rho2=rho;
    opts.rho3=rho;
    opts.R = R;
    opts.sigma =list(i);%3 12%
    %%%%%
    fprintf('\n');
    disp(['performing ',i, '... ']);
    [Re_tensor{i}, ~, ~, Out1{i}]= NL_LRTC(Y0, data, A0, X0, Y_tensor0,Nway, known, opts);
    [psnr(i), ssim(i)] = color_quality(Y_tensorT, Re_tensor{i});
end
    showColorResult(Re_tensor,Y_tensorT,methodname,enList);