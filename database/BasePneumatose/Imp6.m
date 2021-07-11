%% Implementação 6
% Funções com cálculo de computação paralela.
% Estrutura de banco de filtros agora organizado para os tensores

clear;clc;close all;
%% Abertura das imagens
%tic

nomex='5961.1'; 
%Abertura das imagens
dirI=strcat('../Exames/',nomex,'.jpg');    %exame
dirM=strcat('./Mascaras/',nomex,'.jpg');  %mascara
[A,AM] = abririm(dirI,dirM);

%% Banco de Filtros 

limiar=0.8;
%layer 1
[ resL1, maximos ] = bancofiltcgpu(A,limiar );

%% Extração de tensor para treinamento
[tL1_t] = extratensor(resL1,maximos,20);
salvaresultado('0',tL1_t);

%% Camada 2
[resL2] = convtlayer(resL1,1);
