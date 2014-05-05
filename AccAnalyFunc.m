function Average_Accuracy = AccAnalyFunc(T,printEachAcc,plot)
% Plot accuracy of each test image and calculate the average accuracy
close all

% Initializing ...
acc = zeros(1,128); % 128 images

for i = 1:128
    % Loading images
    im = dicomread( strcat('../Train/PATIENT_DICOM/image_',num2str(i)) );
    label = dicomread( strcat('../Train/MASKS_DICOM/bone/image_',num2str(i)) );
    
    % Classifying ...
    classifiedImage = BoneClassifierFuncWithT(im,T);
    
    % Calculate the accuracy
    acc(i) = 100*corr2(classifiedImage, label);
    
    if printEachAcc
        fprintf('Image %d ----- Accuracy: %.2f\n',i,acc(i))
    end
end

% Plot accuracy through all images
if plot
    stem(acc)
end

% Show average accuracy
Average_Accuracy = mean(acc)

