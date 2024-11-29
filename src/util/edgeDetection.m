function result = edgeDetection(image, operator)
    if size(image, 3) == 3
        image = rgb2gray(image);
    end
    
    switch lower(operator)
        case 'laplace'
            %kernel = [0 1 0; 1 -4  1; 0  1  0];
            kernel = [1 1 1; 1 -8  1; 1  1  1];
            %kernel = [0 -1 0; -1 4 -1; 0 -1 0];
            %kernel = [-1 -1 -1; -1 8 -1; -1 -1 -1];
            result = conv2(double(image), double(kernel), 'same');
        case 'log'
            kernel = [0 0 -1 0 0;
                      0 -1 -2 -1 0;
                      -1 -2 16 -2 -1;
                      0 -1 -2 -1 0;
                      0 0 -1 0 0];
            result = conv2(double(image), double(kernel), 'same');
        case 'sobel'
            kernelX = [-1 0 1; -2 0 2; -1 0 1];
            kernelY = [1 2 1; 0 0 0; -1 -2 -1];
            convX = conv2(double(image), double(kernelX), 'same');
            convY = conv2(double(image), double(kernelY), 'same');
            result = sqrt(convX.^2 + convY.^2);
        case 'prewitt'
            kernelX = [-1 0 1; -1 0 1; -1 0 1];
            kernelY = [-1 -1 -1; 0 0 0; 1 1 1];
            convX = conv2(double(image), double(kernelX), 'valid');
            convY = conv2(double(image), double(kernelY), 'valid');
            edges = sqrt(convX.^2 + convY.^2);

            [imageHeight, imageWidth] = size(image);
            [kernelXHeight, kernelXWidth] = size(kernelX);
            paddingHeight = floor(kernelXHeight / 2);
            paddingWidth = floor(kernelXWidth / 2);
            result = zeros(imageHeight, imageWidth);
            result(paddingHeight + 1:imageHeight - paddingHeight, paddingWidth + 1:imageWidth - paddingWidth) = imbinarize(edges);
        case 'roberts'
            kernelX = [1 0; 0 -1];
            kernelY = [0 1; -1 0];
            convX = conv2(double(image), double(kernelX), 'same');
            convY = conv2(double(image), double(kernelY), 'same');
            result = sqrt(convX.^2 + convY.^2);
        case 'canny'
            result = (edge(image,'canny') * 255);
        otherwise
            error('Unknown operator: %s', operator);
    end
end
