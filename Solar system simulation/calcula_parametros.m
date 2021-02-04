% Cálcula parâmetros de interesse
function calcula_parametros()

global spec amb param;

% Potência máxima
Pmax = spec.Imp*spec.Vmp;
% Fator de forma (ideal > 0.7)
FF = Pmax/(spec.Isc*spec.Voc);
% Eficiência máxima
A = spec.dim.C*spec.dim.L*10^-6;
nmax = Pmax/(A*amb.Gt); %(Nota: a eficiência geralmente é relatada para condições de ambiente padrões)

% Montagem da estrutura contendo os parâmetros
param = struct('Pmax',Pmax,'FF',FF,'nmax',nmax);

end