clear; clc; close all;
% Para a função ddwaveletdec funcionar a dimensão da imagem
% deve ser multipla de 2
A = imread('../img/1.jpeg');
imshow(A)
%A1=double(rgb2gray(A));
A1=double(A);

n=8
niveisdec = multdecwave(A1,'haar',n);

map=colormap('pink');

for i=1:n
showdecwave( niveisdec(i).WLL,niveisdec(i).WLH,niveisdec(i).WHL,niveisdec(i).WHH,map,0 );
end

energy  = waveEnergy( niveisdec );
energy2=energy/sum(sum(energy));

figure;plot(energy(:,1))
figure;plot(energy(:,2))
figure;plot(energy(:,3))
figure;plot(energy(:,4))