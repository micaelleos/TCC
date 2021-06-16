%% Implementação 5 
% Estrutura de banco de filtros agora organizado para os tensores

clear;clc;close all;
%% Abertura das imagens
tic

nomex='5961.1';
%Abertura das imagens
dirI=strcat('../Exames/',nomex,'.jpg');    %exame
dirM=strcat('./Mascaras/',nomex,'m.jpg');  %mascara
[A,AM] = abririm(dirI,dirM);


%% Rede de Filtros 

%layer 1
[resL1] = cbancfiltpmax(A,0.8);

%% Extração de tensor para treinamento
%[tresL2] = tcbancfiltpmax(A,resL1,nomex);

%layer 2
%[resL2] =ctensorpmax(resL1,2);
