% Aplicação fator de correção por irradiância e temperatura
function caso = correcao(Ta, Gt)
% Variáveis globais
global spec amb;

% Cálculo dos resistores Rs e Rp do circuito equivalente (HECKTHEUER, 2001)
Rs = (spec.Voc-spec.Vmp)/spec.Imp;
Rp = spec.Voc/(spec.Isc-spec.Imp);

% Fatores de correção
T = Ta + 0.02*Gt;
dT = T - amb.Tref;
dI = (amb.alfa/100)*spec.Isc*(Gt/amb.Gtref)*dT+((Gt/amb.Gtref)-1)*spec.Isc;
dV = (amb.beta/100)*spec.Voc*dT-Rs*dI;

% Atualização dos parâmetros especificados
Isc = spec.Isc + dI; 
Imp = spec.Imp + dI; 
Vmp = spec.Vmp + dV;
Voc = spec.Voc + dV;

% Valores corrigidos para dada temperatura e irradiância
caso = struct('Vmp',Vmp,'Imp',Imp,'Voc',Voc,'Isc',Isc,'Ta',Ta,'Gt',Gt);

end