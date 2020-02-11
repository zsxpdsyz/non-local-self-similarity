function [X, tlogDet, trank] = prox_tensorlogDet(Z, rho, Xold, epsilon)
[n1,n2,n3] = size(Z);
n12 = min(n1,n2);
Z = fft(Z,[],3);
Xold = fft(Xold,[],3);
U = zeros(n1,n12,n3);
V = zeros(n2,n12,n3);
S = zeros(n12,n12,n3);
trank = 0;
for i = 1 : n3
    [U(:,:,i),s,V(:,:,i)] = svd(Z(:,:,i),'econ');
    w = svd(Xold(:, :, i), 'econ');
    w = w + epsilon;
    w = 1./w;
    
    s = diag(s);
    s = max(s-rho*w,0);    
%     s = max(s-rho*n3*w,0);    
    S(:,:,i) = diag(s);
    tranki = length(find(s~=0));
    trank = max(tranki,trank);
end
U = U(:,1:trank,:);
V = V(:,1:trank,:);
S = S(1:trank,1:trank,:);

U = ifft(U,[],3);
S = ifft(S,[],3);
V = ifft(V,[],3);

X = tprod( tprod(U,S), tran(V));

S = S(:,:,1);
tlogDet = sum(S(:)); % return the tensor nuclear norm of X