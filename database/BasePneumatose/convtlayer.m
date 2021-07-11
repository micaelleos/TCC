function [ resLn ] = convtlayer(tLnx,layer)
%Convolution tensor on layer
%   Detailed explanation goes here

tLn_t=gpuArray(importdata(strcat('./tensor/tL',int2str(layer),'_t.mat')));
dim=size(tLn_t);

tLn=gpuArray(tLnx);
resLnx=zeros(dim(1),dim(3),dim(4));
paralel=parpool;

h = waitbar(0,strcat('Processando imagem na Camada:  ',int2str(layer)));
for i = 1:dim(1)
    tensor=squeeze(tLn_t(i,:,:,:));
    parfor c = 1:dim(2)
    resLnx(c,:,:)=convn(tensor(c,:,:),tLn(c,:,:));
    end
    waitbar(i/dim(1))
end
delete(h)
resLn=gather(resLnx);
delete(paralel);
reset(gpuDevice(1));
end

