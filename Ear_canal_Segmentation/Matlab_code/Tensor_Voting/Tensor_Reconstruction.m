function [OutTensor] = Tensor_Reconstruction(E1,E2,L1,L2) 
%--------------------------------------------------------------------------
%This function reconstructs the tensor from a given set of eigenvalues(L1,L2) 
%and eigenvectors (E1,E2). This is done by computing the following expression
%T = L1*E1*E1' + L2*E2*E2'

%Input: E1, the eigenvector corresponding to the largest eigenvalue (L1) and
%E2, the eigenvector correspoding to the smallest eigenvalue (L2)

%Output: the output Ttensor field in a 4D matrix
%Tensor(:,:,1,1)=Tensor(1,1), Tensor(:,:,1,2)=Tensor(1,2), etc.

%--------------------------------------------------------------------------

OutTensor = zeros([size(L1),2,2]);
OutTensor(:,:,1,1) = L1.*E1(:,:,1).^2+L2.*E2(:,:,1).^2;
OutTensor(:,:,1,2) = L1.*E1(:,:,1).*E1(:,:,2)+L2.*E2(:,:,1).*E2(:,:,2);
OutTensor(:,:,2,1) = OutTensor(:,:,1,2);
OutTensor(:,:,2,2) = L1.*E1(:,:,2).^2+L2.*E2(:,:,2).^2;