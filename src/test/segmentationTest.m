img = imread('images/house.jpg');
img = double(img) / 255;
figure; imshow (img);

edges = edgeDetection(img, 'prewitt');
figure; imshow(edges);
segmentedImage = segmentation(img, edges, 'adaptive');
figure; imshow(segmentedImage);