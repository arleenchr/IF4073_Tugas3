function segmentedImage = segmentation(image, edges)
    mask = imclearborder(edges);
    mask = imclose(mask, strel('line', 10,0)); % close (connect) adjacent edges
    mask = imfill(mask, 'holes'); % fill areas inside connected edges
    mask = imopen(mask, strel(ones(3, 3)));
    mask = bwareaopen(mask, 1500); % remove filled areas under threshold (background)

    if size(image, 3) == 3
        % RGB image
        segmentedImage(:,:,1) = image(:,:,1) .* mask;
        segmentedImage(:,:,2) = image(:,:,2) .* mask;
        segmentedImage(:,:,3) = image(:,:,3) .* mask;
    else
        % grayscale image
        segmentedImage(:,:) = image(:,:) .* mask;
    end
end