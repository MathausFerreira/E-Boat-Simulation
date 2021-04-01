% Estima o número de painéis necessários com base na carga atendida
function [N, A] = dimensionamento(Carga, Ed)
% Variáveis globais
global param;
% Dimensionamento do número de placas fotovoltáicas necessárias
N = ceil(Carga/min(Ed));
% Área total ocupada pelos painéis, em m^2
A = param.A*N;