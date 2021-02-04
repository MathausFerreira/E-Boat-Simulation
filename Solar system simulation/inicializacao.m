% Define especifica��es do painel e condi��es do ambiente
function inicializacao()

global spec amb;

%% Especifica��es do painel fotovolt�ico
Vmp = 17.4;
Imp = 5.75;
Voc = 21.58;
Isc = 6.04;
% Dimens�es do painel em mm
dim = struct('C',1020,'L',670,'A',30);

%% Condi��es do ambiente
Ta = 25; % Temperatura do ambiente em �C
Gt = 1000; % Irradi�ncia solar em W/m^2

Tref = 45; % Temperatura refer�ncia do painel em �C (Padr�o: 45)
Gtref = 1000; % Irradi�ncia solar refer�ncia em W/m^2 (Padr�o: 1000)

% Coeficientes de temperatura do painel
alfa = 0.05; % Coef. da corrente em %/�C
beta = -0.32; % Coef. da tens�o em %/�C

%% Preenchimento das estruturas
spec = struct('Vmp',Vmp,'Imp',Imp,'Voc',Voc,'Isc',Isc,'dim',dim);
amb = struct('Ta',Ta,'Gt',Gt,'Tref',Tref,'Gtref',Gtref,'alfa',alfa,'beta',beta);

end