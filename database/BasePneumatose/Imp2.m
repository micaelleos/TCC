%%% C�digo teste 2
%  Implementa��o da busca em multiescala, restrita ao chute dado pela camada
% anterior, a mais grosseira.

clear;clc; close all;

%% Abertura das imagens
Ag = imread('../Exames/9793.2w.jpg');

if length(size(Ag))==3
   A=double(rgb2gray(Ag));
else
    A=double(Ag);
end 

%mascara para calculo de erros e acertos
Am = imread('./Mascaras/9793.2m.jpg');

if length(size(Am))==3
   AM=double(rgb2gray(Am));
else
    AM=double(Am);
end 

% Par�metros
correspo= 0.8 ; % porcentagem de melhores correspond�ncias

% Contru��o das pir�medes
niveis=4;
piramA = downsamplep( A, niveis );
piramAM = downsamplep( AM, niveis );


%% abre imgbase 
arquivos = dir('./2'); %diret�rio das bases
quantIm = length(arquivos)-2;
%quantIm =1;
achados=[];
achadosreg=zeros(size(piramA(1).imd));
h = waitbar(0,'Processando base...');

for l = 1: quantIm
%bg=double(rgb2gray(imread(strcat('2/',arquivos(i+2).name))));
b=double(imread(strcat('2/',arquivos(l+2).name)))-127;
piramb = downsamplep( b, niveis ); % cria��o de pir�mide do kernel

%% Inicializa��o de par�metros
mascreg=ones(size(piramA(niveis/2+1).imd));
imres = [];
masc=[];

for i = niveis/2+1:-1:1
    
tic
%Filtro Casado
imres = filtrocasadop( piramA(i).imd, piramb(i).imd, mascreg );
toc
%% Encontrar melhor ponto/regi�o correspondente
masc=zeros(size(imres));
masc(imres>(max(max(imres))*correspo))=1;
[x y] = find(imres == max(max(imres))); 

% Fus�o de Imagens para visualiza��o de resultado (a escolha das regi�es)
c1=imfuse(masc,piramA(i).imd);
c=imfuse(c1,piramAM(i).imd);
    
mascreg = estendermasc(masc);
%% Exibi��o

figure(l)
clf
subplot(1,3,1)
image(piramb(i).imd,'CDataMapping','scaled')
colormap('gray')
title('Kernel');
subplot(1,3,2)
image(imres,'CDataMapping','scaled')
title(char(strcat('Resultado',arquivos(l+2).name)));
hold on
plot(y,x,'dr')
subplot(1,3,3)
image(c,'CDataMapping','scaled')
colormap('gray')
title(char(strcat('Resultado',arquivos(l+2).name)));
hold on
plot(y,x,'dr')
end
waitbar(l/quantIm)
achados = [achados; x y];
achadosreg = achadosreg + masc;

end
close(h)

%% Eibi��o de resultado de processamento 
% comparado com as marca��es da m�dica, levando em considera��o melhores
% pontos
MM=imfuse(piramA(1).imd,piramAM(1).imd);

figure
subplot(1,2,1)   
image(MM,'CDataMapping','scaled')
title('Marca��es de M�rcia');
hold on
plot(achados(:,2),achados(:,1),'dr')

%% Exibi��o de resultado de processamento por regi�o
%comparando com as marca��es de M�rcia

MMR=imfuse(MM,achadosreg);
    
subplot(1,2,2)   
image(MMR,'CDataMapping','scaled')
colormap('gray')
title('Resultado');
hold on
plot(achados(:,2),achados(:,1),'dr')