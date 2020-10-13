function [Centerline] = Non_Maxima_Saliency_Suppression(TensorField,R,Epsilon)

[E1,~,L1,L2] = Tensor_Decomposition(TensorField);  
Diff1 = L1-L2;
Centerline = zeros(size(L1,1),size(L1,2),'double');
[X,Y] = meshgrid(-R:1:R,-R:1:R);
Theta = atan2(Y,X);
L = sqrt(X.^2+Y.^2);
Q1 = zeros(2*R+size(L1,1),2*R+size(L1,2));
Q1((R+1):(size(L1,1)+R),(R+1):(size(L1,2)+R)) = Diff1;
Index1 = find(Q1>0);
[h,w] = size(Q1);

for i=1:length(Index1)
    [y,x] = ind2sub(h,Index1(i));
    X2 = L.*cos(Theta+atan2(E1(y-R,x-R,2),E1(y-R,x-R,1)));
    Y2 = L.*sin(Theta+atan2(E1(y-R,x-R,2),E1(y-R,x-R,1)));
    Theta2 = abs(atan2(Y2,X2));
    Theta2(Theta2>pi/2) = pi-Theta2(Theta2>pi/2);
    Theta2(Theta2<=Epsilon) = 1;
    Theta2(Theta2~=1) = 0;
    Theta2(L>R) = 0;
    
    Z = Q1((y-R):(y+R),(x-R):(x+R)).*Theta2;
    Z = max(Z>Q1(y,x));
    if max(Z(:)) == 0
        Centerline(y-R,x-R) = 1;
    end
end
end