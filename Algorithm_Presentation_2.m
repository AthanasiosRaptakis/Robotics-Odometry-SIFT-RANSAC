function Algorithm_Presentation_2(I0,I1)

clc
close all

i=2;
[Temp,Tform]=Estimate_Transform(I0,I1);

T=Tform.tdata.T

T_inv=Tform.tdata.Tinv

temp2=Transform_Image(I1,Tform,i);

[tx,ty]=Estimate_Translation(I0,temp2);

figure(1)
imshow(I0,[ ])
 
figure(2)
imshow(I1,[ ])


figure(3)
imshow(temp2,[ ])

D=padarray(I0,[50 50]);

[m n]=size(temp2);


for i=1:m
    for j=1:n

        if temp2(i,j)>0
            
           D(i+50+tx,j+50+ty)=temp2(i,j);
           
        end
    end
end
        
        
        
figure(4)
imshow(D,[ ])








































































end