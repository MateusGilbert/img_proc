% Lista 2

%% I.1, I.2 e I.3
fprintf('Resultados das questões I.1, I.2 e I.3\n');
im_zelda = imread('zelda.tif');
figure('Name', 'Original');
imshow(im_zelda,Colormap=gray);
truesize;

for i = [2 4 8 16 32]
    figure("Name", strcat("Subamostrada por fator ", int2str(i)));
    im = im_zelda(1:i:end,1:i:end);
    imshow(im, Colormap=gray);
    truesize;
end

pivot = figure('Name', 'Analise em Frequência');
ax = subplot(2,3,1);
fft_og = fft2(im_zelda);
imagesc(fftshift(log(abs(fft_og)) + 1));
colormap(ax,gray);
title('FFT img. original');
for i = 1:5
    ax = subplot(2,3,1+i);
    im = im_zelda(1:2^i:end,1:2^i:end);
    fft_aux = fft2(im);
    imagesc(fftshift(log(abs(fft_aux)) + 1));
    colormap(ax,gray);
    title(strcat('FFT sub. ', int2str(2^i)));
end

fprintf('--------------------------------\n');
fprintf('Comentarios:\nObservando a DFT da figura original e das suas imagens derivadas, pode-se notar que a informação\nem baixas frequências se mantêm quase intalterada após a subamostragem. Observando as imagens\ngeradas, nota-se que a cada subamostragem a DFT gerada se parece como um "zoom" da região central\nda DFT anterior. Esse resultado já era mais ou menos esperado, já que as informações em baixa\nfrequência são menos prejudicadas quando a imagem é subamostrada, já que detalhes podem ser perdidos\nquando pixeis são perdidos na subamostragem.\n')
fprintf('--------------------------------\n');

fprintf('Feche a figura da análise espectral para seguir para a próxima questão\n');
uiwait(pivot);
close all;

%% I.4
fprintf('Resultados da questão I.4\n');
im_zelda = imread('zelda.tif');
pivot = figure('Name', 'Original');
imshow(im_zelda,Colormap=gray);
truesize;

for i = [2 4 8 16 32]
    figure("Name", strcat("Subamostrada por fator ", int2str(i)));
    im = im_zelda(1:i:end,1:i:end);
    im = repelem(im, i, i);
    imshow(im, Colormap=gray);
    truesize;
end
fprintf('Feche a imagem original para seguir para a próxima questão.\n');
uiwait(pivot);
close all;