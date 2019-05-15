%% This script converts TrainID based segmentation results
%% into TestIDs for submitting the results to the cityscape
%% evaluation server

% test labels and corresponding IDs {'road':7 ; 'sidewalk':8 , 'building':11, 'wall':12,'fence':13 ,
%    'pole': 17; 'traffic light': 19, 'traffic sign': 20, 'vegetation': 21,'terrain': 22, 'sky': 23, 
%    'person': 24, 'rider': 25, 'car': 26, 'truck': 27, 'bus': 28, 'train':31, 'motorcycle':32, 'bicycle':33} 

testID = [7 ,8 , 11, 12,13 ,17,19, 20, 21,22,23,24, 25, 26,27, 28,31, 32,33]
totalIDs = length(testID)
trainID = [1:19]

base_dir = '<PATH_TO_SEGMENTATION>';
all_names = dir(base_dir);


for i=3:length(all_names)
    fileName = all_names(i).name;
    img = imread(strcat(base_dir, fileName)); % read image % imshow(img)
    img_fix_testID = img;
    txt = '';
    
    %% replace trainID by testID
    for trID=trainID
        % Finding the index of labels
        pos = find(img == trID);
        img_fix_testID(pos) = testID(trID);   
        txt = strcat(txt, sprintf('Replacing %d -> %d; ', trID, testID(trID)));
        disp(txt)
    end
    
    % Write image to graphics file. 
    fileName_new = strrep(fileName,'val',''); 
    fileName_new = strrep(fileName_new,'gtFine','predict');
    imwrite(uint8(img_fix_testID),strcat(base_dir, fileName_new))   
    delete (strcat(base_dir, fileName))
end 
