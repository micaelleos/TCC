function [ Jgather ] = filtrocasadogpu( A, b )
%Implementa��o de Filtro Casado em GPU
%   Detailed explanation goes here
Agpu=gpuArray(A); % Transfere dados para a GPU
bgpu=gpuArray(b);
Jgpu=normxcorr2(bgpu,Agpu); % calcula a correla��o crusada 2D normalizada
Jgather=gather(Jgpu); % Tr�s de volta os dados para a CPU
end

