img = imread('images/banana.jpg');
img = double(img) / 255;
figure; imshow (img);

edges = edgeDetection(img, 'canny');
figure; imshow(edges);
%segmentedImage = segmentation(img, 'laplace', 0.2);
%figure; imshow(segmentedImage);