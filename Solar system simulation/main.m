%% Modelagem e simulação de desempenho de um painel fotovoltáico
% Responsável: Lucas Fiorani Diniz
% lucas.diniz@engenharia.ufjf.br

%% Parâmetros Importantes:
% Isc - Corrente de curto-circuito
% Imp - Corrente de máxima potência
% Vmp - Tensão de máxima potência
% Voc - Tebsão de circuito aberto

clear all; close all; clc
%% Configuração
% Define especificações do painel e condições do ambiente
inicializacao()

global spec;

% Aplica fator de correção por irradiância e temperatura
correcao();

%% Modelagem da relação tensão-corrente
% Inicialização dos vetores de tensões e correntes
V = [0:.0001:spec.Voc];
I = zeros(1,length(V));
for i=1:length(I)
    % Aplica a relação tensão-corrente do painel fotovoltáico
    I(i) = curva_v_x_i(V(i));
end

% Cálcula parâmetros de interesse
calcula_parametros()

%% Plotagem
% Plota a curva tensão-corrente do painel fotovoltáico
plota_curva(V, I)
