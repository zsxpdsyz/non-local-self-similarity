%%%compute the multi-rank
function rank=Adap_fibered_Rank(Y,ratio)
Ndim = ndims(Y);
rank = zeros(1,Ndim);

X = permute(Y,[2,3,1]);
Nway = size(X);
mlitirank = zeros(1,Nway(3));
FX = fft(X,[],3);
for i = 1:Nway(3)
    [~,s,~] = svd(FX(:,:,i),'econ');
    big=s(1);
mlitirank(i)=size(find(s>=ratio*big),1);
end
rank(1) = max(mlitirank);

X = permute(Y,[3,1,2]);
Nway = size(X);
mlitirank = zeros(1,Nway(3));
FX = fft(X,[],3);
for i = 1:Nway(3)
    [~,s,~] = svd(FX(:,:,i),'econ');
    big=s(1);
mlitirank(i)=size(find(s>=ratio*big),1);
end
rank(2) = max(mlitirank);

X = Y;
Nway = size(X);
mlitirank = zeros(1,Nway(3));
FX = fft(X,[],3);
for i = 1:Nway(3)
    [~,s,~] = svd(FX(:,:,i),'econ');
    big=s(1);
mlitirank(i)=size(find(s>=ratio*big),1);
end
rank(3) = max(mlitirank);
