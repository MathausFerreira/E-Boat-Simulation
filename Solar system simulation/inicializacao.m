% Defina��o das especifica��es do painel, condi��es de refer�ncia e par�metros calculados
function inicializacao()
% Vari�veis globais
global spec amb param;

%% Especifica��es do painel fotovolt�ico
Vmp = 17.4; % Tens�o de m�xima pot�ncia
Imp = 5.75; % Corrente de m�xima pot�ncia
Voc = 21.58; % Tens�o de circuito aberto
Isc = 6.04; % Corrente de curto-circuito
dim = struct('C',1020,'L',670,'A',30); % Dimens�es do painel em mm
alfa = 0.05; % Coeficiente de temperatura da corrente em %/�C
beta = -0.32; % Coeficiente de temperatura da tens�o em %/�C

%% Condi��es de refer�ncia do ambiente
Tref = 45; % Temperatura de refer�ncia do painel em �C (Padr�o: 45)
Gtref = 1000; % Irradi�ncia solar de refer�ncia em W/m^2 (Padr�o: 1000)

%% Par�metros calculados
Pmax = Imp*Vmp; % Pot�ncia m�xima
FF = Pmax/(Isc*Voc); % Fator de forma (ideal > 0.7)
A = dim.C*dim.L*10^-6; % �rea do painel em m^2
nmax = Pmax/(A*Gtref); % Efici�ncia m�xima

%% Preenchimento das estruturas
spec = struct('Vmp',Vmp,'Imp',Imp,'Voc',Voc,'Isc',Isc,'dim',dim);
amb = struct('Tref',Tref,'Gtref',Gtref,'alfa',alfa,'beta',beta);
param = struct('Pmax',Pmax,'FF',FF,'A',A,'nmax',nmax);

end