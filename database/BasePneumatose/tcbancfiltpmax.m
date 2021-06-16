function [tresL2] = tcbancfiltpmax(A,resL1,nomex)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
imres = []; 


%pasta fixa filtros
nomedir=strcat('./Base_de_teste_2/',nomex,'/20x20');

arquivos = dir(strcat('./',nomedir)); %diretório das bases
quantIm = length(arquivos)-2;

h = waitbar(0,'Extraindo tensores da saída da camada 1 ');

tresL2=zeros(quantIm,size(resL1,1),20,20);

for l = 1: quantIm
b=double(imread(strcat(nomedir,'/',arquivos(l+2).name)));

%Filtro Casado
imres = filtrocasado(A, b);

%encontra região dos pontos máximos (próximos à 1)
[x y] = find(max(max(imres)));  

%Corte através do tensor
tresL2(l,:,:,:)=resL1(:,x:x+19,y:y+19);

clear x y;

waitbar(l/quantIm)
end
toc

delete(h)


save(strcat('./4/tensor/tL2'),'tresL2');
end

