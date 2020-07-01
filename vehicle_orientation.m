function thita = vehicle_orientation(X,Y)

%
% Synartish ektymhshs tou Prosanatolismou
%

thita=[0];

[m n]=size(X);

for i=2:n
    
   
    t=rad2deg(atan2( (X(i)-X(i-1)),(Y(i)-Y(i-1))));
    t=t;
    thita=[thita t];
    
end


end