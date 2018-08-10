function [count matchcount]=testmatch(enrol_image,test_image)
[new_ridge_ending1 new_bifurcation1]=getfeatures(enrol_image);
c1=mean([new_ridge_ending1;new_bifurcation1]);
new_ridge_ending1=new_ridge_ending1-c1;
new_bifurcation1=new_bifurcation1-c1;
count=rows([new_ridge_ending1;new_bifurcation1]);
[new_ridge_ending2 new_bifurcation2]=getfeatures(test_image);
c2=mean([new_ridge_ending2;new_bifurcation2]);
new_ridge_ending2=new_ridge_ending2-c2;
new_bifurcation2=new_bifurcation2-c2;

dist=0;
matchcount=0;
for i=1:rows(new_ridge_ending1)
  dist=inf;
  ind=-1;
  for j=1:rows(new_ridge_ending2)
    temp=norm(new_ridge_ending1(i,1:2)-new_ridge_ending2(j,1:2),inf);
    ad=abs(new_ridge_ending1(i,3)-new_ridge_ending2(j,3));
    if(temp<dist && ((ad <21) || ( (180-ad) < 21) ) )  
    dist=temp;
    ind=j;
    end
  end  
  if(dist<25)
  matchcount++;
  new_ridge_ending2=[new_ridge_ending2(1:ind-1,:) ;new_ridge_ending2(ind+1:end,:)];
  end
end  
matchcount
for i=1:rows(new_bifurcation1)
  dist=inf;
  ind=-1;
  for j=1:rows(new_bifurcation2)
    temp=norm(new_bifurcation1(i,1:2)-new_bifurcation2(j,1:2),inf);
    ad=abs(new_bifurcation1(i,3)-new_bifurcation2(j,3));
    if(temp<dist && ((ad <21) || ( (180-ad) < 21) ) )  
    dist=temp;
    ind=j;
    end
  end  
  if(dist<25)
  matchcount++;
  new_bifurcation2=[new_bifurcation2(1:ind-1,:) ;new_bifurcation2(ind+1:end,:)];
  end
end  
