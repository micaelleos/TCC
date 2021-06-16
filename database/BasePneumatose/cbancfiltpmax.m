function [ resultado ] = cbancfiltpmax(A,limiar)
% convolutional layer = Banco de filtros casados; pooling layer = máximos 
%   Detailed explanation goes here


imres = []; 
vmax=[];

%pasta fixa filtros
nomedir='4'; 

arquivos = dir(strcat('./',nomedir)); %diretório das bases
quantIm = 3;length(arquivos)-3;

%excluir pasta tensor
arquivos(find(strcmp({arquivos(:).name},'tensor')==1))=[];

h = waitbar(0,'Processando imagem na camada 1');

resultado=zeros(quantIm,size(A,1)-10,size(A,2)-10);
for l = 1: quantIm
b=double(imread(strcat(nomedir,'/',arquivos(l+2).name)));

%Filtro Casado
imres = filtrocasado(A, b);

%encontra região dos pontos máximos (próximos à 1)
[x y] = find(imres>max(max(imres))*limiar);  

%coordenadas dos máximos
% vmax(l).x=x; 
% vmax(l).y=y; 

%construção de máscara para recorte dos máximos
vmax = zeros(size(imres)); 
vmax(imres>max(max(imres))*limiar) = 1;

%Recorte dos valores mínimos (permanece apenas os máximos)
resultado(l,:,:) = vmax.*imres;
clear x y;

waitbar(l/quantIm)
end
toc

delete(h)

save(strcat('./',nomedir,'/tensor/tL1'),'resultado');

end

