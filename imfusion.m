clear;
fusiontype = 'MeanMax';
wavetype = 'coif5';

% Load 1st image
[filename1, pathname1] = uigetfile('C:\Users\RAJESH\Pictures\fusion.jpg', 'Select 1st image');
filewithpath1 = strcat(pathname1, filename1);
img1 = imread(filewithpath1);

% Load 2nd image
[filename2, pathname2] = uigetfile('C:\Users\RAJESH\Pictures\fusion.jpeg', 'Select 2nd image');
filewithpath2 = strcat(pathname2, filename2);
img2 = imread(filewithpath2);

% Resize img2 to match the size of img1 if they are not the same
[row, col, ~] = size(img1);
if ~isequal(size(img1), size(img2))
    img2 = imresize(img2, [row, col]);
end

% Perform fusion on each color channel
fusedimageR = imgfusion(img1(:, :, 1), img2(:, :, 1), fusiontype, wavetype);
fusedimageG = imgfusion(img1(:, :, 2), img2(:, :, 2), fusiontype, wavetype);
fusedimageB = imgfusion(img1(:, :, 3), img2(:, :, 3), fusiontype, wavetype);
fusedimage = uint8(cat(3, fusedimageR, fusedimageG, fusedimageB));

% Save fused image
imwrite(imresize(fusedimage, [row, col]), 'fusedimage.jpg', 'Quality', 100);

% Display images
subplot(1, 3, 1); imshow(img1); title('Image 1');
subplot(1, 3, 2); imshow(img2); title('Thermal Image 2');
subplot(1, 3, 3); imshow(fusedimage); title('Fused Image');