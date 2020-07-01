function [mean_dx,mean_dy]=estimate_translation(I0,I1,k)

mean_dx=0;
mean_dy=0;

I0=cast(I0,'single');
I1=cast(I1,'single');

[F0,D0] = VL_SIFT(I0);
[F1,D1] = VL_SIFT(I1);

thres=120;

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
th(i)=abs(dy(i)/dx(i));
end

mean_l=0;
mean_th=0;

for i=1:n
    
mean_l=mean_l+l(i);
mean_th=mean_th+th(i);

end

mean_l=mean_l/n;
mean_th=mean_th/n;
Im=[I0 I1];

figure(k+1), hold on
imshow(Im,[ ])

for i=1:n

    if l(i)<=1.05*mean_l&&l(i)>=0.95*mean_l
    
    mean_dx=mean_dx+dx(i);
    mean_dy=mean_dy+dy(i);
    
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
















