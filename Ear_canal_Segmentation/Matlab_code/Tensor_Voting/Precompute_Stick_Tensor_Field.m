function [TensorFieldOut] = Precompute_Stick_Tensor_Field(Sigma)
%--------------------------------------------------------------------------
%This function precomputes stick voting fields for all the available
%directions, thus we can reduce the computational time.

%Input: Sigma 
%Output: Cached stick tensor fields for all the angles

%--------------------------------------------------------------------------

%The size of the voting field depends on the distance between the voter and
%the receiver pixel, as in the Eq. 5.7 or the scale
Ws = floor(ceil(sqrt(-log(0.01)*Sigma^2)*2)/2)*2+1;

%We save the tensors in TensorFieldOut variable
TensorFieldOut = zeros(360,Ws,Ws,2,2);

% 1)in stick voting we use the range 1:180, while in 2) ball voting the range 1:360
for Theta = 0:359
    X = cos(Theta*(pi/180));
    Y = sin(Theta*(pi/180));
    V = [X,Y];
    TensorFieldOut(Theta+1,:,:,:,:) = Create_Stick_Tensor_Field(V,Sigma);
    %use squeeze() for visualisation because if you access the matrix you
    %get a first singleton dimension 
end