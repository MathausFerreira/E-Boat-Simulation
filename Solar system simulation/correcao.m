% Aplica fator de corre��o por irradi�ncia e temperatura
function correcao()

global spec amb;

% C�lculo dos resistores Rs e Rp do circuito equivalente (HECKTHEUER, 2001)
Rs = (spec.Voc-spec.Vmp)/spec.Imp;
Rp = spec.Voc/(spec.Isc-spec.Imp);

% Fatores de corre��o
T = amb.Ta + 0.02*amb.Gt;
dT = T - amb.Tref;
dI = (amb.alfa/100)*spec.Isc*(amb.Gt/amb.Gtref)*dT+((amb.Gt/amb.Gtref)-1)*spec.Isc;
dV = (amb.beta/100)*spec.Voc*dT-Rs*dI;

% Atualiza��o dos valores refer�ncia
spec.Isc = spec.Isc + dI; spec.Imp = spec.Imp + dI; 
spec.Vmp = spec.Vmp + dV; spec.Voc = spec.Voc + dV;

end