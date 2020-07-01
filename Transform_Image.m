function temp2=Transform_Image(temp,Tform,i)


for j=1:(i-1)
        
      temp2=imtransform(temp,Tform(j));
       
      temp=temp2;
end

temp2=Reduce_size(temp2);

end



