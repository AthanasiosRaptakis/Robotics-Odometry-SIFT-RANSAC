function [mean_dx,mean_dy]=estimate_translation_v2(I0,I1,k)

I0=cast(I0,'single');
I1=cast(I1,'single');

[F0,D0] = VL_SIFT(I0);
[F1,D1] = VL_SIFT(I1);

points1=[ ];
points2=[ ];

 mean_dx=0;
 mean_dy=0;
  
 thres=100;
 
[MATCHES,SCORES] = VL_UBCMATCH(D0,D1,thres);

[m n]=size(MATCHES);

for i=1:n

x1=F0(1,MATCHES(1,i));
y1=F0(2,MATCHES(1,i));

x2=F1(1,MATCHES(2,i));
y2=F1(2,MATCHES(2,i));

end


for i=1:n

x1=F0(1,MATCHES(1,i));
y1=F0(2,MATCHES(1,i));

x2=F1(1,MATCHES(2,i));
y2=F1(2,MATCHES(2,i));

points1=[points1;x1 y1];

points2=[points2;x2 y2];
       
end    

%'aff_lsq'
%'proj_svd'

[ T_im1, best_pts ] = ransac( points1, points2,'proj_svd',10);


[m n]=size(best_pts);


for i=1:m

x1=best_pts(i,1);
y1=best_pts(i,2);

x2=best_pts(i,3);
y2=best_pts(i,4);

dx(i)=x2-x1;
dy(i)=y2-y1;

end

Im=[I0 I1];

figure(k+1), hold on
imshow(Im,[ ])

for i=1:m
    
x1=best_pts(i,1);
y1=best_pts(i,2);

x2=best_pts(i,3);
y2=best_pts(i,4);

hold on
line([x1 x2+256],[y1 y2])
hold on
plot(x1,y1,'*r' )
hold on
plot(x2+256,y2,'xg')

end


end




































