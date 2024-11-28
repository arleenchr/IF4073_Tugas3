function drawnLines = lineDraw(lines, M, N, threshold)
    D = sqrt(M*M + N*N);

    drawnLines = zeros([M N]);
    [R, K] = size(lines, [1 2]);

    for r = 1:R
        for k = 1:K
            if lines(r, k) >= threshold
                theta = (k - 1 - K/2) * pi / 180;
                radius = r - D;

                s = sin(theta);
                c = cos(theta);
                if s ~= 0
                    for j = 1:N
                        y = (radius - (j - 1) * c) / s;
                        i = floor(y) + 1;
                        if 1 <= i && i <= M
                            drawnLines(i, j) = 1;
                        end
                    end
                end

                if c ~= 0
                    for i = 1:M
                        x = (radius - (i - 1) * s) / c;    
                        j = floor(x) + 1;
                        if 1 <= j && j <= N
                            drawnLines(i, j) = 1;
                        end
                    end
                end
            end
        end
    end
end

