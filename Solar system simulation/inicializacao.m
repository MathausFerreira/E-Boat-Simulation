% Define especificações do painel e condições do ambiente
function inicializacao()

global spec amb;

%% Especificações do painel fotovoltáico
Vmp = 17.4;
Imp = 5.75;
Voc = 21.58;
Isc = 6.04;
% Dimensões do painel em mm
dim = struct('C',1020,'L',670,'A',30);

%% Condições do ambiente
Ta = 25; % Temperatura do ambiente em °C
Gt = 1000; % Irradiância solar em W/m^2

Tref = 45; % Temperatura referência do painel em °C (Padrão: 45)
Gtref = 1000; % Irradiância solar referência em W/m^2 (Padrão: 1000)

% Coeficientes de temperatura do painel
alfa = 0.05; % Coef. da corrente em %/°C
beta = -0.32; % Coef. da tensão em %/°C

%% Preenchimento das estruturas
spec = struct('Vmp',Vmp,'Imp',Imp,'Voc',Voc,'Isc',Isc,'dim',dim);
amb = struct('Ta',Ta,'Gt',Gt,'Tref',Tref,'Gtref',Gtref,'alfa',alfa,'beta',beta);

end