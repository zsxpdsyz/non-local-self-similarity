function [OutX, Out] = LRTC_t_tnn(B, Omega, opts)

%---------------------------------------------
% Input:
%       M       -    d1*d2*d3 tensor
%       Omega   -    index of the observed entries
%       opts    -    Structure value in Matlab. The fields are
%           opts.tol        -   termination tolerance
%           opts.maxit      -   maximum number of iterations
%           opts.beta       -   stepsize for dual variable updating in ADMM
%           opts.max_beta   -   maximum stepsize
%           opts.rho        -   rho>=1, ratio used to increase beta
%           opts.DEBUG      -   0 or 1
%
% Output:
%       X       -    d1*d2*d3 tensor
%       Out
%         Out.PSNR
%         Out.Res
%         Out.ResT
%     @ARTICLE{HutTNN,
%     author={W. Hu and D. Tao and W. Zhang and Y. Xie and Y. Yang},
%     journal={IEEE Transactions on Neural Networks and Learning Systems},
%     title={The Twist Tensor Nuclear Norm for Video Completion},
%     year={2017},
%     volume={28},
%     number={12},
%     pages={2961-2973},
%     }
%%

if ~exist('opts', 'var')
    opts = [];
end
if isfield(opts, 'tol');         tol = opts.tol;              end
if isfield(opts, 'maxit');    maxit = opts.maxit;    end
if isfield(opts, 'rho');         rho = opts.rho;              end
if isfield(opts, 'beta');        beta = opts.beta;                end
if isfield(opts, 'max_beta');      max_beta = opts.max_beta;        end
X=permute(B,[1,3,2]);
Nway = size(X);
Y = zeros(Nway); %% 辅助变量
M = Y; %% 拉格朗日乘子
Out.Res=[];Out.ResT=[]; Out.PSNR=[];
for k = 1:maxit
    Xold = permute(X,[1,3,2]);
    %% solve Y-subproblem
    [Y,~,~] = prox_tnn(X - M/beta,1/beta);
    %% solve X-subproblem
    X = Y + M/beta;
    X=permute(X,[1,3,2]);
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
            fprintf('t_TNN: iter = %d   PSNR=%f   res=%f   real-res=%f\n', k, psnr, res, resT);
        else
            fprintf('t_TNN: iter = %d   res=%f   \n', k, res);
        end
    end
    
    OutX=X;
    
    if res < tol 
        break;
    end
    
    %% update Lagrange multiplier
    
    X=permute(X,[1,3,2]);
    M = M + beta * (Y - X);
    beta = min(rho * beta, max_beta);
end
end