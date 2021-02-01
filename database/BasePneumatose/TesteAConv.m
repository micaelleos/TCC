%% AConv
%Teste de operação de cross correlation
clear;clc; close all;

Ag = imread('../Exames/5961.1.jpeg');

if length(size(Ag))==3
   Ag=double(rgb2gray(Ag));
else
    Ag=double(Ag);
end 

 A  = downsample( Ag, 4 );
 
 figure
image(A,'CDataMapping','scaled')
colormap('gray')

 %% 

%diretório das bases
arquivos = dir('./1'); 

% número de imgbase abertas por vez
n=5; 

for i = 1:n
%   abre imgbase 
    bg=double(rgb2gray(imread(strcat('1/',arquivos(i+2).name))));
    b  = downsample( bg, 4 );
    %b=A(176-10:176+10,114-10:114+10);
    figure
    image(b,'CDataMapping','scaled')
    title('Kernel');
   
    tic
%   Filtro Casado
    %imres = crosscoor( A,b );
    imres = filtrocasado( A, b );
    toc
    
    [x y] = find(imres == max(max(imres)));
    
    figure
    image(imres,'CDataMapping','scaled')
    title(char(strcat('Resultado',arquivos(i+2).name)));
    figure
    image(A,'CDataMapping','scaled')
    title(char(strcat('Resultado',arquivos(i+2).name)));
    hold on
    plot(y,x,'dr')
end


    
    
    
    