function classifiedImage = BoneClassifierFunc(X)
% BONECLASSIFIERFUNC(X) Returns a classified image in which bone structure
% is relatively segmented from other organs

% shift image value so that they all > 0
inter = X+abs(min(X(:)));

% Using threshold to classify
T = 1260;
out = inter>T;

% Apply closing and opening
se = strel('disk',2);   
out2 = imclose(out, se);    % closing first, reduce noise

se = strel('disk',3);
classifiedImage = imopen(out2, se);    % opening later with bigger structure se

end