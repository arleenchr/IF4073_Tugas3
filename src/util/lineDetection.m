function lines = lineDetection(edges)
    [M, N] = size(edges, [1 2]);
    D = sqrt(M*M + N*N);
    lines = zeros([floor(2 * D) 180]);

    for i = 1:M
        for j = 1:N
            if edges(i, j) > 0
                for k = 1:180
                    % Calculate theta and rho of every possible
                    % line that passes through (M, N)
                    theta = (k - 91) * pi / 180;
                    r = (j - 1) * cos(theta) + (i - 1) * sin(theta);
                    r = floor(r + D);

                    lines(r, k) = lines(r, k) + 1;
                end
            end
        end
    end
end