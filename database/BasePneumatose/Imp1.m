%% AConv
%Teste de operação com filtro casado correlation
clear;clc; close all;

% abertura das imagens
Ag = imread('../Exames/6355.jpeg');

if length(size(Ag))==3
   Ag=double(rgb2gray(Ag));
else
    Ag=double(Ag);
end

d=4;
A  = downsample( Ag, d );
%A  = multiescala(A,d);
%A=Ag;

[J,coor] = bancofilt( A,d );

figure
image(A,'CDataMapping','scaled')
colormap('gray')
title('Resultado');
figure(1)
hold on
plot(coor(:,2),coor(:,1),'dr')

%% 
figure
c=imfuse(J,A);
image(c);

