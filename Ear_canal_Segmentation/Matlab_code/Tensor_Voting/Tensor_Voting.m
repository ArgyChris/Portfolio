function [TensorOut] = Tensor_Voting(InputTensor,CachedTensorField,Image,Sigma,TypeOfVoting) 
%--------------------------------------------------------------------------
%This function applies the voting process, depending on the calling 
%arguments ball or stick voting is implemented. It involves the following
%steps

%Step1: Create the size of the kernel from the scale (Eq. 5.7), make the
%field size off if it is even [1]

%Step2: Resize the tensor to make calculations easier. This gives us a
%margin around the tensor that is as large as half the window of the voting
%field so we avoid operation outside the of the table

%Step3: Eigenvalue/vector decomposition to get probable locations of voting
%(ball and sticks) and the directions of the sticks there. 

%Step4: Selection of the type of voting: a)Ball, or b)Stick

    %Step4a,i):Construction of the Ball tensor field from the cached tensor
    %field.

    %Step4a,ii): Resize the image to make easier the access to the coordinates

    %Step4a,iii): For everything that is L1>0 in tensor T

    %Step4a,iv): Weight the Ball Field by the intensity of the Image

    %Step4a,v): Perform voting by simple tensor addition, namely element by
    %element addition

%Step4: Selection of type of the voting: a)Ball, or b)Stick

    %Step4b,i): For everything that is stick L1-L2>0 in tensor T

    %Step4b,ii): Find the direction of the stick (E1)

    %Step4b,iii): Construction of the Stick tensor field from the cached tensor
    %field.

    %Step4b,iv): Weight the Stick Field by the Saliency of the stick
    %(L1-L2)

    %Step4b,v): Perform voting by simple tensor addition, namely element by
    %element addition
    
%Step5: Resize the Tensor to reduce it in its original size
%--------------------------------------------------------------------------
%Arguments:
%               Input: 
%                        InputTensor->Is the tensor computed from previous
%                        step
%                        CachedTensorField-> Contains the stick voting field
%                        in all the available directions (I don't use it here)
%                        Image-> Input original image for weighting in ball 
%                        voting
%                        Sigma-> The scale parameter
%                        TypeOfVoting-> Ball or Stick
%               Output: 
%                        TensorOut -> Is the tensor after the voting
%--------------------------------------------------------------------------
%see also "Emerging Topics in Computer Vision" by G. Medioni and S.B. Kang

%Step1:
wsize = floor(ceil(sqrt(-log(0.01)*Sigma^2)*2)/2)*2+1;
wsize_half = (wsize-1)/2;

%Step2:
Th = size(InputTensor,1);
Tw = size(InputTensor,2);
TensorNew = zeros(Th+wsize_half*2,Tw+wsize_half*2,2,2,'double');
TensorNew((wsize_half+1):(wsize_half+Th),(wsize_half+1):(wsize_half+Tw),:,:) = InputTensor(1:end,1:end,:,:);
InputTensor = TensorNew;

%Step3:
[E1,~,L1,L2] =  Tensor_Decomposition(InputTensor);

%Step4a:
switch TypeOfVoting
    %Step4a:
    case 'Ball'
        %Step4a,i):
        Step = 32; %Interval parameter for the addition of individual sticks, 32 is the default value
%------------------------------------------------------------------------------------             
%         BallTensorField = CachedTensorField(round(0:360/Step:end-(360/Step))+1,:,:,:,:); %I round the angle to speed up the process, this is different than the original implementation
%         BallTensorField = sum(BallTensorField,1)/Step;
%         BallTensorField = reshape(BallTensorField,[wsize,wsize,2,2]);        
%------------------------------------------------------------------------------------
        BallTensorField = zeros(wsize,wsize,2,2);
        for Theta = (0:1/Step:1-1/Step)*2*pi
            v = [cos(Theta);sin(Theta)];
            B = Create_Stick_Tensor_Field(v,Sigma);
            BallTensorField = BallTensorField + B;
        end
%------------------------------------------------------------------------------------             
        BallTensorField = BallTensorField/Step;
   
        %Step4a,ii):
        ImageNew = zeros(size(Image,1)+wsize_half*2,size(Image,2)+wsize_half*2,'double');
        ImageNew((wsize_half+1):(wsize_half+Th),(wsize_half+1):(wsize_half+Tw)) = Image(1:end,1:end);
        %Step4a,iii):
        [RowIndex,ColIndex] = find(L1>0);       
         for i = 1:length(RowIndex)
            %Step4a,iv):
            WeightedTensorField = ImageNew(RowIndex(i),ColIndex(i))*BallTensorField;
            %Step4a,v):
            InputTensor(RowIndex(i)-wsize_half:RowIndex(i)+wsize_half,ColIndex(i)-wsize_half:ColIndex(i)+wsize_half,:,:) = ...
            InputTensor(RowIndex(i)-wsize_half:RowIndex(i)+wsize_half,ColIndex(i)-wsize_half:ColIndex(i)+wsize_half,:,:) + ...
            WeightedTensorField;
        end
    %Step4b:
    case 'Stick'
       %Step4b,i):
       [RowIndex,ColIndex] = find(L1-L2>0);
       for i = 1:length(RowIndex)
% %             %Step4b,ii):
            Direction = E1(RowIndex(i),ColIndex(i),:);   
            Direction = Direction(:);
% %             Angle = round(atan(Direction(2)/Direction(1))*(180/pi));
%%%%%%%%%%%%%%%%%%%%%%%%%%Fast implementation%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This part is commented because here we can have angles that cannot be
%precomputed, and so we can have approximation errors so I construct the
%stick voting field at each iteration
%             Angle = round(atan2(-Direction(1),Direction(2))*(180/pi));
%             if Angle<1
% % %                 Angle = 360-abs(Angle);
%                 Angle = Angle+180;
%             end
% % %             Step4b,iii):
%             StickTensorField = squeeze(CachedTensorField(Angle,:,:,:,:));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%           
%--------------------------------------------------------------------------------------------            
           StickTensorField = Create_Stick_Tensor_Field([-Direction(2),Direction(1)],Sigma);
%--------------------------------------------------------------------------------------------            
            %Step4b,iv):
            WeightedTensorField = (L1(RowIndex(i),ColIndex(i))-L2(RowIndex(i),ColIndex(i)))*StickTensorField;
            %Step4b,v):
            InputTensor(RowIndex(i)-wsize_half:RowIndex(i)+wsize_half,ColIndex(i)-wsize_half:ColIndex(i)+wsize_half,:,:) = ...
            InputTensor(RowIndex(i)-wsize_half:RowIndex(i)+wsize_half,ColIndex(i)-wsize_half:ColIndex(i)+wsize_half,:,:) + ...
            WeightedTensorField;
       end
    otherwise
        disp('Wrong arguments')
end
%Step5:
TensorOut = InputTensor((wsize_half+1):(wsize_half+Th),(wsize_half+1):(wsize_half+Tw),:,:);