function reduced_Image=Reduce_size(image)

%
%     Synarthsh pou upologizei ta oria ths eikonas kai kanei th diastash
%     ths th mikroterh dunath AFAIRWNTAS to mauro backround
%



Binary=image;

[m n]=size(Binary);

for i=1:m
    for j=1:n
        
if Binary(i,j)>0
    Binary(i,j)=1;
else
    Binary(i,j)=0;
end           
        
    end
end

boundary = bwperim(Binary); 

Extrema = regionprops(boundary,'Extrema');

X=[Extrema.Extrema(1,1),Extrema.Extrema(2,1),Extrema.Extrema(3,1), Extrema.Extrema(4,1),Extrema.Extrema(5,1),Extrema.Extrema(6,1), Extrema.Extrema(7,1),Extrema.Extrema(8,1)];
Y=[Extrema.Extrema(1,2),Extrema.Extrema(2,2),Extrema.Extrema(3,2), Extrema.Extrema(4,2),Extrema.Extrema(5,2),Extrema.Extrema(6,2), Extrema.Extrema(7,2),Extrema.Extrema(8,2)];

xmin=min(X);
ymin=min(Y);

height=max(X)-min(X);
width=max(Y)-min(Y);

rect=[xmin ymin width height];

reduced_Image = imcrop(image,rect);

end

































