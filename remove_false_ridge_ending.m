function [new_ridge_ending false_ridge_ending]=remove_false_ridge_ending(r,ridge_ending,segment_size,segment_size1)

M_img=zeros(segment_size,segment_size1);
window=zeros(3);
if(bitget(segment_size,1))
  center_vertical=(segment_size+1)/2;
  upper_pixels=center_vertical-1;
  lower_pixels=center_vertical-1;
else
  center_vertical=segment_size/2;
  upper_pixels=center_vertical-1;
  lower_pixels=center_vertical;
end  
if(bitget(segment_size1,1))
  center_horizontal=(segment_size1+1)/2;
  left_pixels=center_horizontal-1;
  right_pixels=center_horizontal-1;
else
  center_horizontal=segment_size1/2;
  left_pixels=center_horizontal-1;
  right_pixels=center_horizontal;
end  
u=0;
new_ridge_ending=[];
false_ridge_ending=[];
false_row=[];
false_clmn=[];
[A,B]=size(r);


hold on;    
    
for i=1:rows(ridge_ending)
  
 if(ridge_ending(i,1)>35 && ridge_ending(i,1)< (A-35)&& ridge_ending(i,2)>35 && ridge_ending(i,2)<(B-35)) 
  M_img=r(ridge_ending(i,1)-upper_pixels:ridge_ending(i,1)+lower_pixels,ridge_ending(i,2)-left_pixels:ridge_ending(i,2)+right_pixels);  
  smple=zeros(segment_size,segment_size1);
  smple(center_vertical,center_horizontal)=-1;
  a=center_vertical;
  b=center_horizontal;
  lookupT=[a b 5];
  new_a=[-1 0 1 -1 0 1 -1 0 1];
  new_b=[ -1 -1 -1 0 0 0 1 1 1];
 
 ################################################### 
  while(sum(sum(lookupT)))
    
    temp=lookupT(1,3);
    a=lookupT(1,1);
    b=lookupT(1,2);
    a=a+new_a(temp);
    b=b+new_b(temp);
    [p,q]=size(lookupT);
    lookupT=lookupT(2:p,:);
           
    if( (2<=a)&&(a<=segment_size-1) && (2<=b)&&(b<=segment_size1-1) )
      window=M_img(a-1:a+1,b-1:b+1);
      win2=smple(a-1:a+1,b-1:b+1);
    
      for j=1:9
       if(window(j)==1)
        if(win2(j)==0)
          win2(j)=1;
          lookupT=[a b j ; lookupT];
          
        end
       end
      end
      
      smple(a-1:a+1,b-1:b+1)=win2;
    
    end
   
    end 

  ###################################
   holder=[smple(1,1:segment_size1-1) smple(1:segment_size-1,segment_size1)' smple(segment_size,segment_size1:-1:2) smple(segment_size:-1:1,1)' ];

     T_01=sum(diff(holder)>0);
   if(T_01==1)
    new_ridge_ending=[new_ridge_ending; ridge_ending(i,:)];
   else 
    false_ridge_ending=[false_ridge_ending;ridge_ending(i,:)]; 
   end
end

end  
end   