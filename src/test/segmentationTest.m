img = imread('images/house.jpg');
img = double(img) / 255;
figure; imshow (img);

edges = edgeDetection(img, 'roberts');
figure; imshow(edges);
segmentedImage = segmentation(img, edges, 'adaptive');
figure; imshow(segmentedImage);