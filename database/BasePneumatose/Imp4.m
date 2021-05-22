clear;clc;close all;

%% Implementa��o segundo a �ltima reuin�o  com jugurta
% -> Banco de filtros
% -> Fus�o de Imagens resultantes


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

%% Banco de Filtro 
nomedir='1';
arquivos = dir(strcat('./',nomedir)); %diret�rio das bases
quantIm = length(arquivos)-2;

h = waitbar(0,'Processando base...');

vmax=[];
for l = 1: quantIm
b=double(imread(strcat(nomedir,'/',arquivos(l+2).name)))-127;

%Filtro Casado
imres = filtrocasado(A, b);
resultado(l).im = imres;

[x y] = find(imres == max(max(imres))); 

vmax=[vmax; x y];

waitbar(l/quantIm)
end
close(h)
%% 

%%Tentativas de fus�es
resprod=[];
ressoma=[];
for j =1:quantIm
    imres = resultado(j).im;
    
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



%% Eibi��o de resultado de processamento 

IMFsoma=imfuse(AM,imderivativo);

figure
subplot(1,2,1)
colormap('gray')
image(IMFsoma,'CDataMapping','scaled')
title('Im M�ximos');
hold on
plot(vmax(:,1),vmax(:,2),'dr')
legend('Pontos m�ximos')

subplot(1,2,2)
colormap('gray')
image(imderivativo,'CDataMapping','scaled')
title('Im Fus�o Linear + Filtro Derivativo');

figure

image(A,'CDataMapping','scaled')
colorbar
title('IMFsoma');

imwrite(uint8(imderivativo),'bordas.png')
%% Exibi��o de resultado de processamento por regi�o
%comparando com as marca��es de M�rcia

% MMR=imfuse(MM,achadosreg);
%     
% subplot(1,2,2)   
% image(MMR,'CDataMapping','scaled')
% colormap('gray')
% title('Resultado');
% hold on
% plot(achados(:,2),achados(:,1),'dr')

toc

