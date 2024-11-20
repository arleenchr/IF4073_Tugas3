function edges = edgeDetection(image, operator)
    switch lower(operator)
        case 'laplace'
            %kernel = [0 1 0; 1 -4  1; 0  1  0];
            kernel = [1 1 1; 1 -8  1; 1  1  1];
            %kernel = [0 -1 0; -1 4 -1; 0 -1 0];
            %kernel = [-1 -1 -1; -1 8 -1; -1 -1 -1];
            edges = uint8(conv2(double(rgb2gray(image)), double(kernel), 'same'));
        case 'log'
            edges = [];
        case 'sobel'
            kernelX = [-1 0 1; -2 0 2; -1 0 1];
            kernelY = [1 2 1; 0 0 0; -1 -2 -1];
            convX = conv2(double(image), double(kernelX), 'same');
            convY = conv2(double(image), double(kernelY), 'same');
            edges = sqrt(convX.^2 + convY.^2);
        case 'prewitt'
            edges = [];
        case 'roberts'
            edges = [];
        case 'canny'
            edges = [];
        otherwise
            error('Unknown operator: %s', operator);
    end
end
