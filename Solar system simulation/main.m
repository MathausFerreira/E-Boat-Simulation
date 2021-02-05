%% Modelagem e simula��o de desempenho de um painel fotovolt�ico
% Respons�vel: Lucas Fiorani Diniz
% lucas.diniz@engenharia.ufjf.br

%% Par�metros Importantes:
% Isc - Corrente de curto-circuito
% Imp - Corrente de m�xima pot�ncia
% Vmp - Tens�o de m�xima pot�ncia
% Voc - Tens�o de circuito aberto

clear all; close all; clc
%% Configura��o
% Defina��o das especifica��es do painel, condi��es de refer�ncia e par�metros calculados
inicializacao()

% Condi��es do ambiente
Ta = 25; % Temperatura do ambiente em �C (Padr�o: 25�C)
Gt = 1000; % Irradi�ncia solar em W/m^2 (Padr�o: 1000 W/m^2)

%% Modelagem da rela��o tens�o-corrente
% Aplica��o do fator de corre��o por irradi�ncia e temperatura
caso = correcao(Ta, Gt);

% Obten��o dos valores da curva tens�o-corrente do painel fotovolt�ico
[V,I] = curva_v_x_i(caso);

%% Plotagem
% Plotagem da curva tens�o-corrente do painel fotovolt�ico
plota_curva(V, I, caso)

%% Estudo de caso: Laranjal do Jari (0.801�S 52.449�O)
% Temperatura m�dia por m�s (�C)
Tamed = [26.5; 25.5; 25.5; 25.5; 25.5; 25.5; 26; 27.5; 28.5; 29.5; 29; 28];
% Radia��o solar di�ria m�dia por m�s (kWh/m^2*dia)
Rsmed = [4.36; 4.31; 4.28; 4.29; 4.50; 4.69; 4.71; 4.99; 5.15; 5.10; 4.93; 4.46];

% C�lculo da energia di�ria m�dia produzida pelo pain�l, para cada m�s do ano
Ed = geracao_solar(Tamed, Rsmed);

% Plotagem da produ��o mensal de energia (kWh)
plota_producao(Ed)
