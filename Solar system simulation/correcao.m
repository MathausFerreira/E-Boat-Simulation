% Aplica fator de correção por irradiância e temperatura
function correcao()

global spec amb;

% Cálculo dos resistores Rs e Rp do circuito equivalente (HECKTHEUER, 2001)
Rs = (spec.Voc-spec.Vmp)/spec.Imp;
Rp = spec.Voc/(spec.Isc-spec.Imp);

% Fatores de correção
T = amb.Ta + 0.02*amb.Gt;
dT = T - amb.Tref;
dI = (amb.alfa/100)*spec.Isc*(amb.Gt/amb.Gtref)*dT+((amb.Gt/amb.Gtref)-1)*spec.Isc;
dV = (amb.beta/100)*spec.Voc*dT-Rs*dI;

% Atualização dos valores referência
spec.Isc = spec.Isc + dI; spec.Imp = spec.Imp + dI; 
spec.Vmp = spec.Vmp + dV; spec.Voc = spec.Voc + dV;

end