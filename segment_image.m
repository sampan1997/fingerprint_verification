function segmented_image=segment_image(img,segment_size,segment_size1,variance_threshold)

[m,n]=size(img);
M=m-mod(m,segment_size);
N=n-mod(n,segment_size1);
segmented_image=img(1:M,1:N);
total=0;
Seg=ones(M,N);


for k=1:segment_size:M
  for h=1:segment_size1:N
    local_image=segmented_image(k:k+segment_size-1,h:h+segment_size1-1);
    variance=var(local_image(:),1);
    if(variance<variance_threshold)
      %Seg(k,h)=1;
      Seg(k:k+segment_size-1,h:h+segment_size1-1)=255;
      segmented_image(k:k+segment_size-1,h:h+segment_size1-1)=255;
    end
  end  
 end

end