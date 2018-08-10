function [new_ridge_ending new_bifurcation]=getfeatures(input_image)
segment_size_vertical=16;
segment_size_horizontal=16;
variance_threshold=75;
desired_mean=180;
desired_variance=4000;
segmented_image=segment_image(input_image,segment_size_vertical,segment_size_horizontal,variance_threshold);
Normalized_image=normalize_image(segmented_image,segment_size_vertical,segment_size_horizontal,desired_mean,desired_variance);
orientation_image=get_orientation_image(Normalized_image,segment_size_vertical,segment_size_horizontal);
binary_image=filter_image(Normalized_image,segment_size_vertical,segment_size_horizontal,orientation_image);
%%thin_image=thin(binary_image);
thin_image=bwmorph(~binary_image,'thin',Inf);
figure
imshow(thin_image);
[ridge_ending bifurcation]=extract_minutiae(thin_image,orientation_image,segment_size_vertical,segment_size_horizontal);
[new_ridge_ending false_ridge_ending]=remove_false_ridge_ending(thin_image,ridge_ending,segment_size_vertical,segment_size_horizontal);
[new_bifurcation false_bifurcation]=remove_false_bifurcation(thin_image,bifurcation,segment_size_vertical,segment_size_horizontal);
hold on
plot(new_ridge_ending(:,2),new_ridge_ending(:,1),'Marker','o','Color','r','MarkerSize',20,'linewidth',2,'linestyle','none');
hold on
plot(new_bifurcation(:,2),new_bifurcation(:,1),'Marker','o','Color','r','MarkerSize',20,'linewidth',2,'linestyle','none'); 