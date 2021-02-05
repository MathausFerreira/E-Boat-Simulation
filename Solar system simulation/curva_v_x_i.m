% Obten��o dos valores da curva tens�o-corrente do painel fotovolt�ico
function [V,I] = curva_v_x_i(caso)
% Descri��o da curva (SALAMEH, 1995)
C3 = 0.01175;
C6 = log((1+C3)/C3);
C5 = log((caso.Isc*(1+C3)-caso.Imp)/(C3*caso.Isc));
m = log(C5/C6)/log(caso.Vmp/caso.Voc);
C4 = C6/(caso.Voc^m);

% Inicializa��o dos vetores de tens�es e correntes
V = [0:.0001:caso.Voc];
I = zeros(1,length(V));
for i=1:length(I)
    % Aplica a rela��o tens�o-corrente do painel fotovolt�ico
    I(i) = caso.Isc*(1-C3*(exp(C4*V(i)^m)-1));
end

end