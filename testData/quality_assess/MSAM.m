function [MSAM,SAMV] = MSAM(O,Ref)


for i = 1:size(O,1)
    for j = 1:size(O,2)
    a1 = squeeze(O(i,j,:));
    a2 = Ref(i,j,:);
    SAMV(i,j) = SAM(a1,a2);
    end
end
MSAM = mean2(SAMV);