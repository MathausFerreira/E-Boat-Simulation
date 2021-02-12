%% Força de boyance para o peso do barco
function Z = AlturaLinhaAgua() % TAMBÉM CONHECIDO COMO CALADO
global ROV

rho = 997; % Densidade da agua em m3
G   = 9.8; % Aceleração da gravidade

PesoBarco = ROV.mass*G; %

Aw0 = ROV.Bw1*ROV.Loa*G*rho/1.5;  % Constante 1.5 é escolhida para a
                                  % aproximação do casco do veículo 

% Z seria a altura da aguá (deve ser encontrada para o equilíbrio)

Z = PesoBarco/(Aw0);
end