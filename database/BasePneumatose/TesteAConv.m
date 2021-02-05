%% AConv
%Teste de operação com filtro casado correlation
clear;clc; close all;

% abertura das imagens
Ag = imread('../Exames/5961.1.jpeg');

if length(size(Ag))==3
   Ag=double(rgb2gray(Ag));
else
    Ag=double(Ag);
end 

A=medfilt2(Ag);
A  = downsample( A, 3 );
 
% pontos de maximo a serem encontrados
pontos=10;
correspo= 0.8 : % mporcentagem de melhores correspondências
%  figure
% image(A,'CDataMapping','scaled')
% colormap('gray')

 %% 

%diretório das bases
arquivos = dir('./2'); 

% número de imgbase abertas por vez
n=length(arquivos)-2; 

for i = 1:n
%   abre imgbase 
%    bg=double(rgb2gray(imread(strcat('2/',arquivos(i+2).name))));
     bg=double(imread(strcat('2/',arquivos(i+2).name)));
    b=medfilt2(bg);
    b  = downsample( b, 3 );
    
    %b=A(176-10:176+10,114-10:114+10);
   
    tic
%   Filtro Casado
    %imres = crosscoor( A,b );
    imres = filtrocasado( A, b );
    %imres2 = normxcorr2(b,A);
    toc
    
%% Encontrar melhor ponto correspondente
    [x y] = find(imres == max(max(imres))); 
%     [sortedX, sortedInds] = sort(imres(:),'descend');
%     tops = sortedInds(1:pontos);
%     [x, y] = ind2sub(size(imres), tops);
    
    imres3=zeros(size(imres));
    imres3(imres>(max(max(imres))*correspo))=1;
    %[x2 y2] = find(imres2 == max(max(imres2)));
   
    c=imfuse(imres3,A);
    
    
    
%% Exibição
    figure
    subplot(1,3,1)
    image(b,'CDataMapping','scaled')
    colormap('gray')
    title('Kernel');
    subplot(1,3,2)
    image(imres,'CDataMapping','scaled')
    title(char(strcat('Resultado',arquivos(i+2).name)));
    hold on
    plot(y,x,'dr')
    subplot(1,3,3)
    image(c,'CDataMapping','scaled')
    colormap('gray')
    title(char(strcat('Resultado',arquivos(i+2).name)));
    hold on
    plot(y,x,'dr')
    
    
    
    
%     figure
%     title('2tipo')
%     subplot(1,2,1)
%     image(imres2,'CDataMapping','scaled')
%     title(char(strcat('Resultado',arquivos(i+2).name)));
%     subplot(1,2,2)
%     image(A,'CDataMapping','scaled')
%     colormap('gray')
%     title(char(strcat('Resultado',arquivos(i+2).name)));
%     hold on
%     plot(y2,x2,'dr')
end


    
    
    
    