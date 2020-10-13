load('volume_with_ref_seg.mat')
volume_with_ref_seg=permute(volume_with_ref_seg, [1,3,2]);
volume_with_ref_seg=permute(volume_with_ref_seg, [3,2,1]);
figure; imshow(volume_with_ref_seg(:,:,1),[])
figure; imshow(volume_with_ref_seg(:,:,200),[])
load data_orig_750_L
data_orig_750_L=permute(data_orig_750_L,[1,3,2]);
data_orig_750_L=permute(data_orig_750_L,[3,2,1]);
figure; imshow(volume_with_ref_seg(:,:,200),[])
figure; imshow(data_orig_750_L(:,:,200),[])
cd MatlabCode/
load variables_18_4
figure; imshow(Ioutput_FINAL(200,:,:))
figure; imshow(Ioutput_FINAL(:,:,83))
cropped_volume_with_red_seg=volume_with_ref_seg(283-150:283+150, 355-150:355+150, 200-41:200+41);
figure; imshow(Ioutput_FINAL(:,:,83))
figure; imshow(cropped_volume_with_red_seg(:,:,83))
figure; imshow(Ioutput_FINAL(:,:,40))
figure; imshow(cropped_volume_with_red_seg(:,:,40))
figure; imshow(ref_I_slice_60,[]); hold on; plot(snake_Vertex2DX(:,60,end),snake_Vertex2DY(:,60,end),'g');
figure; imshow(I(:,:,60),[]); hold on; plot(snake_Vertex2DX(:,60,end),snake_Vertex2DY(:,60,end),'g');
load data_ref_750_L
data_ref_750_L=permute(data_ref_750_L,[1,3,2]);
data_ref_750_L=permute(data_ref_750_L,[3,2,1]);
figure; imshow(data_ref_750_L(:,:,200),[])
figure; imshow(data_orig_750_L(:,:,200),[])
figure; imshow(cropped_red_VOI_750_L(:,:,200),[])
cropped_volume_with_original=data_orig_750_L(283-150:283+150, 355-150:355+150, 200-41:200+41);
figure; imshow(cropped_red_VOI_750_L(:,:,40),[])
figure; imshow(cropped_volume_with_red_seg(:,:,40),[])
figure; imshow(cropped_volume_with_original(:,:,40),[])
figure; imshow(cropped_volume_with_red_seg(:,:,40),[])
figure; imshow(Ioutput(:,:,1),[]); hold on; plot(snake_Vertex2DX(:,1,end),snake_Vertex2DY(:,1,end),'g');
figure; imshow(Ioutput_FINAL(:,:,1),[]); hold on; plot(snake_Vertex2DX(:,1,end),snake_Vertex2DY(:,1,end),'g');
figure; imshow(Ioutput_FINAL(:,:,40),[]); hold on; plot(snake_Vertex2DX(:,40,end),snake_Vertex2DY(:,40,end),'g');
figure; imshow(cropped_volume_with_original(:,:,40),[]); hold on; plot(snake_Vertex2DX(:,40,end),snake_Vertex2DY(:,40,end),'g');
cropped_volume_with_ref_seg=cropped_volume_with_red_seg;
clear cropped_volume_with_red_seg
figure; imshow(cropped_volume_with_original(:,:,40),[]); hold on; plot(snake_Vertex2DX(:,40,end),snake_Vertex2DY(:,40,end),'g');
size(snake_Vertex2DX)
figure; imshow(cropped_volume_with_original(:,:,40),[]); hold on; plot(snake_Vertex2DX(:,40,end),snake_Vertex2DY(:,40,end),'g');
figure; imshow(cropped_volume_with_original(:,:,40),[]); hold on; plot(snake_Vertex2DX(:,40,end-50),snake_Vertex2DY(:,40,end-50),'g');
figure; imshow(cropped_volume_with_original(:,:,40),[]); hold on; plot(snake_Vertex2DX(:,40,end-200),snake_Vertex2DY(:,40,end-200),'g');
figure; imshow(cropped_volume_with_original(:,:,40),[]); hold on; plot(snake_Vertex2DX(:,40,end-280),snake_Vertex2DY(:,40,end-280),'g');
figure; imshow(cropped_volume_with_original(:,:,40),[]); hold on; plot(snake_Vertex2DX(:,40,end-270),snake_Vertex2DY(:,40,end-270),'g');
figure; imshow(cropped_volume_with_original(:,:,40),[]); hold on; plot(snake_Vertex2DX(:,40,end-250),snake_Vertex2DY(:,40,end-250),'g');
help regionfill
help imfill
Islice=zeros(size(cropped_volume_with_original(:,:,40)));
lenght(snake_Vertex2D(:,40,end))
size(snake_Vertex2D(:,40,end))
lenght(snake_Vertex2DX(:,40,end))
length(snake_Vertex2DX(:,40,end))
for i=1:length(snake_Vertex2DX(:,40,end))
Islice(snake_Vertex2DX(i,40,end),snake_Vertex2DY(i,40,end))=1;
end
for i=1:length(snake_Vertex2DX(:,40,end))
Islice(round(snake_Vertex2DX(i,40,end)),round(snake_Vertex2DY(i,40,end)))=1;
end
figure; imshow(Islice)
Islice=zeros(size(cropped_volume_with_original(:,:,40)));
for i=1:length(snake_Vertex2DX(:,40,end))
Islice(round(snake_Vertex2DY(i,40,end)),round(snake_Vertex2DX(i,40,end)))=1;
end
figure; imshow(Islice)
figure; imshow(cropped_volume_with_original(:,:,40),[]); hold on; plot(snake_Vertex2DX(:,40,end-250),snake_Vertex2DY(:,40,end-250),'g');
figure; imshow(cropped_volume_with_original(:,:,40),[]); hold on; plot(snake_Vertex2DX(:,40,end),snake_Vertex2DY(:,40,end),'g');
help imfill
help convexhull
figure; imshow(Islice)
help roipoly
Islice=zeros(size(cropped_volume_with_original(:,:,40)));
BW=roipoly(Islice,snake_Vertex2DY(:,40,end),snake_Vertex2DX(:,40,end));
figure; imshow(BW)
BW=roipoly(Islice,snake_Vertex2DX(:,40,end),snake_Vertex2DY(:,40,en,snake_Vertex2DX(:,40,end),snake_Vertex2DY(:,40,end));
figure; imshow(BW)
figure; imshow(cropped_volume_with_original(:,:,40),[]); hold on; plot(snake_Vertex2DX(:,40,end),snake_Vertex2DY(:,40,end),'g');
figure; imshow(BW)
figure; imshow(BW,[]); hold on; plot(snake_Vertex2DX(:,40,end),snake_Vertex2DY(:,40,end),'g');
figure; imshow(cropped_volume_with_ref_seg(:,:,40))
figure; imshow(BW)
or symbol
andImage = and(BW, cropped_volume_with_ref_seg(:,:,40));
orImage = or(BW, cropped_volume_with_ref_seg(:,:,40));
diceI = 2*sum(andImage)/sum(orImage);
figure; imshow(cropped_volume_with_ref_seg(:,:,40))
figure; imshow(BW)
figure; imshow(andImage)
figure; imshow(orImage)
figure; imshow(diceI)
diceI
commonI = andImage;
a = sum(commonI(:));
b1 = cropped_volume_with_ref_seg(:,:,40);
b = sum(b1(:));
c = sum(BW(:));
diceI2 = 2*a/(b+c);
diceI2
figure; imshow(cropped_volume_with_ref_seg(:,:,40),[])
SE=strel(1,'disk')
SE=strel(3,'disk')
SE=strel('disk',1)
erodedRef=imerode(cropped_volume_with_ref_seg(:,:,40), SE);
figure; imshow(erodedRef,[])
figure; imshow(cropped_volume_with_ref_seg(:,:,40),[])
figure; imshow(erodedRef,[])
figure; imshow(cropped_volume_with_ref_seg(:,:,40)-erodedRef,[])
help bwdist
contourRef = cropped_volume_with_ref_seg(:,:,40)-erodedRef;
figure; imshow(contourRef
figure; imshow(contourRef)
DistRef = bwdist(contourRef);
figure; imshow(DistRef,[])
figure; imshow(DistRef,[], colormap=jet)
figure; imshow(DistRef,[], map=jet)
figure; imshow(BW,[])
figure; imshow(BW-imerode(BW,SE),[])
figure; imshow(BW,[])
ind = find(BW-imerode(BW,SE));
figure; imshow(DistRef,[])
val=sum(DistRef(ind))
cd MatlabCode/
ls



figure; imshow(cropped_volume_with_original(:,:,40),[]); hold on; 
plot(snake_Vertex2DX(:,40,1),snake_Vertex2DY(:,40,1), 'r'); hold on;
plot(snake_Vertex2DX(:,40,end),snake_Vertex2DY(:,40,end),'g');

figure; imshow(BW_my_method(:,:,40),[]); 
figure; imshow(cropped_volume_with_ref_seg(:,:,40),[]);


SE=strel('disk',1)
for i=1:83
    BW_reference_contour(:,:,i) = cropped_volume_with_ref_seg(:,:,i)-imerode(cropped_volume_with_ref_seg(:,:,i), SE);
    i
end

BW_my_method_contour=zeros(301,301,83);
SE=strel('disk',1)
for i=1:83
    BW_my_method_contour(:,:,i) = BW_my_method(:,:,i)-imerode(BW_my_method(:,:,i), SE);
    i
end

for i=1:83
    commonI = and(BW_my_method(:,:,i), cropped_volume_with_ref_seg(:,:,i));
    a=sum(commonI(:));
    b1=cropped_volume_with_ref_seg(:,:,i);
    b=sum(b1(:));
    secondI=BW_my_method(:,:,i);
    c=sum(secondI(:));
    DiceMeasure(i)=2*a/(b+c);
end


figure; imshow(cropped_volume_with_original(:,:,27),[]); hold on; 
plot(snake_Vertex2DX(:,27,end),snake_Vertex2DY(:,27,end),'g');
figure; imshow(cropped_volume_with_ref_seg(:,:,27),[]);

figure; imshow(cropped_volume_with_original(:,:,83),[]); hold on; 
plot(snake_Vertex2DX(:,83,end),snake_Vertex2DY(:,83,end),'g');
figure; imshow(cropped_volume_with_ref_seg(:,:,83),[]);

DistanceReference = zeros(301,301,83);
for i=1:83
    D = bwdist(BW_reference_contour(:,:,i));
    DistanceReference(:,:,i)=D;
end



DistanceMeasure=zeros(1,83);
for i=1:83
    ind = find(BW_my_method_contour(:,:,i)>0);
    D=DistanceReference(:,:,i);
    DistanceMeasure(i)=sum(D(ind));
end



figure; imshow(cropped_volume_with_original(:,:,27),[]); hold on; 
indMyMethod = find(BW_my_method_contour(:,:,27)>0);
indReference = find(BW_reference_contour(:,:,27)>0);
[indX1, indY1] = ind2sub(BW_my_method_contour(:,:,27), indMyMethod);
[indX2, indY2] = ind2sub(BW_reference_contour(:,:,27), indReference);
for i=1:size(indX1,1)
    plot(indX1(i), indY1(i), 'g'); hold on;
end
for i=1:size(indX2,1)
    plot(indX2(i), indY2(i), 'b'); hold on;
end

