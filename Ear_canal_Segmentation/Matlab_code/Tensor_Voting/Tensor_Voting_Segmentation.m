
%To load and transform the data according to the python coordinate system
%data_orig_750_L=permute(data_orig_750_L, [1,3,2]);
%data_orig_750_L=permute(data_orig_750_L, [3,2,1]);

%cropped_VOI_750_L=data_orig_750_L(283-150:283+150, 355-150:355+150, 200-41:200+41); %The center will be in [150,150]


Ioutput_FINAL=zeros(301,301,83);

for z=1:83
    Islice = cropped_VOI_750_L(:,:,z);    
    Ibone=zeros(301,301);
    
    BWsobel = edge(Islice,'Sobel');
    
    ind1=find(BWsobel>0);ind1=find(BWsobel>0);
 
    Ibone(ind1)=Islice(ind1);
    Ibone = Ibone>300;
    
    Sigma = 15; %for the fragmented line Sigma=5, for the fragmented circle Sigma=5, 
    %Step 2
    CachedStickField = Precompute_Stick_Tensor_Field(Sigma);

    TokenField = Token_Representation(double(Ibone));
    BallTensorField = Tensor_Voting(TokenField,CachedStickField,Ibone,Sigma,'Ball');
    [Rows,Cols] = find(Ibone==0);
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
    %Step 8
    L1Dense(Saliency<0.3) = 0;
    L2Dense(Saliency<0.3) = 0;

    %L1Dense(Saliency<1000) = 0;
    %L2Dense(Saliency<1000) = 0;
    FinalTensorField = Tensor_Reconstruction(E1,E2,L1Dense,L2Dense);
    %Step 9
    Centerline = Non_Maxima_Saliency_Suppression(FinalTensorField,15,pi/8);
    
    
    Ioutput_FINAL(:,:,z) = bwareaopen(Centerline, 3);
    %Ioutput(:,:,z) = Centerline;
    z
end