clear;clc; close all;

A = double(imread('../Exames/6019.1.jpeg'));

%diretório das bases
arquivos = dir('./2'); 

% número de imgbase abertas por vez
n=3; 
figure(1)
imshow(uint8(A))

 w =  [ 0.1512    0.1512    0.1512    0.1512    0.1512    0.1512    0.1512    0.1512    0.1512    0.1512;
   -0.0378   -0.0378   -0.0378   -0.0378   -0.0378   -0.0378   -0.0378   -0.0378   -0.0378   -0.0378;
   -0.2268   -0.2268   -0.2268   -0.2268   -0.2268   -0.2268   -0.2268   -0.2268   -0.2268   -0.2268;
   -0.0378   -0.0378   -0.0378   -0.0378   -0.0378   -0.0378   -0.0378   -0.0378   -0.0378   -0.0378;
    0.1512    0.1512    0.1512    0.1512    0.1512    0.1512    0.1512    0.1512    0.1512    0.1512];
    
    

for i = 2:n
    % abre imgbase 
    b1=double(rgb2gray(imread(strcat('2/',arquivos(i+2).name))));
    b1=b1(1:8:end,1:8:end);
    %normalização do filtro b
    b=b1-127;%max(max(b1));
    b=b/max(max(b));
    b=b/norm(b);
    figure;surf(b)
    figure;surf(w)
%     A=max(max(A))-A;
%     A=A/norm(A);
   
    imres = convn(A,b,'same');
    [y,x]=find(imres==min(min(imres)));
    
    
%     figure
%     imshow(uint8(b1))
%     title(strcat('Imgbase ',int2str(i)))
    %imres=imres-1500;
    figure
%     surf(imres)
%     hold on
    image(imres-1000)
    colormap('pink')
%     
%     figure(1)
%     hold on
%     plot(x,y,'o')
%     text(x,(y+20),int2str(i),'Color','red','FontSize',20)
%     drawnow 
end





    
    
    
    