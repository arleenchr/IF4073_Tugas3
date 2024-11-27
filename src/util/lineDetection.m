function lines = lineDetection(edges)
    [M, N] = size(edges, [1 2]);
    D = sqrt(M*M + N*N);
    P = zeros([floor(2 * D) 180]);

    for i = 1:M
        for j = 1:N
            if edges(i, j) > 0
                for k = 1:180
                    theta = (k - 91) * pi / 180;
                    r = (j - 1) * cos(theta) + (i - 1) * sin(theta);
                    r = floor(r + D);

                    P(r, k) = P(r, k) + 1;
                end
            end
        end
    end

    lines = P;
end