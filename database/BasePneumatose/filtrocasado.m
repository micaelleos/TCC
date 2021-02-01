function [ J ] = filtrocasado( A, b )
%UNTITLED2 Summary of this function goes here
%   espera-se que b tenha dimensões ímpares

[dbx dby]=size(b);

M=zeros(dbx,dby);
J=zeros(size(A,1),size(A,2));

b=b-mean(b(:));
b=b./norm(b);

A=A-mean(A(:));
A=A./norm(A);

% nesta convolução há redução da imagem de saída - sem padding
for i = 1:size(A,1)-ceil(dbx/2)
    for j = 1:size(A,2)-ceil(dby/2)
        if (i>ceil(dbx/2) && j>ceil(dby/2))
        M = A(i-ceil(dbx/2):i+floor(dbx/2)-1,j-ceil(dby/2):j+floor(dby/2)-1);
        M=M-mean(M(:));
        if (norm(M)~=0)
        M=M./norm(M);
        end
        J(i,j) = sum(sum(M.*b));
        end
    end
end

end

