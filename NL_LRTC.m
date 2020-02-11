function [Y_tensor, A, X, Out]= NL_LRTC(Y, data, A, X, Y_tensorP,Nway, known, opts)
%%
% sloving following TV-based tensor completion problem.
% min_(Y,A,X): sum_{n=1}^{3}(alpha_n/2 * ||Y(n)-A_n*X_n||_F^2)+mu*TV(X3^T)
% s.t.:  P_Omega(Y) = F;
%
% Input arguments:
%   Y         ...... the mode-n unfolding of the corrupted tensor: Y={Y(1),Y(2),Y(3)
%   data      ...... the available elements of the observation tensor
%   A         ...... the initial factor matrix: A={A1,A2,A3}
%   X         ...... the initial factor matrix: X={X1,X2,X3}
%   Y_tensorP ...... the observation tensor
%   n1        ...... the length of mode-1 of Y_tensorP 
%   n2        ...... the length of mode-2 of Y_tensorP
%   opts      ...... an option structure whose fields are as follows:
%   (1)  rho1,rho2,rho3 ... the proximal parameter
%   (2)  alpha          ... the weights: alpha=(alpha(1),alpha(2),alpha(3)) 
%   (3)  mu             ... the regularization parameter 
%   (4)  beta           ... the penalty parameter 
%   (5)  tol            ... the termination threshold 
%   (5)  maxit          ... the max iteration step number
%   (6)  initer         ... the max iteration step number of X3 subproblem
%   (7)  miter          ... a parameter of X3 subproblem
%   (8)  Ytr            ... the true tensor

% Output arguments:
%   Y_tensor  ......  the reconstruct tensor
%   A         ......  the output factor matrix: A={A1,A2,A3}
%   X         ......  the output factor matrix: X={X1,X2,X3}
%   Out       ......  an option structure whose fields include: PSNR...


% more detail can be found in [1]
% [1] Teng-Yu Ji, Ting-Zhu Huang*, Xi-Le Zhao, Tian-Hui Ma, Gang Liu. 
%     Tensor completion using total variation and low-rank matrix factorization,  
%     Information Sciences, 2016.

%     @article{JiTV,
%     title={Tensor completion using total variation and low-rank matrix factorization},
%     author={Ji, Teng-Yu and Huang, Ting-Zhu and Zhao, Xi-Le and Ma, Tian-Hui and Liu, Gang},
%     journal={Information Sciences},
%     volume={326},
%     pages={243--257},
%     year={2016},
%     publisher={Elsevier}
%     }

%
% created by Teng-Yu Ji 
% updated by Yu-Bang Zheng
% 1/13/2018

% using BCD method
%%
%% Initiation
if isfield(opts,'mu');          mu = opts.mu;             else mu = 1;                 end
if isfield(opts,'beta') ;       beta = opts.beta;         else beta = 10;              end
if isfield(opts,'rho1') ;       rho1 = opts.rho1;         else rho1 = 0.1;             end
if isfield(opts,'rho2');        rho2 = opts.rho2;         else rho2 = 0.1;             end
if isfield(opts,'rho3');        rho3 = opts.rho3;         else rho3 = 0.1;             end
if isfield(opts,'maxit');       maxit = opts.maxit;       else maxit = 2000;           end
if isfield(opts,'initer');      initer = opts.initer;     else initer = 10;            end
if isfield(opts,'miter');       miter = opts.miter;       else miter = 20;             end
if isfield(opts,'tol');         tol = opts.tol;           else tol = 1e-4;             end
if isfield(opts,'alpha');       alpha = opts.alpha;       else alpha = [1/3 1/3 1/3];  end
if isfield(opts,'R');           R = opts.R;       else R = fix(1/3*size(Y));  end
deltar = 5;
Y_p=Y;X_p=X;A_p=A;
Out.Res=[];Out.Real=[]; Out.PSNR=[];
threh = opts.sigma;
nrmb = norm(data);
res0 = zeros(1,3); TotalRes = 0;
res = res0;
flag = 0;
for n = 1:3  
    Mn = Fold(X{n}*A{n},Nway,n);
    res0(n) = norm(Mn(known)-data); %% res0(n)=||fold(X(n)Y(n))- data||
    TotalRes = TotalRes+res0(n);  
end
%%
disp('Iteration:     \n');
for k=1: maxit
    fprintf('\b\b\b\b\b%5i\n',k);
    % update X
    
    temp=A_p{1}*A_p{1}'+rho1*(eye(size(A_p{1}*A_p{1}')));
    X{1}=(Y_p{1}*A_p{1}'+rho1*X_p{1})*pinv(temp);
   
    temp=A_p{2}*A_p{2}'+rho1*(eye(size(A_p{2}*A_p{2}')));
    X{2}=(Y_p{2}*A_p{2}'+rho1*X_p{2})*pinv(temp);

    temp=A_p{3}*A_p{3}'+rho1*(eye(size(A_p{3}*A_p{3}')));
    X{3}=(Y_p{3}*A_p{3}'+rho1*X_p{3})*pinv(temp);
   
    % updata A
    temp=X{1}'*X{1}+rho2*eye(size(X{1}'*X{1}));
    A{1}= pinv(temp)*(X{1}'*Y_p{1}+rho2*A_p{1});
    
    temp=X{2}'*X{2}+rho2*eye(size(X{2}'*X{2}));
    A{2}= pinv(temp)*(X{2}'*Y_p{2}+rho2*A_p{2});
    
    temp=X{3}'*X{3}+rho2*eye(size(X{3}'*X{3}));
    A{3}= pinv(temp)*(X{3}'*Y_p{3}+rho2*A_p{3});
    
    % update Y 
    Y{1} = (X{1}*A{1}+rho3*Y_p{1})/(1+rho3);Y1 = Fold(Y{1}', Nway, 1); 
    %res(1) = norm(Y1(known)-data);
    
    Y{2} = (X{2}*A{2}+rho3*Y_p{2})/(1+rho3);Y2 = Fold(Y{2}', Nway, 2); 
    %res(2) = norm(Y2(known)-data);
    
    Y{3} = (X{3}*A{3}+rho3*Y_p{3})/(1+rho3);Y3 = Fold(Y{3}', Nway, 3); 
    %res(3) = norm(Y3(known)-data);
    
    [~,Y_tensor] = CBM3D(1,alpha(1)*Y1+alpha(2)*Y2+alpha(3)*Y3,opts.sigma,'lc',0,'opp');
    
    Y_tensor(Y_tensor<0) = 0; Y_tensor(Y_tensor>1) = 1;
   % rank increase
    if k > 1 
        for j = 1:2
            temp1 = X_p{j}*A_p{j}; temp1 = temp1';
            temp1(known) = 0;
            temp2 = X{j}*A{j}; temp2 = temp2';
            temp2(known) = 0;
            flag = abs(1-(norm(temp2)/norm(temp1)));
            if (flag < 0.001) & (size(X{j},2) + deltar <= R(j))
                X{j} = [X{j}, rand(size(X{j},1),deltar)];
                A{j} = [A{j}; rand(deltar,size(A{j},2))];
            end
        end
    end
    
    
    real= norm(Y_tensor(known)-data)/ norm(data);
    Out.Real=[Out.Real,real];
    Y_tensor(known)= data;
   
    Res = norm(Y_tensor(:)-Y_tensorP(:))/norm(Y_tensorP(:));
    Out.Res = [Out.Res,Res];
    Y_tensorP = Y_tensor;
    if(mod(k,10) == 0)
        figure(1);
        subplot(221);imshow(Y_tensor,[0,1]); drawnow;
        subplot(222);imshow(Y1,[0,1]);drawnow;
        subplot(223);imshow(Y2,[0,1]);drawnow;
        subplot(224);imshow(Y3,[0,1]);drawnow;
    end  
    % fprintf('%.5f %.5f %.5f %.5f %.5f %.5f %.5f %5f       \n',real,relerr1,relerr2,res(1),res(2),res(3),iter,Res);
    % check stopping criterion
    crit = Res<tol;
    if crit
        break
    end
    
    if isfield(opts, 'Ytr')
        Out.truerel(k)= norm(Y_tensor(:)- opts.Ytr(:))/ norm(opts.Ytr(:));
        Out.PSNR(k) = psnr(Y_tensor,opts.Ytr);
    end
    fprintf('%d %d %d %.5f %.5f %.5f %.5f %.5f %5f       \n',size(A{1},1),size(A{2},1),size(A{3},1),opts.sigma,Out.PSNR(k),res(1),res(2),res(3),Res);
   
    Y{1} = Unfold(Y_tensor,Nway,1); Y{1} = Y{1}';
    Y{2} = Unfold(Y_tensor,Nway,2); Y{2} = Y{2}';
    Y{3} = Unfold(Y_tensor,Nway,3); Y{3} = Y{3}';
    Y_p=Y;X_p=X;A_p=A;
end
end