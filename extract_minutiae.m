function [ re b]=extract_minutiae(f_img,segment_size_vertical,segment_size_horizontal)
%%%%COMMENTS ARE PROVIDED AT THE TOP OF EVERY LINE FOR HELP OF READER
I=bwmorph(~f_img,'thin',Inf);
%thinning of image is done until it is one pixel wide
%thin_image=I;
%%size of image is calculated
[M N]=size(f_img);
re=[];
b=[];
%ridge ending along x axis
rex=[];
%ridge ending along y axis
rey=[];
%bifurcation along x axis
bx=[];
%bifurcation along x axis
by=[];
figure;
imshow(I);
hold on;
for i=2:M-1
for j=2:N-1
%taking 3*3 window around each pixels 
tmp=I(i-1:i+1,j-1:j+1);
if(I(i,j)==1)
tmp=I(i-1:i+1,j-1:j+1);
%C is calculated by checking 1 to  o transaction
c=abs(tmp(1,1)-tmp(1,2)) + abs(tmp(1,2)-tmp(1,3)) + abs(tmp(1,3)-tmp(2,3))+ abs(tmp(2,3)-tmp(3,3)) + abs(tmp(3,3)-tmp(3,2)) + abs(tmp(3,2)-tmp(3,1))+abs(tmp(3,1)-tmp(2,1)) + abs(tmp(2,1)-tmp(1,1));
c=c/2;
if(c==1)
plot(j,i,'Marker','o','Color','m','MarkerSize',10,'linewidth',1)
re=[re; i j (180/pi)*orientation_image(ceil(i/segment_size_vertical),ceil(j/segment_size_horizontal))];


end
if(c==3)
plot(j,i,'Marker','x','Color','c','MarkerSize',10,'linewidth',1)
b=[b; i j (180/pi)*orientation_image(ceil(i/segment_size_vertical),ceil(j/segment_size_horizontal))];
end
end
end
end  
end
%end of the function