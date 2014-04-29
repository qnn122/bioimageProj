% Initializing
close all
factor = 0;
range = 12;
row = 3;
col = 4;

% Visualizing test data
cd ../Test
figure;
set(gcf, 'name', 'TEST DATA')
for i = (1+factor):(range+factor)
    filename = strcat('image_', num2str(i));
    im = dicomread(filename);
    subplot(row, col, i);
    imshow(im,[]);
end

% Visualizing train data (unlabeled)
cd ../Train/PATIENT_DICOM
figure;
set(gcf, 'name', 'TEST DATA')
for i = (1+factor):(range+factor)
    filename = strcat('image_', num2str(i));
    im1 = dicomread(filename);
    subplot(row, col, i);
    imshow(im1,[]);
end

% Visualizing train data (labeled)
cd ../MASKS_DICOM/bone
figure;
set(gcf, 'name', 'TEST DATA')
for i = (1+factor):(range+factor)
    filename = strcat('image_', num2str(i));
    im2 = dicomread(filename);
    subplot(row, col, i);
    imshow(im2,[]);
end