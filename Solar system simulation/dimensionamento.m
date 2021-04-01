% Estima o n�mero de pain�is necess�rios com base na carga atendida
function [N, A] = dimensionamento(Carga, Ed)
% Vari�veis globais
global param;
% Dimensionamento do n�mero de placas fotovolt�icas necess�rias
N = ceil(Carga/min(Ed));
% �rea total ocupada pelos pain�is, em m^2
A = param.A*N;