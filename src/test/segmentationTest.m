img = imread('images/banana.jpg');
if size(img, 3) == 3
    img = rgb2gray(img);
end
img = double(img) / 255;
figure; imshow (img);

edges = edgeDetection(img, 'log');
figure; imshow(edges);
%segmentedImage = segmentation(img, 'laplace', 0.2);
%figure; imshow(segmentedImage);