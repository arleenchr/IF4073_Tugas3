function drawnLines = lineDraw(lines, M, N, threshold)
    D = sqrt(M*M + N*N);

    drawnLines = zeros([M N]);
    [R, K] = size(lines, [1 2]);

    for r = 1:R
        for k = 1:K
            if lines(r, k) >= threshold
                % Compute corresponding rho and theta
                theta = (k - 1 - K/2) * pi / 180;
                rho = r - D;

                s = sin(theta);
                c = cos(theta);

                if s ~= 0
                    % Draw line using DDA algorithm
                    y1 = rho / s;
                    y2 = (rho - (N - 1) * c) / s;
                    dy = y2 - y1;
                    
                    step = max(abs(dy), N);
                    incX = N / step;
                    incY = dy / step;

                    x = 1;
                    y = y1;

                    for i = 1:step
                        if 1 <= x && x <= N && 1 <= y && y <= M
                            drawnLines(round(y), round(x)) = 1;
                        end

                        x = x + incX;
                        y = y + incY;
                    end
                else
                    % Draw a vertical line
                    x = rho / c;

                    if 1 <= x && x <= N
                        for y = 1:M
                            drawnLines(y, round(x)) = 1;
                        end
                    end
                end
            end
        end
    end
end
