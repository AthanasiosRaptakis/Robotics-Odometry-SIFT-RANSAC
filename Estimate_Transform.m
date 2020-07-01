
function [Temp,Tform]=Estimate_Transform(I0,I1)

% Synartish h opoia mas dinei to metasxhmatismo anamesa se duo diadoxikes
% eikones

X=[ ];
U=[ ];
I0=cast(I0,'single');
I1=cast(I1,'single');

% Ypologismos perigrafewn SHIFT

[F0,D0] = VL_SIFT(I0);
[F1,D1] = VL_SIFT(I1);

thres=30;

 % Euresh koinwn shmeiwn metrontas thn apostash twn Descriptors me polu
 % austiro katofli to 30

[MATCHES,SCORES] = VL_UBCMATCH(D0,D1,thres);

[m n]=size(MATCHES);

% Euresh mesou mhkous dianismatos optikhs rois

for i=1:n

x1=F0(1,MATCHES(1,i));
y1=F0(2,MATCHES(1,i));

x2=F1(1,MATCHES(2,i));
y2=F1(2,MATCHES(2,i));

dx(i)=x2-x1;
dy(i)=y2-y1;

l(i)=sqrt(dx(i)^2+dy(i)^2);
end

mean_l=0;

for i=1:n
    
mean_l=mean_l+l(i);

end

mean_l=mean_l/n;

Clean_Matches=[ ];
distance=[ ];

% Mono oi antistoixies shmeiwn me mikos apo 0.9 ews 1.1 thewrountai inliers

for i=1:n

    if l(i)<=1.1*mean_l&&l(i)>=0.9*mean_l

x1=F0(1,MATCHES(1,i));
y1=F0(2,MATCHES(1,i));

x2=F1(1,MATCHES(2,i));
y2=F1(2,MATCHES(2,i));

d=SCORES(i);

Clean_Matches=[Clean_Matches;x1 y1 x2 y2];
distance=[distance; d];


    end
        
end    

[B,IX] = sort(distance');

 [m1 n1]=size(IX); 

for k=1:n1

X=[X;Clean_Matches(IX(k),1) Clean_Matches(IX(k),2)];

U=[U;Clean_Matches(IX(k),3) Clean_Matches(IX(k),4)];


end

% Ypologismos tou metasxhmatismou mesw ths sunartishs cp2tform
 
Tform=cp2tform(U,X,'affine');

%Tform=cp2tform(U,X,'nonreflective similarity');

%Tform=maketform('affine',U,X);

% metasxhmatismos ths I1

Temp=imtransform(I1,Tform);


end
