function recorteKernels(A,Am,tk)
%Recorte de kernels automático por meio de máscara.
%   A= Imagem a ser recortada, 
%   Am = Máscara da Imagem em preto e branco,
%   tk= tamanho dos recortes
[x y]=find(Am==255);
index = [x y];
d=floor(tk/2);
masc=zeros(size(A));
m=zeros(tk+1,tk+1);
n=0;
for i = 1: length(index)
   if(any(masc(index(i,1)-d:index(i,1)+d,index(i,2)-d:index(i,2)+d))==0)
   m=A(index(i,1)-d:index(i,1)+d,index(i,2)-d:index(i,2)+d);
   n=n+1;
   imwrite(uint8(m),strcat('.\kernels\',int2char(n),'.jpg'));
   masc(index(i,1)-d:index(i,1)+d,index(i,2)-d:index(i,2)+d)=1;   
   end
end

end

