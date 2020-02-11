function [L,E,Out] = TRPCA_SNN(X,opts)

% Solve the Tensor Robust Principal Component Analysis (TRPCA) based on Sum of Nuclear Norm (SNN) problem by M-ADMM
%
% min_{L,E} \sum_i \alpha_i*||L_{i(i)}||_* + ||E||_1,
% s.t. X = L + E.
%
% ---------------------------------------------
% Input:
%       X       -    d1*d2*...dk tensor
%       alpha   -    k*1 vector, parameters
%       opts    -    Structure value in Matlab. The fields are
%           opts.tol        -   termination tolerance
%           opts.max_iter   -   maximum number of iterations
%           opts.mu         -   stepsize for dual variable updating in ADMM
%           opts.max_mu     -   maximum stepsize
%           opts.rho        -   rho>=1, ratio used to increase mu
%           opts.DEBUG      -   0 or 1
%
% Output:
%       L       -    d1*d2*...*dk tensor
%       E       -    d1*d2*...*dk tensor
%       err     -    residual
%       iter    -    number of iterations
%
% version 1.0 - 24/06/2016
%
% Written by Canyi Lu (canyilu@gmail.com)
% 

if ~exist('opts', 'var')
    opts = [];
end    
if isfield(opts, 'tol');         tol = opts.tol;              end
if isfield(opts, 'max_iter');    max_iter = opts.max_iter;    end
if isfield(opts, 'rho');         rho = opts.rho;              end
if isfield(opts, 'beta');        mu = opts.beta;              end
if isfield(opts, 'max_beta');    max_mu = opts.max_beta;      end
if isfield(opts, 'alpha');       alpha = opts.alpha;          end



dim = size(X);
Nway= dim;
lambda1= 1/sqrt(max(Nway(3)*Nway(2),Nway(1)));
lambda2= 1/sqrt(max(Nway(1)*Nway(3),Nway(2)));
lambda3= 1/sqrt(max(Nway(1)*Nway(2),Nway(3)));
lambda=alpha(1)*lambda1+alpha(2)*lambda2+alpha(3)*lambda3;

k = length(dim);

E = zeros(dim);
Y = E;
L = cell(k,1);
for i = 1 : k
    L{i} = E;
end
Out.Res=[];Out.err=[]; Out.PSNR=[];
sumtempL = X;

for iter = 1 : max_iter
    Lk = sumtempL;
    Ek = E;
    % first super block {L_i}
    sumtempL = zeros(dim);
    for i = 1 : k
        L{i} = Fold(prox_nuclear(Unfold(X-E+Y/mu,dim,i), 1/mu),dim,i);
        sumtempL = sumtempL + alpha(i)*L{i};
    end
    % second super block {E}
    E = prox_l1(X-sumtempL+Y/mu,lambda/mu);
    
    %
    dY = X-E-sumtempL;
    chgE = max(abs(Ek(:)-E(:)));
    chgL = max(abs(Lk(:)-sumtempL(:)));
    err = norm(dY(:));
    chg = max([chgL chgE max(abs(dY(:)))]);
    Out.err = [Out.err,err];
    Out.Res = [Out.Res,chg];
    if isfield(opts, 'Xtrue')
        XT=opts.Xtrue;
        psnr=PSNR(sumtempL,XT);
        Out.PSNR = [Out.PSNR,psnr];
    end
    
    if iter == 1 || mod(iter, 10) == 0
         if isfield(opts, 'Xtrue')
            fprintf('SNN: iter = %d   PSNR=%f   res=%f    err=%f\n', iter, psnr, chg, err);
         else
            fprintf('SNN: iter = %d   res=%f   err=%f\n', iter, res, err);
         end       
    end

    if chg < tol
        break;
    end 
    Y = Y+mu*dY;
    mu = min(rho*mu,max_mu);    
end
L = sumtempL;
