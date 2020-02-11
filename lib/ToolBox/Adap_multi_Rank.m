%%%compute the multi-rank
function rank=Adap_multi_Rank(X,ratio)
Nway = size(X);
rank=zeros(1,Nway(3));
FX = fft(X,[],3);
for i = 1:Nway(3)
    [~,s,~] = svd(FX(:,:,i),'econ');
    big=s(1);
rank(i)=size(find(s>=ratio*big),1);
end
