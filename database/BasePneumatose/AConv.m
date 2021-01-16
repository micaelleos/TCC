clear;clc; close all;

A = imread('../Exames/5961.1.jpeg');
%A = imread('../Exames/Camada 3.png');

if length(size(A))==3
   A=double(rgb2gray(A));
else
    A=double(A);
end

%diretório das bases
arquivos = dir('./2'); 

% número de imgbase abertas por vez
n=1; 
figure
image(A,'CDataMapping','scaled')
colormap('gray')

for i = 1:n
%   abre imgbase 
    b1=double(rgb2gray(imread(strcat('2/',arquivos(i+2).name))));
    %b1=b1-127;%max(max(b1));
    figure
    image(b1,'CDataMapping','scaled')
    title(char(arquivos(i+2).name));
    
    y=b1;
    x=max(b1);
    x2=repmat(x,size(b1,1),1);
    y2=y./x2-1;
    
    
    figure
    image(y2,'CDataMapping','scaled')
%   normalização do filtro b
    %b=b/max(max(b));
    %b=b/norm(b);  
   
    %imres = convn(A,b,'same');
    %[y,x]=find(imres==min(min(imres)));
    
    

%     limiar=19;
%     imres(imres<limiar)=0;
%     imres3=A;
%     imres3(imres>limiar)=255;
%     imres3=imres3*255/max(max(imres3));
%     imshow(uint8(imres3))
end





    
    
    
    