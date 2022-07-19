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
fprintf('Feche a imagem original para seguir para a questão II.1.\n');
uiwait(pivot);
close all;

%% II.1
I = @(x,y,b,M) .5*cos( (b*pi)/(2*M)*(x^2 + y^2) ) + .5;
m = 256;
[X,Y] = meshgrid(-m/2 + .5:m/2-.5);
for i = 1:m
    for j = 1:m
        M_grid(i,j) = I(X(i,j),Y(i,j),1,m);
    end
end
pivot = figure('Name', 'beta = 1');
imshow(M_grid,Colormap=gray);
clear M_grid;
truesize;

for b = [.5 2.]
    for i = 1:m
        for j = 1:m
            M_grid(i,j) = I(X(i,j),Y(i,j),b,m);
        end
    end
    figure('Name', strcat("beta = ", num2str(b)));
    imshow(M_grid,Colormap=gray);
    clear M_grid;
    truesize;
end
fprintf('Feche as figuras para seguir para seguir à questão II.2.1.\n');
uiwait(pivot);
close all;

%% II.2
for i = 1:m
    for j = 1:m
        z_plate(i,j) = I(X(i,j),Y(i,j),1,m);
    end
end

sub_zp = z_plate(1:2:end,1:2:end);
sub_zp2 = repelem(sub_zp, 2, 2);
pivot = figure('Name', 'original');
imshow(z_plate,Colormap=gray);
truesize;
figure('Name', 'subamostrado, fator 2');
imshow(sub_zp,Colormap=gray);
truesize;
figure('Name', 'subamostrado, fator 2 com repeticoes (II.2.1)');
imshow(sub_zp2,Colormap=gray);
truesize;
clear sub_zp sub_zp2;
input('Aperte qualquer botão para seguir para II.2.2.\n');

% II.2.2
F = [0,.4,.5,1]; A = [1,1,0,0];
H1d = remez(10,F,A);
H2d = H1d'*H1d;
fz_plate = filter2(H2d, z_plate);
sub_zp = repelem(fz_plate(1:2:end,1:2:end), 2, 2);
figure('Name', 'filtrado, subamostrado, fator 2 com repeticoes (II.2.2)');
imshow(sub_zp,Colormap=gray);
truesize;

fprintf('Feche a imagem original para seguir para a questão II.2.2.\n');
uiwait(pivot);
close all;

%% III.1
im_lena = imread('lena_256.tif');
im_lena2 = im_lena(1:2:end,1:2:end);

pivot = figure('Name', 'Original');
imshow(im_lena,Colormap=gray);
truesize;
figure('Name', 'Subamostrada, fator 2');
imshow(im_lena2,Colormap=gray);
truesize;

% III.2
im_lenab = im_lena;
im_lenab(2:2:end,:) = 0;
im_lenab(:,2:2:end) = 0;

figure('Name', 'Subamostrado, fator 2, adicionamento de 0s');
imshow(im_lenab,Colormap=gray);
truesize;

% analise espectral
fft_lena = fft2(im_lena);
fft_lenab = fft2(im_lenab);
figure('Name', 'Espectros');
ax1 = subplot(1,2,1);
title('Figura Original');
imagesc(fftshift(log(abs(fft_lena) + 1)));
colormap(ax1,gray);
ax2 = subplot(1,2,2);
title('Figura Subamostrada c/ adicionamento de 0s');
imagesc(fftshift(log(abs(fft_lenab) + 1)));
colormap(ax2,gray);
truesize;

fprintf('Feche o arquivo original para seguir ao próximo item.\n')
uiwait(pivot);
close all;

%% III.3
h0 = [.5 .5];
h1 = conv(h0,h0);
h2 = conv(h1,h1);

hh0 = 4*h0'*h0;
hh1 = 4*h1'*h1;
hh2 = 4*h2'*h2;

%% III.4 e III.5 (resposta em freq. dos filtros)

%% III.6
im_lenab_d = double(im_lenab)/255;
im_lenahh0 = filter2(hh0, im_lenab_d);
im_lenahh1 = filter2(hh1, im_lenab_d);
im_lenahh2 = filter2(hh2, im_lenab_d);
im_lenaH2d = filter2(H2d, im_lenab_d);

pivot = figure('Name', 'Original');
imshow(im_lena,Colormap=gray);
truesize;
ims = {im_lenahh0, im_lenahh1, im_lenahh2, im_lenaH2d};
titles = {'Filtrado por hh0', 'Filtrado por hh1', 'Filtrado por hh2', 'Filtrado por H2d (II.2.2)'};
for i = 1:numel(ims)
    figure('Name', titles{i});
    imshow(ims{i},Colormap=gray);
    truesize;
end