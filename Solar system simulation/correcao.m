% Aplica��o fator de corre��o por irradi�ncia e temperatura
function caso = correcao(Ta, Gt)
% Vari�veis globais
global spec amb;

% C�lculo dos resistores Rs e Rp do circuito equivalente (HECKTHEUER, 2001)
Rs = (spec.Voc-spec.Vmp)/spec.Imp;
Rp = spec.Voc/(spec.Isc-spec.Imp);

% Fatores de corre��o
T = Ta + 0.02*Gt;
dT = T - amb.Tref;
dI = (amb.alfa/100)*spec.Isc*(Gt/amb.Gtref)*dT+((Gt/amb.Gtref)-1)*spec.Isc;
dV = (amb.beta/100)*spec.Voc*dT-Rs*dI;

% Atualiza��o dos par�metros especificados
Isc = spec.Isc + dI; 
Imp = spec.Imp + dI; 
Vmp = spec.Vmp + dV;
Voc = spec.Voc + dV;

% Valores corrigidos para dada temperatura e irradi�ncia
caso = struct('Vmp',Vmp,'Imp',Imp,'Voc',Voc,'Isc',Isc,'Ta',Ta,'Gt',Gt);

end