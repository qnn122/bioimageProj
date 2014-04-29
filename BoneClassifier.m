% Load image
close all;
No = 30;   % Choos image here
im = dicomread( strcat('../Train/PATIENT_DICOM/image_',num2str(No)) );
label = dicomread( strcat('../Train/MASKS_DICOM/bone/image_',num2str(No)) );

% Visualizing data
figure;
subplot(1,2,1); imshow(label,[])
subplot(1,2,2); imshow(im,[])

% shift image value so that they all > 0
inter = im+abs(min(im1(:)));

% Using threshold to classify
T = 1200;
out = inter>T;
figure;
subplot(1,2,1); imshow(label,[])
subplot(1,2,2); imshow(out,[])

% Apply closing and opening
se = strel('disk',2);   
out2 = imclose(out, se);    % closing first, reduce noise

se = strel('disk',3);
out2 = imopen(out2, se);    % opening later with bigger structure se

figure;
subplot(1,3,1); imshow(label); title('LABEL');
subplot(1,3,2); imshow(out); title('After THRESHOLDING');
subplot(1,3,3); imshow(out2); title('After CLOSING and OPENING');

% calculate correlation
correlation = corr2(label,out2)
