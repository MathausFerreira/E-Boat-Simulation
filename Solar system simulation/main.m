%% Modelagem e simula��o de desempenho de um painel fotovolt�ico
% Respons�vel: Lucas Fiorani Diniz
% lucas.diniz@engenharia.ufjf.br

%% Par�metros Importantes:
% Isc - Corrente de curto-circuito
% Imp - Corrente de m�xima pot�ncia
% Vmp - Tens�o de m�xima pot�ncia
% Voc - Tebs�o de circuito aberto

clear all; close all; clc
%% Configura��o
% Define especifica��es do painel e condi��es do ambiente
inicializacao()

global spec;

% Aplica fator de corre��o por irradi�ncia e temperatura
correcao();

%% Modelagem da rela��o tens�o-corrente
% Inicializa��o dos vetores de tens�es e correntes
V = [0:.0001:spec.Voc];
I = zeros(1,length(V));
for i=1:length(I)
    % Aplica a rela��o tens�o-corrente do painel fotovolt�ico
    I(i) = curva_v_x_i(V(i));
end

% C�lcula par�metros de interesse
calcula_parametros()

%% Plotagem
% Plota a curva tens�o-corrente do painel fotovolt�ico
plota_curva(V, I)
