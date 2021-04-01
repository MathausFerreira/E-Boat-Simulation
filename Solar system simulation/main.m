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
% Defini��o das especifica��es do painel, condi��es de refer�ncia e par�metros calculados
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
% Temperatura m�dia por m�s (�C), dados do CLIMATEMPO
Tamed = [26.5; 25.5; 25.5; 25.5; 25.5; 25.5; 26; 27.5; 28.5; 29.5; 29; 28];
% Irradia��o solar di�ria m�dia por m�s (kWh/m^2*dia), dados do CRESESB
Rsmed = [4.36; 4.31; 4.28; 4.29; 4.50; 4.69; 4.71; 4.99; 5.15; 5.10; 4.93; 4.46];

% C�lculo da energia di�ria m�dia produzida pelo pain�l, para cada m�s do ano
Ed = geracao_solar(Tamed, Rsmed);

% Plotagem da produ��o mensal de energia para um pain�l (kWh)
E = plota_producao(Ed);

%% An�lise da carga
% N�mero de baterias
n = 8;
% Capacidade de cada bateria, em Wh
Capacidade = 5275;
% N�mero de recargas di�rias de cada bateria
n_charge = 3;
% Carga total di�ria, em W
Carga = n*Capacidade*n_charge;

%% Dimensionamento do conjunto
% Estima o n�mero m�nimo de pain�is necess�rios com base na carga atendida
[N, A] = dimensionamento(Carga, Ed);
