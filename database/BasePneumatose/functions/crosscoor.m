function [ J ] = crosscoor( A,b)
%Opera��o de correla��o crusada entre imagem 


%   Assume-se que b tem dimens�es �mpares.

% A2=zeros((size(A,1)+2*size(b,1)),(size(A,2)+2*size(b,2)));
% A2(size(b,1):end-size(b,1)-1,size(b,2):end-size(b,2)-1)=A;

J=zeros(size(A));

dx=size(b,1);
dy=size(b,2);

%Normaliza��o do filtro
b=b-mean(b(:));
b=b/norm(b);
M=zeros(size(b));

%convolu��o com resultado de mesma dimens�o que a imagem A
for i = 1:2:size(A,1)
    for j = 1:2:size(A,2)
        if((i<size(A,1)-dx)&&(j<size(A,2)-dy))
        %Janela de opera��o
        M=A(i:i+dx-1,j:j+dy-1);
  
        if(sum(find(M~=0))~=0)
        %Normaliza��o da Janela
        M=M-mean(M(:));
        M=M/norm(M);
        end
        
        J(i,j)=sum(sum(M.*b));
        end
        end
    end
end

