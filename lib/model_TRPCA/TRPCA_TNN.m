function [L,S,Out] = TRPCA_TNN(X,opts)

% Solve the Tensor Robust Principal Component Analysis based on Tensor Nuclear Norm problem by ADMM

% Many thanks for the Canyi Lu sharing the code, we update it at 7th Feb. 2018



if exist('~opts', 'var')
    opts = [];
end    
if isfield(opts, 'tol');         tol = opts.tol;              end
if isfield(opts, 'max_iter');    max_iter = opts.max_iter;    end
if isfield(opts, 'rho');         rho = opts.rho;              end
if isfield(opts, 'beta');          mu = opts.beta;                end
if isfield(opts, 'max_beta');      max_mu = opts.max_beta;        end
if isfield(opts, 'lambda');      lambda = opts.lambda;        end
dim = size(X);
L = zeros(dim);
S = L;
Y = L;

Out.Res=[];Out.err=[]; Out.PSNR=[];
for iter = 1 : max_iter
    Lk = L;
    Sk = S;
    % update L
    [L,~,~] = prox_tnn(-S+X-Y/mu,1/mu);
    % update S
    S = prox_l1(-L+X-Y/mu,lambda/mu);
  
    dY = L+S-X;
    chgL = max(abs(Lk(:)-L(:)));
    chgS = max(abs(Sk(:)-S(:)));
    chg = max([ chgL chgS max(abs(dY(:))) ]);
    
    Out.Res = [Out.Res,chg];
    if isfield(opts, 'Xtrue')
        XT=opts.Xtrue;
        psnr=PSNR(L,XT);
        Out.PSNR = [Out.PSNR,psnr];
    end
    
    if iter == 1 || mod(iter, 10) == 0
         err = norm(dY(:));
         Out.err = [Out.err,err];
         if isfield(opts, 'Xtrue')
            fprintf('TNN: iter = %d   PSNR=%f   res=%f    err=%f\n', iter, psnr, chg, err);
         else
            fprintf('TNN: iter = %d   res=%f   err=%f\n', iter, res, err);
         end       
    end
    
    if chg < tol
        break;
    end 
    Y = Y + mu*dY;
    mu = min(rho*mu,max_mu);    
end
