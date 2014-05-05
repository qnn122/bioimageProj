use_bwlabel = 0;

% Load image
close all;
No = 8;   % Choos image here
im = dicomread( strcat('../Train/PATIENT_DICOM/image_',num2str(No)) );
label = dicomread( strcat('../Train/MASKS_DICOM/bone/image_',num2str(No)) );

% shift image pixels' values so that they all > 0
inter = im+abs(min(im(:)));

% Thresholding
T1 = 1260;
out = inter>T1 ;

% Apply closing and opening
se = strel('disk',2);   
out2 = imclose(out, se);    % closing first, reduce noise

se = strel('disk',3);
out2 = imopen(out2, se);    % opening later with bigger structure se

if use_bwlabel
    % Labeling big region
    [L, num] = bwlabel(out2);
    x = zeros(1,num);
    y = zeros(1,num);
    for i = 1:num
        ix = find(L==i);
        cntr = mean(ix);
        y(i) = floor(cntr/size(im,2));
        x(i) = cntr - size(im,1)*y(i);
        if (size(ix,1)>3000)
             L(L==i) = 0;
        end
    end
    L1 = label2rgb(L);
end 
figure;
subplot(2,2,1); imshow(im,[]); title('DATA');
subplot(2,2,2); imshow(label); title('LABEL');
subplot(2,2,3); imshow(out); title('After THRESHOLDING');
subplot(2,2,4); imshow(out2); title('After CLOSING and OPENING');

if use_bwlabel
    subplot(2,2,4); imshow(L1); title('After CLOSING and OPENING');
    hold on; plot(x,y,'rx')
    hold off;
    % calculate correlation
    correlation = 100*corr2(label,L)
else
    % calculate correlation
    correlation = 100*corr2(label,out2)
end

% NOTE: USING BWLABEL DO NOT IMPROVE THE ACCURACY, IN FACT, IT LOWERS
% ACCURACY

