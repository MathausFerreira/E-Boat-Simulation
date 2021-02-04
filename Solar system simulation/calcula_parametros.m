% C�lcula par�metros de interesse
function calcula_parametros()

global spec amb param;

% Pot�ncia m�xima
Pmax = spec.Imp*spec.Vmp;
% Fator de forma (ideal > 0.7)
FF = Pmax/(spec.Isc*spec.Voc);
% Efici�ncia m�xima
A = spec.dim.C*spec.dim.L*10^-6;
nmax = Pmax/(A*amb.Gt); %(Nota: a efici�ncia geralmente � relatada para condi��es de ambiente padr�es)

% Montagem da estrutura contendo os par�metros
param = struct('Pmax',Pmax,'FF',FF,'nmax',nmax);

end