function showColorResult(Re_tensor,Y_tensorT,methodname,enList)
k = length(enList);
m = 4; n = fix((k+4)/4);
subplot(n,m,1); imshow(Y_tensorT,[0,1]);title('Original');
for i = 1 : k
subplot(n,m,i+1); imshow(Re_tensor{enList(i)},[0,1]);
title(methodname{enList(i)});
end