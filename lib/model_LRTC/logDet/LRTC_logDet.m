function [X, Out] = LRTC_logDet(B, Omega, opts)

% tol = 1e-8; 
% maxit = 500;
% epsilon = 1e-5;
% rho = 1.1;
% beta = 1e-4;
% max_beta = 1e10;
% by Teng-Yu Ji
% @article{JilogDet,
% author = {Ji, Teng-Yu and Huang, Ting-Zhu and Zhao, Xi-Le and Ma, Tian-Hui and Deng, Liang-Jian},
% year = {2017},
% pages = {410--422},
% title = {A non-convex tensor rank approximation for tensor completion},
% volume = {48},
% journal = {Applied Mathematical Modelling}
% }


if ~exist('opts', 'var')
    opts = [];
end    
if isfield(opts, 'tol');         tol = opts.tol;              end
if isfield(opts, 'maxit');       maxit = opts.maxit;    end
if isfield(opts, 'epsilon');     epsilon = opts.epsilon;              end
if isfield(opts, 'rho');         rho = opts.rho;              end
if isfield(opts, 'beta');        beta = opts.beta;                end
if isfield(opts, 'max_beta');    max_beta = opts.max_beta;        end

Nway = size(B);
X = B; 
Y = zeros(Nway); %% 辅助变量
M = zeros(Nway); %% 拉格朗日乘子

Out.Res=[];Out.ResT=[]; Out.PSNR=[];
for k = 1:maxit
    Xold = X;
    %% solve Y-subproblem

    [Y,~,~] = prox_tensorlogDet(X + M/beta, 1/beta, Y, epsilon);
    %% solve X-subproblem
    X = Y - M / beta;
    X(Omega) = B(Omega);
    %% check the convergence
    if isfield(opts, 'Xtrue')
    XT=opts.Xtrue;    
    resT=norm(X(:)-XT(:))/norm(XT(:)); 
    psnr=PSNR(X,XT);
    Out.ResT = [Out.ResT,resT];
    Out.PSNR = [Out.PSNR,psnr];
    end 
    res=norm(X(:)-Xold(:))/norm(Xold(:));
    Out.Res = [Out.Res,res];    
    if k==1 || mod(k, 10) == 0
        if isfield(opts, 'Xtrue')
            fprintf('logDet: iter = %d   PSNR=%f   res=%f   real-res=%f\n', k, psnr, res, resT);
        else
            fprintf('logDet: iter = %d   res=%f   \n', k, res);
        end
    end
    if res < tol 
        break;
    end
    
    %% update Lagrange multiplier
    M = M + beta * (X - Y);
    beta = min(rho * beta, max_beta);
end

end 