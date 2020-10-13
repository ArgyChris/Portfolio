function [TensorFieldOut] = Token_Representation(Image)

TensorFieldOut = zeros(size(Image,1),size(Image,2),2,2);
[c,l] = find(Image>0);

for i=1:length(c)
    TensorFieldOut(c(i),l(i),:,:) = [1,0;0,1];    
end

