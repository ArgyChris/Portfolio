%This script runs an example using the tensor voting framework.
%For this example, the input image is a series of points along the
%contour of a banana.
%The algorithm has the following steps. Different functions implement parts
%of the voting process.

%-------------------------------------------------------------------------
%The steps are the following:

%Step1: We read the image and set the parameter, Sigma is the size of
%voting it is like a scale parameter

%Step2: We precompute a series of stick voting fields that can be used for
%constructing: i) the ball voting field, and ii) the stick voting (here we
%do not precompute the sticks because we can have angles that are not
%covered)

%Step3: We perform token representation; for the simplest case (here) each
%pixel that has positive grayscale intensity value (positive weight in step
%5) is assigned the identity matrix. 

%Step4: Ball Tensor Voting is performed here

%Step5: The Ball Voting is sparse, namely it is performed only between
%tokens, so we can erase values from non-tokens

%Step6: Stick Tensor Voting is performed here

%Step7: The final Saliency is given by L1-L2 the eigenvalues of the final
%tensor

%Step8: Simple thresholding to remove noise, stick voting is dense so it
%assigns saliency in all the pixels

%Step9: Non maxima suppression for the extraction of centerlines

%--------------------------------------------------------------------------
%Useful publications:
%[1] "Emerging Topics in Computer Vision" by G. Medioni and S.B. Kang
%[2] "A Computational Framework for Segmentation and Grouping" by G. Medioni
%    , Mi-Suen Lee and Chi-Keung Tang 
%[3] "First Order Augmentation to Tensor Voting for Boundary Inference and 
%  Multiscale Analysis in 3D" IEEE TPAMI 2004, W-S Tong, C-K Tang, P.
%  Mordohai, and G. Medioni
%--------------------------------------------------------------------------

%Step 1
load banana
Image = Banana_Image;
figure; imshow(Image)
Image(111,258)=1;
Sigma = 25;
%Step 2
CachedStickField = Precompute_Stick_Tensor_Field(Sigma);

% Image = double(Image) / double(max(Image(:)));
%Step 3
TokenField = Token_Representation(Image);
%Step 4
BallTensorField = Tensor_Voting(TokenField,CachedStickField,Image,Sigma,'Ball');
%Step 5
[Rows,Cols] = find(Image==0);
for i=1:length(Rows)
    BallTensorField(Rows(i),Cols(i),1,1) = 0;
    BallTensorField(Rows(i),Cols(i),1,2) = 0;
    BallTensorField(Rows(i),Cols(i),2,1) = 0;
    BallTensorField(Rows(i),Cols(i),2,2) = 0;
end
SparseVoting = TokenField + BallTensorField;
[E1,E2,L1,L2] = Tensor_Decomposition(SparseVoting);
L2(:) = 0;
ZeroL2TensorField = Tensor_Reconstruction(E1,E2,L1,L2);
%Step 6
DenseVoting = Tensor_Voting(ZeroL2TensorField,CachedStickField,L1,Sigma,'Stick');

[E1,E2,L1Dense,L2Dense]= Tensor_Decomposition(DenseVoting);
%Step 7
Saliency = L1Dense-L2Dense;
figure; imshow(Saliency,[])
%Step 8
L1Dense(Saliency<0.3) = 0;
L2Dense(Saliency<0.3) = 0;
FinalTensorField = Tensor_Reconstruction(E1,E2,L1Dense,L2Dense);
%Step 9
Centerline = Non_Maxima_Saliency_Suppression(FinalTensorField,15,pi/8);

figure; imshow(Centerline)