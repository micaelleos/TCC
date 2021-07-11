function [ tLn ] = extratensor(tensor,coor,dimj)
% Função de extração de tensores a partir das coordenadas(coor). Recorte
%%pela extensão de tensor.
% tensor= o proprio tensor.
% coor= coordenadas de recorte.
% dimj= Dimensão da janela de recorte no tensor, é um escalar.
%tLn = conjunto de tensores. size(tLn)=(nt,nk,x,y).

nk=size(tensor,1);
nt=length(coor);
tLn=zeros(nt,nk,dimj,dimj);

for i = 1: nt
%REVER SE VALOR MÁXIMO É NO CENTRO DO KERNEL OU NO INÍCIO.
    tLn(i,:,:,:)=tensor(:,coor(1,i):coor(1,i)+dimj-1,coor(2,i):coor(2,i)+dimj-1);
end

end

