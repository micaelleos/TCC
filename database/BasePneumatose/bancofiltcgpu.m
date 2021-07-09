function [ resultado ] = bancofiltcgpu( A,limiar )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

%% Abrindo diret�rio ds kernels
nomedir='4'; 
arquivos = dir(strcat('./',nomedir)); %diret�rio das bases
quantIm = 2;length(arquivos)-3;

%excluir pasta tensor
arquivos(find(strcmp({arquivos(:).name},'tensor')==1))=[];
b=imread(strcat(nomedir,'/',arquivos(3).name));

%% Inicializa��o da vari�veis
imres = zeros(size(A,1)+size(b,1)-1,size(A,1)+size(b,1)-1); 
vmax=zeros(size(imres)); % para recorte de valores dentro do limiar
% Tensor com valores de imres dentro da faixa definida em limiar
dim=[size(imres)];
resultado=zeros(quantIm,dim(1),dim(2));

%%
h = waitbar(0,'Processando imagem na camada 1');

for l = 1: quantIm
b=double(imread(strcat(nomedir,'/',arquivos(l+2).name)));

%Filtro Casado
imres = filtrocasadogpu(A, b);

%constru��o de m�scara para recorte dos m�ximos
vmax = zeros(size(imres)); 
vmax(imres>max(max(imres))*limiar)= 1;
%Recorte dos valores m�nimos (permanece apenas os m�ximos)
resultado(l,:,:) = vmax.*imres;

waitbar(l/quantIm)
end

delete(h)

%% Salvamento de dados processados em arquivo .mat
%tL1=resultado;

%save(strcat('./',nomedir,'/tensor/tL1'),'tL1');
end

