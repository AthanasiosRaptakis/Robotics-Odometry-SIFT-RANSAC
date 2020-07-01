function [linear_velocity,rotational_velocity] = vehicle_velocity(X,Y,thita)

%
% Sinartish upologismou ths taxuthtas 
%

[m n]=size(X);

linear_velocity=[0];

rotational_velocity=[0];

for i=2:n

dx=X(i)-X(i-1);

dy=Y(i)-Y(i-1);

w=deg2rad(thita(i)-thita(i-1));

v=sqrt(dx^2+dy^2);

linear_velocity=[linear_velocity v];

rotational_velocity=[rotational_velocity w];

end