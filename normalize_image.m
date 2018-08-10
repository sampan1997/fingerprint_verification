function Normalized_img=normalize_image(img)
%COMMENTS ARE PROVIDED AT THE TOP OF EVERY LINE FOR HELP FOR READER
%desired mean is selected as 128.
M0=128;
%desired variance is selected as 128*128
V0=128*128;
%k,l is size of image
[k l]=size(img);

%image is cutted from side so that it can be converted into no of blocks in multiple of 16
%cutting along x axis
m=k-mod(k,16);
%cutting along y axis
n=l-mod(l,16);
%normalized image can contain floating no so double is used.
Normalized_img=double(img);
%for counting the no of blocks
count=0;
% sum of means of all blocks
sum1=0
sum2=0;
% to calculate sum of mean of individual blocks
for i=1:16:m
%for block x coordinate
for j=1:16:n
%for block y coordinate
%taking block of image
image=img(i:i+15,j:j+15);
%check if image is not empty
if(any(image(:)))
sum1=sum1+mean(image(:));
sum2= sum2+var(image(:),1);
% count++ to calculate no of blocks
count++;
%to end if statement
end
% two end to end for loops
 end
end
%M is mean of complete image 
M=sum1/count;
%V is variance of each image
V=sum2/count;
%loop to access image in blocks
for g=1:16:m
for h=1:16:n
%selected block of image
image=img(g:g+15,h:h+15);
if(any(image(:)))    
% working inside a block 
for i=1:16
for j=1:16
% exact cordinates of pixel inside a block
x=(g-1)+i;
y=(h-1)+j;   
%comparing pixel intensity with average mean of image   
if(image(i,j)>M)
Normalized_img(x,y)= M0+sqrt(((double(image(i,j))-M)^2)*(V0/V));
else
%M is double so need to use double with image for subtraction
Normalized_img(x,y)= M0-sqrt(((double(image(i,j))-M)^2)*(V0/V));      
end
%ending for statements      
end
end
end   
end
end
%ending function to normalize image
end