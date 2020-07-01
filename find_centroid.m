function [cx,cy] = find_centroid(temp2)

f=temp2;

[m n]=size(f);


for i=1:m
    for j=1:n
        
   if f(i,j)>0
       
       S(i,j)=1;
       
   else
       
       S(i,j)=0;
       
   end
        
    end
end


c = regionprops(S,'Centroid');

cx=round(c.Centroid(1,1));

cy=round(c.Centroid(1,2));

end
