clear;clc;close all;

%% Implementação segundo a última reuinão  com jugurta
% -> Banco de filtros
% -> Fusão de Imagens resultantes


%% Abertura das imagens
tic
Ag = imread('../Exames/5961.1.jpg');

if length(size(Ag))==3
   A=double(rgb2gray(Ag));
else
    A=double(Ag);
end 

Am = imread('./Mascaras/5961.1m.jpg');

if length(size(Am))==3
   AM=double(rgb2gray(Am));
else
    AM=double(Am);
end 

resultado=[];
imres = []; 

%limiar de correpondência
limiar=0.8;

%% Banco de Filtro 
nomedir='4';
arquivos = dir(strcat('./',nomedir)); %diretório das bases
quantIm = length(arquivos)-2;

h = waitbar(0,'Processando base...');

vmax=[];
for l = 1: quantIm
b=double(imread(strcat(nomedir,'/',arquivos(l+2).name)))-127;

%Filtro Casado
imres = filtrocasado(A, b);
resultado(l).im = imres;

[x y] = find(imres>max(max(imres))*limiar); 

vmax(l).x=x;
vmax(l).y=y;
vmax(l).img = zeros(size(imres));
vmax(l).img(imres>max(max(imres))*limiar) = 1;
vmax(l).img = vmax(l).img.*imres;
clear x y;

waitbar(l/quantIm)
end
close(h)
%% Tentativas de fusões
resprod=[];
ressoma=[];
for j =1:quantIm
    imres = vmax(j).img;
    
    if(j==1)
        resprod=imres;
        ressoma=abs(imres);
    else
        resprod=resprod.*imres;
        ressoma=ressoma+abs(imres);
    end
    
end
[imderivativo, grad]=fderivativo(ressoma);
%Filtro derivativo



%% Eibição de resultado de processamento 

IMFsoma=imfuse(AM,imderivativo);

figure
subplot(1,2,1)
colormap('gray')
image(IMFsoma,'CDataMapping','scaled')
title('Im Máximos');
% hold on
% plot(vmax(:,2),vmax(:,1),'dr')
% legend('Pontos máximos')

subplot(1,2,2)
colormap('gray')
image(ressoma,'CDataMapping','scaled')
title('Im Fusão Linear + Filtro Derivativo');



toc

