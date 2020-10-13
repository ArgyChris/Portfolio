function [E1,E2,L1,L2] = Tensor_Decomposition(InputTensor) 
%--------------------------------------------------------------------------
%This function decomposes the tensor in eigenvalues(L1,L2) 
%and eigenvectors (E1,E2).

%Step1: Retrival of the 4 entries of the tensor field

%Step2: Allocation of space for the eigenvectors variables

%Step3: Compute the eigenvalues

%Step4: Compute the eigenvectors

%Input: InputTensor the tensorial field which is symmetric

%Output: the output eigenvectors and values (E1,E2,L1,L2)


%--------------------------------------------------------------------------
%Step1:
Entry11 = InputTensor(:,:,1,1);
Entry12 = InputTensor(:,:,1,2);
Entry21 = InputTensor(:,:,2,1);
Entry22 = InputTensor(:,:,2,2);

%Step2:
E1 = zeros(size(Entry11,1),size(Entry11,2),2);
E2 = zeros(size(Entry11,1),size(Entry11,2),2);

%Step3:
Trace = (Entry11+Entry22)/2;

Alpha = Entry11 - Trace;
Beta = Entry12;

AlphaBeta2 = sqrt(Alpha.^2+Beta.^2);
L1 = AlphaBeta2 + Trace;
L2 = -AlphaBeta2 + Trace;

%Step4:
Theta = atan2(AlphaBeta2-Alpha,Beta);

E1(:,:,1) = cos(Theta);
E1(:,:,2) = sin(Theta);
E2(:,:,1) = -sin(Theta);
E2(:,:,2) = cos(Theta);