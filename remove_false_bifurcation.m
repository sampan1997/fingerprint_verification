function [new_bifurcation false_bifurcation]=remove_false_bifurcation(r,bifurcation,segment_size,segment_size1)

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

new_bifurcation=[];
false_bifurcation=[];
[A,B]=size(r);
%%imshow(r);
%%hold on;    
    
for i=1:rows(bifurcation)
  
 if(bifurcation(i,1)>35 && bifurcation(i,1)<(A-30) && bifurcation(i,2)>35 && bifurcation(i,2)<(B-30)) 
  M_img=r(bifurcation(i,1)-upper_pixels:bifurcation(i,1)+lower_pixels,bifurcation(i,2)-left_pixels:bifurcation(i,2)+right_pixels); 
  smple=zeros(segment_size,segment_size1);
  smple(center_vertical,center_horizontal)=-1;
  a=center_vertical;
  b=center_horizontal;
  window=M_img(a-1:a+1,b-1:b+1);
  win2=smple(a-1:a+1,b-1:b+1);
  hook=[];
  shot=1;
  
  for j=1:9
       if(window(j)==1)
        if(win2(j)==0)
          win2(j)=shot;
          hook=[ hook; a b j];
          %lookupT=[a b j ; lookupT];
          shot++; 
         end 
       end
  end
  smple(a-1:a+1,b-1:b+1)=win2;
 
      
  
  for l=1:3
   a=center_vertical;
   b=center_horizontal;
   lookupBF=[hook(l,:)];
   new_a=[-1 0 1 -1 0 1 -1 0 1];
   new_b=[ -1 -1 -1 0 0 0 1 1 1];
 
 ################################################### 
  while(sum(sum(lookupBF)))
    
    temp=lookupBF(1,3);
    a=lookupBF(1,1);
    b=lookupBF(1,2);
    a=a+new_a(temp);
    b=b+new_b(temp);
    [p,q]=size(lookupBF);
    lookupBF=lookupBF(2:p,:);
     
    if( (2<=a)&&(a<=segment_size-1) && (2<=b)&&(b<=segment_size1-1) )
      
      window=M_img(a-1:a+1,b-1:b+1);
      win2=smple(a-1:a+1,b-1:b+1);
    
      for j=1:9
       if(window(j)==1)
        if(win2(j)==0)
          win2(j)=l;
          lookupBF=[a b j ; lookupBF];
          end 
       end
      end
      
      smple(a-1:a+1,b-1:b+1)=win2;
    
    end
 end 
 end 
  ###################################
  %% if(i==26)
  %% smple
  %% M_img
   %%end
   %T_01=sum(smple(1,:)+smple(12,:))+sum(smple(2:11,1)+smple(2:11,7));
   holder=[smple(1,:) smple(segment_size,:) smple(2:segment_size-1,1)' smple(2:segment_size-1,segment_size1)'];
   T_01=sum(holder==1);
   T_02=sum(holder==2);
   T_03=sum(holder==3);
  
   if( T_01 && T_02 && T_03)
     new_bifurcation=[new_bifurcation; bifurcation(i,:)];
  
   else 
     false_bifurcation=[false_bifurcation; bifurcation(i,:)];
   end
end
end 

end