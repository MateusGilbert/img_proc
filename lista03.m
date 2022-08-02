% Lista 3

%% 1
im_zelda = imread('zelda_s.tif');
im_building = imread('building.tif');
im_text = imread("text.tif");
im_xray = imread("xray.tif");
images = {im_zelda, im_building, im_text, im_xray};
im_names = {'zelda_s', 'building', 'text', 'xray'};

figure('Name', "Imagens");
for i = 1:4    
    subplot(2,2,i);
    imshow(images{i});
    title(strcat(im_names{i},".tif"));
end
truesize;

%% 2
r1 = @(m,n,p1,p2) p1^abs(m)*p2^abs(n);
for p = [.95 .7 .5 .1 -.5]
    for i = -128:127
        for j = -128:127
            R1(i+129,j+129) = r1(i,j,p,p);
        end
    end
    pivot = figure('Name', strcat('p = ', num2str(p)));
    subplot(1,2,1);
    imshow(R1, Colormap=gray);
    title('AC Function');
    ax = subplot(1,2,2);
    fft_aux = fft2(R1);
    imagesc(fftshift(log(abs(fft_aux)) + 1));
    colormap(ax,gray);
    title('FFT');
    truesize;
end
fprintf('Feche a última figura para seguir para a próxima questão\n');
uiwait(pivot);
close all;

%% 3
r2 = @(m,n,p) p^sqrt(m^2 + n^2);
for p = [.95 .7 .5 .1 -.5]
    for i = -128:127
        for j = -128:127
            R2(i+129,j+129) = r2(i,j,p);
        end
    end
    pivot = figure('Name', strcat('a = ', num2str(p)));
    subplot(1,2,1);
    imshow(R2, Colormap=gray);
    title('AC Function');
    ax = subplot(1,2,2);
    fft_aux = fft2(R2);
    imagesc(fftshift(log(abs(fft_aux)) + 1));
    colormap(ax,gray);
    title('FFT');
    truesize;
end
fprintf('Feche a última figura para seguir para a próxima questão\n');
uiwait(pivot);
close all;

%% 4

for i = 1:4
    pivot = figure('Name', strcat("Autocovariância de ", im_names{i}, ".tif"));
    subplot(1,2,1);
    aux_im = double(images{i})/256;
    R_lin = cov(aux_im);
    m = max(max(abs(R_lin)));
    imshow(R_lin/m, Colormap=gray);
    title('Linhas');
    R_col = cov(aux_im.');
    m = max(max(abs(R_col)));
    subplot(1,2,2);
    imshow(R_col/m, Colormap=gray);
    title('Colunas');
    truesize;
    clear aux_im;
end
fprintf('Feche a última figura para seguir para a próxima questão\n');
uiwait(pivot);
close all;