function [resultado, maximos] = bancofiltcgpu( A,limiar )
%Processamento da imagem A por todos os kernels contidos em nomedir. Retorna
%as maiores correspond�ncias acima do limiar, em formato de matriz
%multidimencional. resultado(nk(canais), dimxA, dimyA)
%   Detailed explanation goes here

%% Abrindo diret�rio ds kernels
nomedir='4'; 
arquivos = dir(strcat('./',nomedir)); %diret�rio das bases
quantIm = length(arquivos)-2;

b=double(imread(strcat(nomedir,'/',arquivos(3).name)));

%% Inicializa��o da vari�veis
imres = zeros(size(A,1)+size(b,1)-1,size(A,1)+size(b,1)-1); 
vmax=zeros(size(imres)); % para recorte de valores dentro do limiar
dim=[size(imres)]; %vetor de dimens�es

% Tensor com valores de imres dentro da faixa definida em limiar
resultado=zeros(quantIm,dim(1),dim(2));

%Localiza��o dos pontos m�ximos referentes a cada kernel
maximos=zeros(2,quantIm);

%%
h = waitbar(0,'Processando imagem no Banco de Filtros');

for l = 1: quantIm
b=double(imread(strcat(nomedir,'/',arquivos(l+2).name)));

%Filtro Casado
imres = filtrocasadogpu(A, b);

%constru��o de m�scara para recorte dos m�ximos
vmax = zeros(size(imres));

maximo=max(max(imres));

%localiza��o do m�ximo
[x y] =find(imres==maximo);
maximos(:,l)=[x y];

vmax(imres>(maximo*limiar))= 1;
%Recorte dos valores m�nimos (permanece apenas os m�ximos)
resultado(l,:,:) = vmax.*imres;

waitbar(l/quantIm)
end

delete(h)
end

