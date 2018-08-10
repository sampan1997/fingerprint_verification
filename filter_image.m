function [bin_img enhanced_img]=filter_image(segmented_image,segment_size,segment_size1,orientation_img)
[M N]=size(segmented_image);
enhanced_img=zeros(M,N);
bin_img=zeros(M,N);

[x y]=meshgrid([-5:5],[5:-1:-5]);

for g=1:segment_size:M
  for h=1:segment_size1:N
    local_image=segmented_image(g:g+segment_size-1,h:h+segment_size1-1);
    if(any(255-local_image(:)))     
      a=(g-1)/segment_size + 1;
      b=(h-1)/segment_size1 + 1;
      % f=frequency_img(a,b);
      f=.125;
      O=orientation_img(a,b);
      gabor_filter= exp(-( x.^2 + y.^2 )/(32)) .* cos(2*pi*f*(x.*cos(O-pi/2) +y.*sin(O-pi/2)));
      temp=conv2(segmented_image,gabor_filter,'same');
      t=temp(g:g+segment_size-1,h:h+segment_size1-1);
      enhanced_img(g:g+segment_size-1,h:h+segment_size1-1)=t;
      
      %bin_img(g:g+segment_size-1,h:h+segment_size1-1)=t>=(mean(t(:))+50);
    end
  end
end   
bin_img=enhanced_img>=mean(enhanced_img(:));
end