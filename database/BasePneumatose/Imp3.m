%% Lógica 3
%levando em consideração estrutura fixa de filtos, onde o pedaço da imagem
%passa por eles e a saida da operação é um vetor correspondendo do de
%semelhança de cada flitro por esta imagem.Obs: as janelinhas podem ser
%menores ainda do que 40x40, pois é a parte mais básica da estrutura que se
%está procurando.

%----------------- ignorando o que está escrito acima-------

clear;clc;close all;

%% Abertura das imagens
tic
Ag = imread('../Exames/5961.1.jpg');

if length(size(Ag))==3
   A=double(rgb2gray(Ag));
else
    A=double(Ag);
end 

Am = imread('./Mascaras/5961.1.jpg');

if length(size(Am))==3
   AM=double(rgb2gray(Am));
else
    AM=double(Am);
end 

resultado=[];
imres = []; 


%% Banco de Filtro 
nomedir='4';
arquivos = dir(strcat('./',nomedir)); %diretório das bases
quantIm = length(arquivos)-3;
arquivos(find(strcmp({arquivos(:).name},'tensor')==1))=[];

h = waitbar(0,'Processando base...');

vmax=[];
for l = 1: quantIm
b=double(imread(strcat(nomedir,'/',arquivos(l+2).name)));

%Filtro Casado
imres = filtrocasado(A, b);
resultado(l).im = imres;

[x y] = find(max(max(imres))==imres); 

vmax(l).x=x;
vmax(l).y=y;
vmax(l).max=max(max(imres));

waitbar(l/quantIm)
end
close(h)

%% Eibição de resultado de processamento 

%IMF=imfuse(AM,A);
figure
colormap('gray')
image(A,'CDataMapping','scaled')
hold on
plot([vmax.y],[vmax.x],'rd')

figure
colormap('gray')
image(imres,'CDataMapping','scaled')

toc

