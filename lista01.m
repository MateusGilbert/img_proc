% 1a Lista

%% I.1 - Jain ex. 2.5 pg. 45
fprintf('I.1 results');
x = [2 5 4; 1 4 1]; % x ->, y downward
h_1 = [0 -1 0; -1 4 -1; 0 -1 1];
h_2 = [1 2 3];
h_3 = [-1; 3; -2];
h = {h_1, h_2, h_3};

pivot = figure(1);
spy(x)
title('x (Jain)');
N_h = numel(h);
for i = 1:N_h
    figure(i + 1);
    spy(h{i})
    title(strcat('h_', num2str(i, '%d'), '(Jain)'));
    r = conv2(x,h{i})
    figure(i + 1 + N_h);
    spy(r)
    title(strcat('x * h_', num2str(i)))
end
fprintf('Close figures to display results from the next item (I.2)\n');
uiwait(pivot);
close all;

%% I.2
fprintf('I.2 results\n')
% X
aux = ones(1,4);
pivot = figure(1)
X = [zeros(1,7); aux zeros(1,3); 0 aux 0 0; 0 0 aux 0; zeros(1,7)];
spy(X)
title('X (I.2)');

% H
h_aux1 = [0 1 zeros(1,3)];
h_aux2 = [0 1 1 0 0];
H = [h_aux1; h_aux1; h_aux2; h_aux2; h_aux2; 0 ones(1,3) 0; zeros(1,5)];

figure(2);
spy(H)
title('H (I.2)');
res = convImg(X,H)

figure(3);
spy(res)
title('X * H');
fprintf('Close figures to display results from the next item (II.1)\n');
uiwait(pivot);
close all;

%% II.1
fprintf('II.1 and II.2 results\n');

g = @(m,n,theta,d) 0.5 + 0.5*cos( (2*pi/d)*(m*cosd(theta) + n*sind(theta)) );

Theta = [zeros(1,4) 90*ones(1,6) 45 45 30 70];
D = [256 150 64*sqrt(2) 64 25 16*sqrt(2) 10 4 2 1 32 32*sqrt(2) 16 4];
for idx = 1:numel(D)
    for i = 0:255
        for j = 0:255
            M(i+1,j+1) = g(i,j,Theta(idx),D(idx));
        end
    end
    figure(idx)
    subplot(1,3,1);
    imshow(M);
    subplot(1,3,2);
    mesh(M);
    subplot(1,3,3);
    fft_im = fft2(M);
    imagesc(fftshift(log(abs(fft_im)) + 1));
    Fig = gcf;
    title(Fig.Children(end),strcat('$\theta = $', num2str(Theta(idx)), ', d = ', num2str(D(idx))) , 'Interpreter','latex');
end

%

%functions
% I.2
function n = trans(x,dim)
    n = 0;
    for i = 1:size(x,dim)
        if (dim == 2)
            if (all(x(:,i) == 0))
                n = n + 1;
            else
                break;
            end
        else
            if (all(x(i,:) == 0))
                n = n + 1;
            else
                break;
            end
        end
    end
end

function res = convImg(X,H)
    X_x = trans(X,1);
    H_x = trans(H,1);
    X_y = trans(X,2);
    H_y = trans(H,2);
    res = conv2(X(X_x+1:end,X_y+1:end), H(H_x+1:end,H_y+1:end));
    res = [zeros(size(res,1), X_x + H_x) res];
    res = [zeros(X_y + H_y, size(res,2)); res];
end