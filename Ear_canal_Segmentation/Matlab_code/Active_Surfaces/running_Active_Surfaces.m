%figure; imshow(Ioutput(:,:,30))
%[x,y]=getpts;                                   %We select the points based on the in-built getpts() function

%Good parameters for subject 750_R
%Alpha = 0.2
%Beta = 0.1
%Tau=0.25

x  = 150; %for subject:750_L
y  = 150;
x
y
Center_of_circle=[x,y]; % centre of the initial snake
Radius=30;
Number_of_points=25; 
size_slice=83;

Initial_Snake=round([Center_of_circle(1)+Radius*cos(0:(2*pi/(Number_of_points-1)):(2*pi));Center_of_circle(2)+Radius*sin(0:(2*pi/(Number_of_points-1)):(2*pi)) ]);
originalSpacing = 1 : length(Initial_Snake(1,:));                %We increase the spacing, we apply splines
finerSpacing = 1 : 0.1 : length(Initial_Snake(1,:));         
vertex=[Initial_Snake(1,:);Initial_Snake(2,:)];
splineXY = spline(originalSpacing, vertex, finerSpacing);
%hold on;
%handles.getpts=plot(vertex(1, :), vertex(2, :), 'r*', splineXY(1, :), splineXY(2, :));    %We plot the selected points
%hold off;
snaxels=cell(1,0);
snaxels{end+1}=splineXY;                       %We save the selected points
Contour=repmat(snaxels{end},[1 1 size_slice]);

Vertex2DX=zeros(size(Contour,2),size(Contour,3));
Vertex2DY=zeros(size(Contour,2),size(Contour,3));
Vertex2DZ=zeros(size(Contour,2),size(Contour,3));

for i=1:size(Contour,3)
    Vertex2DX(:,i)=Contour(1,:,i);
    Vertex2DY(:,i)=Contour(2,:,i);
    Vertex2DZ(:,i)=i;    
end

Radius = 32;
Gamma = 2;
K = AM_VFK(3, Radius, 'power',Gamma);
Fext=AM_VFC(Ioutput_FINAL(:,:,1:83),K,1);
s0 = 1;
i=1;
result_time = 0;
iterations = 500;
tolerance = 450;

Alpha = 0.3;
Beta = 0.1;
Tau = 0.25;

snake_Vertex2DX=Vertex2DX;
snake_Vertex2DY=Vertex2DY;
snake_Vertex2DZ=Vertex2DZ;

figure;
while (i<iterations+1) 
        tic
        [snake_Vertex2DX(:,:,end+1),snake_Vertex2DY(:,:,end+1),snake_Vertex2DZ(:,:,end+1)]= AC_deform3D(snake_Vertex2DX(:,:,end),snake_Vertex2DY(:,:,end),snake_Vertex2DZ(:,:,end),Alpha,Beta,Tau,Fext,5);
        elasped_time=toc;
        if mod(i,1)==0
            if s0==size(snake_Vertex2DZ,2) 
               s0=1;
            end
            s0=s0+1;  
            imshow(Ioutput_FINAL(:,:,round(snake_Vertex2DZ(1,s0))),[]); 
            hold on;
            plot(snake_Vertex2DX(:,s0,end),snake_Vertex2DY(:,s0,end),'g');
            drawnow
            hold off;
            xlabel({['VFC' ' iteration ' num2str(i), ' slice: ', int2str(s0)]})
        end
        result_time=result_time+elasped_time;
        distance=sum(sum(sqrt(((snake_Vertex2DX(:,:,end)-snake_Vertex2DX(:,:,end-1)).^2+((snake_Vertex2DY(:,:,end)-snake_Vertex2DY(:,:,end-1)).^2)+((snake_Vertex2DZ(:,:,end)-snake_Vertex2DZ(:,:,end-1)).^2)))))
        if (distance<=tolerance)
            break;
        end
        i=i+1;
end



%visualize the final result
%figure; imshow(Ioutput(:,:,1),[]); hold on; plot(snake_Vertex2DX(:,1,end),snake_Vertex2DY(:,1,end),'g');
