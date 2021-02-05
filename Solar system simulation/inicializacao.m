% Definação das especificações do painel, condições de referência e parâmetros calculados
function inicializacao()
% Variáveis globais
global spec amb param;

%% Especificações do painel fotovoltáico
Vmp = 17.4; % Tensão de máxima potência
Imp = 5.75; % Corrente de máxima potência
Voc = 21.58; % Tensão de circuito aberto
Isc = 6.04; % Corrente de curto-circuito
dim = struct('C',1020,'L',670,'A',30); % Dimensões do painel em mm
alfa = 0.05; % Coeficiente de temperatura da corrente em %/°C
beta = -0.32; % Coeficiente de temperatura da tensão em %/°C

%% Condições de referência do ambiente
Tref = 45; % Temperatura de referência do painel em °C (Padrão: 45)
Gtref = 1000; % Irradiância solar de referência em W/m^2 (Padrão: 1000)

%% Parâmetros calculados
Pmax = Imp*Vmp; % Potência máxima
FF = Pmax/(Isc*Voc); % Fator de forma (ideal > 0.7)
A = dim.C*dim.L*10^-6; % Área do painel em m^2
nmax = Pmax/(A*Gtref); % Eficiência máxima

%% Preenchimento das estruturas
spec = struct('Vmp',Vmp,'Imp',Imp,'Voc',Voc,'Isc',Isc,'dim',dim);
amb = struct('Tref',Tref,'Gtref',Gtref,'alfa',alfa,'beta',beta);
param = struct('Pmax',Pmax,'FF',FF,'A',A,'nmax',nmax);

end