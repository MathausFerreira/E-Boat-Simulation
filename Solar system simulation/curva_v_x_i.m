% Aplica a rela��o tens�o-corrente do painel fotovolt�ico
function I = curva_v_x_i(V)

global spec;

% Descri��o da curva (SALAMEH, 1995)
C3 = 0.01175;
C6 = log((1+C3)/C3);
C5 = log((spec.Isc*(1+C3)-spec.Imp)/(C3*spec.Isc));
m = log(C5/C6)/log(spec.Vmp/spec.Voc);
C4 = C6/(spec.Voc^m);

% Aplicando a rela��o
I = spec.Isc*(1-C3*(exp(C4*V^m)-1));

end