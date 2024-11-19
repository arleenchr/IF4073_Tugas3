function segmentedImage = segmentation(image, operator, threshold)
    edges = edgeDetection(image, operator);

    edges = imbinarize(edges, 'adaptive');
    edges = imclose(edges,strel('disk',15));
    edges = imfill(edges,"holes");

    kernel = uint8(bwareaopen(imopen(edges, strel(ones(3,3))), threshold));

    red = image(:,:,1) .* kernel;
    green = image(:,:,2) .* kernel;
    blue = image(:,:,3) .* kernel;

    segmentedImage = cat(3, red, green, blue);
end