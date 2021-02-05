%% Modelagem e simulação de desempenho de um painel fotovoltáico
% Responsável: Lucas Fiorani Diniz
% lucas.diniz@engenharia.ufjf.br

%% Parâmetros Importantes:
% Isc - Corrente de curto-circuito
% Imp - Corrente de máxima potência
% Vmp - Tensão de máxima potência
% Voc - Tensão de circuito aberto

clear all; close all; clc
%% Configuração
% Definação das especificações do painel, condições de referência e parâmetros calculados
inicializacao()

% Condições do ambiente
Ta = 25; % Temperatura do ambiente em °C (Padrão: 25°C)
Gt = 1000; % Irradiância solar em W/m^2 (Padrão: 1000 W/m^2)

%% Modelagem da relação tensão-corrente
% Aplicação do fator de correção por irradiância e temperatura
caso = correcao(Ta, Gt);

% Obtenção dos valores da curva tensão-corrente do painel fotovoltáico
[V,I] = curva_v_x_i(caso);

%% Plotagem
% Plotagem da curva tensão-corrente do painel fotovoltáico
plota_curva(V, I, caso)

%% Estudo de caso: Laranjal do Jari (0.801°S 52.449°O)
% Temperatura média por mês (°C)
Tamed = [26.5; 25.5; 25.5; 25.5; 25.5; 25.5; 26; 27.5; 28.5; 29.5; 29; 28];
% Radiação solar diária média por mês (kWh/m^2*dia)
Rsmed = [4.36; 4.31; 4.28; 4.29; 4.50; 4.69; 4.71; 4.99; 5.15; 5.10; 4.93; 4.46];

% Cálculo da energia diária média produzida pelo painél, para cada mês do ano
Ed = geracao_solar(Tamed, Rsmed);

% Plotagem da produção mensal de energia (kWh)
plota_producao(Ed)
