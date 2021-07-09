clear;clc;close all;
load('D:\Users\micae\Documents\Universidade\11° Período\TCC\Codigos\TCC\TCC\database\BasePneumatose\4\tensor\tL2.mat')

x=[];
y=[];
z=[];
for i=1:size(tL2,1)
tensor=squeeze(tL2(i,:,:,:));
tensor2=zeros(size(tensor));
tensor2(tensor(:,:,:)>0.5)=1;

[z,x,y] = ind2sub(size(tensor),find(tensor2==1));

figure
plot3(z,x,y,'.');

clear x y z
end

tL2=resL2;
soma=zeros(size(tL2(1,:,:)));
for j=1:size(tL2,1)
    soma=soma+abs(tL2(j,:,:));
end

soma=resL2(10,:,:);%squeeze(soma);

soma=squeeze(soma);
figure
colormap('gray')
image(soma,'CDataMapping','scaled')


tic
any(any(a))
toc

if(any(any(a))~=0)
    disp('oi')
end