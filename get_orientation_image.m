function orientation_img=get_orientation_image(Normalized_image,segment_size,segment_size1)

[M,N]=size(Normalized_image);
Normalized_image=uint8(Normalized_image);
[Gx Gy]=imgradientxy(Normalized_image);
Gy=-Gy;
q=M/segment_size;
r=N/segment_size1;
orientation_img=zeros(q,r);

orientation_img_x=zeros(q,r);
orientation_img_y=zeros(q,r);


for g=1:segment_size:M
  for h=1:segment_size1:N
    T=Normalized_image(g:g+segment_size-1,h:h+segment_size1-1);
    if(any(T(:)))
    local_image_Gx=Gx(g:g+segment_size-1,h:h+segment_size1-1);
    local_image_Gy=Gy(g:g+segment_size-1,h:h+segment_size1-1);
    vx=2*sum(sum(local_image_Gx.*local_image_Gy));
    vy=sum(sum(local_image_Gx.^2 - local_image_Gy.^2));
    orientation_img((g-1)/segment_size +1,(h-1)/segment_size1 +1)=.5*atan2(vx,vy) +pi/2;
    else
       orientation_img((g-1)/segment_size +1,(h-1)/segment_size1 +1)=pi/2;
    end
  end  
end

flter=fspecial("gaussian",5);

orientation_img_x=cos(2*orientation_img);
orientation_img_y=sin(2*orientation_img);

img_x=imfilter(orientation_img_x,flter);

img_y=imfilter(orientation_img_y,flter);

orientation_img=.5*atan2(img_y,img_x);

end
