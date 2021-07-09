function [ Jgather ] = filtrocasadogpu( A, b )
%Implementação de Filtro Casado em GPU
%   Detailed explanation goes here
Agpu=gpuArray(A); % Transfere dados para a GPU
bgpu=gpuArray(b);
Jgpu=normxcorr2(bgpu,Agpu); % calcula a correlação crusada 2D normalizada
Jgather=gather(Jgpu); % Trás de volta os dados para a CPU
end

