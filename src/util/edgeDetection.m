function result = edgeDetection(image, operator)
    if size(image, 3) == 3
        image = rgb2gray(image);
    end
    
    switch lower(operator)
        case 'laplace'
            %kernelX = [0 1 0; 1 -4  1; 0  1  0];
            kernelX = [1 1 1; 1 -8  1; 1  1  1];
            %kernelX = [0 -1 0; -1 4 -1; 0 -1 0];
            %kernelX = [-1 -1 -1; -1 8 -1; -1 -1 -1];
            edges = conv2(double(image), double(kernelX), 'valid');
        case 'log'
            kernelX = [0 0 -1 0 0;
                       0 -1 -2 -1 0;
                       -1 -2 16 -2 -1;
                       0 -1 -2 -1 0;
                       0 0 -1 0 0];
            edges = conv2(double(image), double(kernelX), 'valid');
        case 'sobel'
            kernelX = [-1 0 1; -2 0 2; -1 0 1];
            kernelY = [1 2 1; 0 0 0; -1 -2 -1];
            convX = conv2(double(image), double(kernelX), 'valid');
            convY = conv2(double(image), double(kernelY), 'valid');
            edges = sqrt(convX.^2 + convY.^2);
        case 'prewitt'
            kernelX = [-1 0 1; -1 0 1; -1 0 1];
            kernelY = [-1 -1 -1; 0 0 0; 1 1 1];
            convX = conv2(double(image), double(kernelX), 'valid');
            convY = conv2(double(image), double(kernelY), 'valid');
            edges = sqrt(convX.^2 + convY.^2);
        case 'roberts'
            kernelX = [1 0; 0 -1];
            kernelY = [0 1; -1 0];
            convX = conv2(double(image), double(kernelX), 'valid');
            convY = conv2(double(image), double(kernelY), 'valid');
            edges = sqrt(convX.^2 + convY.^2);
        case 'canny'
            edges = (edge(image,'canny') * 255);
        otherwise
            error('Unknown operator: %s', operator);
    end

    if strcmpi(operator, 'canny')
        result = edges;
    else
        % Add some padding
        [imageHeight, imageWidth] = size(image);
        [kernelXHeight, kernelXWidth] = size(kernelX);
        paddingHeight = floor(kernelXHeight / 2);
        paddingWidth = floor(kernelXWidth / 2);
        
        result = zeros(imageHeight, imageWidth);

        if strcmpi(operator, 'roberts')
            result(paddingHeight:imageHeight - paddingHeight, paddingWidth:imageWidth - paddingWidth) = imbinarize(edges);
        else
            result(paddingHeight + 1:imageHeight - paddingHeight, paddingWidth + 1:imageWidth - paddingWidth) = imbinarize(edges);
        end
    end
end
