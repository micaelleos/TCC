%%% Código teste 2
%  Implementação da busca em multiescala, restrita ao chute dado pela camada
% anterior, a mais grosseira.
tic
clear;clc; close all;

%% Abertura das imagens
Ag = imread('../Exames/5961.1.jpg');

if length(size(Ag))==3
   A=double(rgb2gray(Ag));
else
    A=double(Ag);
end 

%mascara para calculo de erros e acertos
Am = imread('./Mascaras/5961.1m.jpg');

if length(size(Am))==3
   AM=double(rgb2gray(Am));
else
    AM=double(Am);
end 

% Parâmetros
correspo= 0.99 ; % porcentagem de melhores correspondências

% Contrução das pirâmedes
niveis=4;
piramA = downsamplep( A, niveis );
piramAM = downsamplep( AM, niveis );


%% abre imgbase 
arquivos = dir('./5961.1'); %diretório das bases
quantIm = length(arquivos)-2;
%quantIm =1;
achados=[];
achadosreg=zeros(size(piramA(1).imd));
h = waitbar(0,'Processando base...');

v=[];
for l = 1: quantIm
%bg=double(rgb2gray(imread(strcat('2/',arquivos(i+2).name))));
b=double(imread(strcat('5961.1/',arquivos(l+2).name)))-127;
piramb = downsamplep( b, niveis ); % criação de pirâmide do kernel

%% Inicialização de parâmetros
mascreg=ones(size(piramA(niveis/2+1).imd));
imres = [];
masc=[];

for i = niveis/2+1:-1:1
    

%Filtro Casado
imres = filtrocasadop( piramA(i).imd, piramb(i).imd, mascreg );

%% Encontrar melhor ponto/região correspondente
masc=zeros(size(imres));
masc(imres>(max(max(imres))*correspo))=1;
[x y] = find(imres == max(max(imres))); 
mascreg = estendermasc(masc);
%% Exibição

% figure(l)
% clf
% subplot(1,3,1)
% image(piramb(i).imd,'CDataMapping','scaled')
% colormap('gray')
% title('Kernel');
% subplot(1,3,2)
% image(imres,'CDataMapping','scaled')
% title(char(strcat('Resultado',arquivos(l+2).name)));
% hold on
% plot(y,x,'dr')
% subplot(1,3,3)
% image(c,'CDataMapping','scaled')
% colormap('gray')
% title(char(strcat('Resultado',arquivos(l+2).name)));
% hold on
% plot(y,x,'dr')
end
v = [v max(max(imres))];
waitbar(l/quantIm)
achados = [achados; x y];
achadosreg = achadosreg + masc;

end
close(h)

%% Eibição de resultado de processamento 
% comparado com as marcações da médica, levando em consideração melhores
% pontos
MM=imfuse(piramA(1).imd,piramAM(1).imd);

figure
subplot(1,2,1)   
image(MM,'CDataMapping','scaled')
title('Marcações de Márcia');
hold on
plot(achados(:,2),achados(:,1),'dr')

%% Exibição de resultado de processamento por região
%comparando com as marcações de Márcia

MMR=imfuse(MM,achadosreg);
    
subplot(1,2,2)   
image(MMR,'CDataMapping','scaled')
colormap('gray')
title('Resultado');
hold on
plot(achados(:,2),achados(:,1),'dr')
%% Sensibilidade e Especificidade
n=floor(length(b)/2);
TP=0;
FP=0;
limiares_b=[];
limiares_r=[];
for k =1:length(achados)
  n1=achados(k,1);
  n2=achados(k,2);
    if (any(any(piramAM(1).imd(n1-n:n1+n,n2-n:n2+n))))
    TP = TP +1;
    limiares_b=[limiares_b v(k)];
    else 
    FP =FP+1;
    limiares_r=[limiares_r v(k)];
    end
end

toc

figure;
subplot(1,3,1);hist(v); title('Totais')
subplot(1,3,2);hist(limiares_b);title('Bons')
subplot(1,3,3);hist(limiares_r);title('Ruins')

FP
TP
disp('mean FP')
mean(limiares_r)
disp('mean TP')
mean(limiares_b)

disp('VAR FP')
var(limiares_r)
disp('VAR TP')
var(limiares_b)