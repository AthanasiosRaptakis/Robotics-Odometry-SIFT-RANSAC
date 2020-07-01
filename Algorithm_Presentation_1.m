function Algorithm_Presentation_1(I0,I1,thres)

close all
clc


mean_l=0;


I0=cast(I0,'single');
I1=cast(I1,'single');

[F0,D0] = VL_SIFT(I0);
[F1,D1] = VL_SIFT(I1);


[MATCHES,SCORES] = VL_UBCMATCH(D0,D1,thres);

[m n]=size(MATCHES);

for i=1:n

x1=F0(1,MATCHES(1,i));
y1=F0(2,MATCHES(1,i));

x2=F1(1,MATCHES(2,i));
y2=F1(2,MATCHES(2,i));

dx(i)=x2-x1;
dy(i)=y2-y1;

l(i)=sqrt(dx(i)^2+dy(i)^2);

end


Im1=[I0 I1];

figure(1), hold on
imshow(Im1,[ ])

for i=1:n
   
x1=F0(1,MATCHES(1,i));
y1=F0(2,MATCHES(1,i));

x2=F1(1,MATCHES(2,i));
y2=F1(2,MATCHES(2,i));

hold on
line([x1 x2+256],[y1 y2])
hold on
plot(x1,y1,'*r' )
hold on
plot(x2+256,y2,'xg')

end
    


for i=1:n
    
mean_l=mean_l+l(i);

end

mean_l=mean_l/n;




Im2=[I0 I1];

figure(2), hold on
imshow(Im2,[ ])



for i=1:n

    if l(i)<=1.2*mean_l&&l(i)>=0.8*mean_l
    
    
x1=F0(1,MATCHES(1,i));
y1=F0(2,MATCHES(1,i));

x2=F1(1,MATCHES(2,i));
y2=F1(2,MATCHES(2,i));

hold on
line([x1 x2+256],[y1 y2])
hold on
plot(x1,y1,'*r' )
hold on
plot(x2+256,y2,'xg')

    end
    
end
























end