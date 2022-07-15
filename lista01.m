% 1a Lista

%% I.1 - Jain ex. 2.5 pg. 45
fprintf('Resultados da questão I.1\n');
x = [2 5 4; 1 4 1]; % x ->, y downward
h_1 = [0 -1 0; -1 4 -1; 0 -1 1];
h_2 = [1 2 3];
h_3 = [-1; 3; -2];
h = {h_1, h_2, h_3};

pivot = figure(1);
spy(x);
title('x (Jain)');
N_h = numel(h);
for i = 1:N_h
    figure(i + 1);
    spy(h{i});
    title(strcat('h_', num2str(i, '%d'), '(Jain)'));
    r = conv2(x,h{i});
    figure(i + 1 + N_h);
    spy(r);
    title(strcat('x * h_', num2str(i)))
end
fprintf('Feche a Figura 1 para ir ao próximo item (I.2)\n');
uiwait(pivot);
close all;

%% I.2
fprintf('Resultados da questão II.2\n')
% X
aux = ones(1,4);
pivot = figure(1);
X = [zeros(1,7); aux zeros(1,3); 0 aux 0 0; 0 0 aux 0; zeros(1,7)];
spy(X);
title('X (I.2)');

% H
h_aux1 = [0 1 zeros(1,3)];
h_aux2 = [0 1 1 0 0];
H = [h_aux1; h_aux1; h_aux2; h_aux2; h_aux2; 0 ones(1,3) 0; zeros(1,5)];

figure(2);
spy(H);
title('H (I.2)');
res = conv2(X,H);

figure(3);
spy(res);
title('X * H');
fprintf('Feche as figuras para seguir ao próximo item (II.1)\n');
uiwait(pivot);
close all;

%% II.1 e II.2
fprintf('Resultados das questões II.1 e II.2\n');

g = @(m,n,theta,d) 0.5 + 0.5*cos( (2*pi/d)*(m*cosd(theta) + n*sind(theta)) );

Theta = [zeros(1,4) 90*ones(1,6) 45 45 30 70];
D = [256 150 64*sqrt(2) 64 25 16*sqrt(2) 10 4 2 1 32 32*sqrt(2) 16 4];
for idx = 1:numel(D)
    for i = 0:255
        for j = 0:255
            M(i+1,j+1) = g(i,j,Theta(idx),D(idx));
        end
    end
    if idx == 1
        pivot = figure(idx);
    else
        figure(idx);
    end

    subplot(1,3,1);
    imshow(M);
    subplot(1,3,2);
    mesh(M);
    ax_3 = subplot(1,3,3);
    fft_im = fft2(M);
    imagesc(fftshift(log(abs(fft_im)) + 1));
    colormap(ax_3,gray)
    Fig = gcf;
    title(Fig.Children(end),strcat('$\theta = $', num2str(Theta(idx)), ', d = ', num2str(D(idx))) , 'Interpreter','latex');
end
fprintf('-----------------------------------\n');
fprintf('Comentários:\n(II.1) Como a função analisada é um sinal senoidal, a imagem produzida ao plotar essa função são linhas\nque possuem uma mesma orientação. Um primeiro ponto a se notar é o impacto da variável d, que impacta\nna grossura das linhas, assim como no surgimento de um "degrade" entre os valores máximo (em branco)\ne mínimo (em preto) da imagem. Isso ocorre pois, quanto menor o valor de d, maior é a frequência da\ncossenóide. A variavel teta impacta na horientação das linhas. Quando teta é nulo ou igual a 90,\na orientação das linhas é horizontal e vertical, respectivamente. Adicionalmente, os demais valores\nde teta produzem restas inclinadas.\n');
fprintf('(II.2) Por se tratar de sinais senoidais, era esperado que a DFT produzisse dois pontos correspondentes\na frequência desse sinal. Porém, como a DFT é a FFT da repetição periódica do sinal, é observado o surgimento\nde linhas passando por esses pontos, como se outras frequências estivessem presentes, que ocorrem justamente\npor essa extensão da imagem. Os exemplos com teta=90, quando d = 1 e 2, pode-se observar que o sinal fica\nconstante e igual a 1 (no primeiro caso) e compostos por varias listras preto e branco. É notável que\nem ambos os casos a DFT apresenta um único ponto na origem, sendo que no segundo caso este\nresultado é decorrente de aliasing.\n');
fprintf('-----------------------------------\n');
fprintf('Feche a Figura 1 para seguir para o próximo resultado.\n');
uiwait(pivot);
close all;

%% II.3 e II.4
fprintf('Resultados das questões II.3 e II.4\n');
h = @(x,y) 2*sin(pi*x)^2/(pi*x)^2*sin(pi*y)^2/(pi*y)^2;

[X,Y] = meshgrid(-2:4/49:2);
for i = 1:50
    for j = 1:50
        R(i,j) = h(X(i),Y(j));
    end
end
pivot = figure(1);
subplot(1,2,1);
mesh(X,Y,R);
R_fft = fft(R);
ax = subplot(1,2,2);
imagesc(fftshift(log(abs(R_fft)) + 1));
colormap(ax,gray);
fprintf('Feche a Figura 1 para seguir para o próximo resultado.\n');
uiwait(pivot);
close all;

%% II.5
fprintf('Resultados da questão II.5\n');
im_zelda = imread('zelda.tif');
im_text2 = imread('text2.tif');
fft_zelda = fft2(im_zelda);
fft_text2 = fft2(im_text2);

figure(1);
subplot(1,2,1);
imshow(im_zelda);
subplot(1,2,2);
imagesc(fftshift(log(abs(fft_zelda)) + 1));
colormap(gray);

figure(2);
subplot(1,2,1);
imshow(im_text2);
subplot(1,2,2);
imagesc(fftshift(log(abs(fft_text2)) + 1));
colormap(gray);

fprintf('------------------\n');
fprintf('Comentário:\nPor se tratarem de imagens "naturais" (imagens não aleatórias, mais familiares a nós humanos) a DFT dessas\nimagens apresentam componentes no entorno das baixas frequências, apresentando uma "núvem" no centro da\nrepresentação em frequência. É interessante notar que essa concentração em torno da origem é mais acentuada\nna figura zelda.tif, já que se trata de um rosto com o background desfocado, enquanto a outra figura apresenta\nmais informações de alta frequência, já que tem caracteres e outras informações com muitas bordas e transições.\nAdicionalmente, é interessante observar o surgimento de linhas que se estendem aos extremos, tal como encontrado\nno exercício II.2, que também ocorrem por conta das repetições discutidas naquele item.\n');
fprintf('------------------\n');