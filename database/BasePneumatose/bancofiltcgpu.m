function [resultado, maximos] = bancofiltcgpu( A,limiar )
%Processamento da imagem A por todos os kernels contidos em nomedir. Retorna
%as maiores correspondências acima do limiar, em formato de matriz
%multidimencional. resultado(nk(canais), dimxA, dimyA)
%   Detailed explanation goes here

%% Abrindo diretório ds kernels
nomedir='4'; 
arquivos = dir(strcat('./',nomedir)); %diretório das bases
quantIm = length(arquivos)-2;

b=double(imread(strcat(nomedir,'/',arquivos(3).name)));

%% Inicialização da variáveis
imres = zeros(size(A,1)+size(b,1)-1,size(A,1)+size(b,1)-1); 
vmax=zeros(size(imres)); % para recorte de valores dentro do limiar
dim=[size(imres)]; %vetor de dimensões

% Tensor com valores de imres dentro da faixa definida em limiar
resultado=zeros(quantIm,dim(1),dim(2));

%Localização dos pontos máximos referentes a cada kernel
maximos=zeros(2,quantIm);

%%
h = waitbar(0,'Processando imagem no Banco de Filtros');

for l = 1: quantIm
b=double(imread(strcat(nomedir,'/',arquivos(l+2).name)));

%Filtro Casado
imres = filtrocasadogpu(A, b);

%construção de máscara para recorte dos máximos
vmax = zeros(size(imres));

maximo=max(max(imres));

%localização do máximo
[x y] =find(imres==maximo);
maximos(:,l)=[x y];

vmax(imres>(maximo*limiar))= 1;
%Recorte dos valores mínimos (permanece apenas os máximos)
resultado(l,:,:) = vmax.*imres;

waitbar(l/quantIm)
end

delete(h)
end

