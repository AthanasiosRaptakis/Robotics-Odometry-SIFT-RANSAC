clc
clear
close all

% Arxikopoihsh

I(1,:,:)=imread('im0.tiff');
I(2,:,:)=imread('im1.tiff');
I(3,:,:)=imread('im2.tiff');
I(4,:,:)=imread('im3.tiff');
I(5,:,:)=imread('im4.tiff');
I(6,:,:)=imread('im5.tiff');
I(7,:,:)=imread('im6.tiff');
I(8,:,:)=imread('im7.tiff');
I(9,:,:)=imread('im8.tiff');
I(10,:,:)=imread('im9.tiff');
I(11,:,:)=imread('im10.tiff');
I(12,:,:)=imread('im11.tiff');
I(13,:,:)=imread('im12.tiff');
I(14,:,:)=imread('im13.tiff');
I(15,:,:)=imread('im14.tiff');
I(16,:,:)=imread('im15.tiff');
I(17,:,:)=imread('im16.tiff');
I(18,:,:)=imread('im17.tiff');
I(19,:,:)=imread('im18.tiff');
I(20,:,:)=imread('im19.tiff');
I(21,:,:)=imread('im20.tiff');
I(22,:,:)=imread('im21.tiff');
I(23,:,:)=imread('im22.tiff');
I(24,:,:)=imread('im23.tiff');
I(25,:,:)=imread('im24.tiff');
I(26,:,:)=imread('im25.tiff');
I(27,:,:)=imread('im26.tiff');
I(28,:,:)=imread('im27.tiff');
I(29,:,:)=imread('im28.tiff');
I(30,:,:)=imread('im29.tiff');
I(31,:,:)=imread('im30.tiff');
I(32,:,:)=imread('im31.tiff');

Xx=[128];
Yy=[128];

xx=[128+50];
yy=[128+50];

Tx=0;
Ty=0;

% Anoigma arxeiwn video
 
Trajectory_Video = avifile('Robotics_Odometry_Project/video/Trajectory_Video.avi','fps',1);

Optical_Flow_Video = avifile('Robotics_Odometry_Project/video/Robot_Animation_Video.avi','fps',1);

% Ypologismos olwn twn metasxhmatismvn metaksi In In-1

for i=1:31
    
     for k=1:256
        for l=1:256
            
        I0(k,l)=I(i,k,l);
        I1(k,l)=I(i+1,k,l);
        
        end
    end
    
    [Temp,T]=Estimate_Transform(I0,I1);
 
 Tform(i)=T;
 
end

% o algorithmos trexei gia to prwto shmeio

 for k=1:256
        for l=1:256
            
      transformed(1,k,l)=I(1,k,l);      
      
       D(k,l)=I(1,k,l);  
       
        end
 end
    
previus=D;

D=padarray(D,[50 50]);

% plot ta figures
% dhmiourgia video kai apothikeush eikonwn

figure(1)
imshow(D,[ ])

hold on
plot(Ty+50+128,Tx+50+128,'o','LineWidth',2, 'MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',50)
hold on
plot(Ty+50+128,Tx+50+128,'o','LineWidth',1, 'MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',15)


hold on
plot(xx, yy,'rs','LineWidth',1.5, 'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',5)





i=1;

image_name = 'Robotics_Odometry_Project/photos/Panorama_';
   
  filename = sprintf('%s%d.jpeg',image_name , i );

  imwrite(D,filename,'jpeg');
  
  
[X, map] = gray2ind(D,256);

X = imresize(X, [480 640],'nearest');

F = im2frame(X,map);

Trajectory_Video = addframe(Trajectory_Video ,F);

  
   frame = getframe(gca);
   
   image_name1 = 'Robotics_Odometry_Project/photos/Optical_Flow_';
   
   filename1 = sprintf('%s%d.jpeg',image_name1 , i );

   imwrite(frame.cdata,filename1);

   frame.cdata= imresize(frame.cdata,[480 640],'nearest');
   
   Optical_Flow_Video  = addframe(Optical_Flow_Video,frame);
   
   % o algorithmos sunexizei gia ta bhmata 2 ews 31

for i=2:31

    
    
    for k=1:256
        for l=1:256
            
        temp(k,l)=I(i,k,l);
        
        end
    end
    
    % peristrefoume thn eikona
    
    temp2=Transform_Image(temp,Tform,i);
  
    % Ypologizoume thn metatopish ws pros thn prohgoumenh eikona tx, ty
[tx,ty,best_pts]=Estimate_Translation(previus,temp2);
     
% athrizoume thn metatopish me ;oles tis prohgoumenes metatopiseis

 Tx=Tx+tx;
 Ty=Ty+ty;


 previus=temp2;

[m1 n1]=size(temp2);

% ypologizoume to kentroides ths periestramenhs eikonas

[cx,cy] = find_centroid(temp2);

% yperthetoume thn periestramenh eikona sto panorama

for k=1:m1
    for l=1:n1
        
        if temp2(k,l)>0
                            
        D(k+Tx+50,l+Ty+50)=temp2(k,l);           
        
        end
        
    end
end


D1=padarray(D,[50 50],'post');

% kanoume plot thn troxia kai th diadikasia dhmiourgias tou panoramatos

figure(i),hold on
imshow(D1,[ ])

for j=1:10
    
    hold on
    line([(best_pts(j,1)+50+Ty) (best_pts(j,3)+50+Ty)],[(best_pts(j,2)+50+Tx) (best_pts(j,4)+50+Tx)])
    hold on
    plot(best_pts(j,1)+50+Ty,best_pts(j,2)+50+Tx,'*r')
    hold on
    plot(best_pts(j,3)+50+Ty,best_pts(j,4)+50+Tx,'og')
    
end

% diorthwnoume thn troxia prosthetontas to kentroides

Xx=[Xx Tx+cx];
Yy=[Yy Ty+cy];

xx=[xx Tx+cx+50];
yy=[yy Ty+cy+50];

% kanoume plot ta dedomena kai apothikeuoume to binteo kai tis eikones

hold on
plot(Ty+50+cy,Tx+50+cx,'o','LineWidth',2, 'MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',50)
hold on
plot(Ty+50+cy,Tx+50+cx,'o','LineWidth',1, 'MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',15)

[m1 n1]=size(Xx);

    
hold on
plot(yy, xx,'-.rs','LineWidth',1.5, 'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',5)


image_name = 'Robotics_Odometry_Project/photos/Panorama_';
   
filename = sprintf('%s%d.jpeg',image_name , i );

imwrite(D1,filename,'jpeg');


[X, map] = gray2ind(D,256);

X = imresize(X, [480 640],'nearest');

F = im2frame(X,map);

Trajectory_Video = addframe(Trajectory_Video ,F);

frame = getframe(gca);

image_name1 = 'Robotics_Odometry_Project/photos/Optical_Flow_';
   
filename1 = sprintf('%s%d.jpeg',image_name1 , i );

imwrite(frame.cdata,filename1);   
frame.cdata= imresize(frame.cdata, [480 640],'nearest');
   
Optical_Flow_Video = addframe(Optical_Flow_Video,frame);


end

Trajectory = close(Trajectory_Video);

Optical_Flow = close(Optical_Flow_Video);

% plot Troxia

figure(32)
plot(Xx,Yy,'-*')

frame1 = getframe(gca);
imwrite(frame1.cdata,'Robotics_Odometry_Project/photos/Trajectory_Plot.jpeg');  

thita = vehicle_orientation(Xx,Yy);


% plot prosanatolismo

figure(33)
plot(thita,'-.o')

frame = getframe(gca);
imwrite(frame.cdata,'Robotics_Odometry_Project/photos/Vehicle_Orientation.jpeg');   

[linear_velocity,rotational_velocity] = vehicle_velocity(Xx,Yy,thita);

% plot grammikh Taxuthta

figure(34)
plot(linear_velocity,'-.x')

frame = getframe(gca);
imwrite(frame.cdata,'Robotics_Odometry_Project/photos/Linear_Velocity.jpeg');   

% plot gwniakh Taxuthta


figure(35)
plot(rotational_velocity,'-.v')

frame = getframe(gca);
imwrite(frame.cdata,'Robotics_Odometry_Project/photos/Rotational_Velocity.jpeg');   











   