%% Força de boyance para o peso do barco

function Z = AlturaLinhaAgua() % TAMBÉM CONHECIDA COMO CALADO

rho = 997; % Densidade da agua em m3
G   = 9.8;
global ROV

PesoBarco = ROV.mass*G;

Aw0 = ROV.Bw1*ROV.Loa*G*rho/1.5;  % Z seria a altura da aguá  (deve ser encontrada para o equilíbrio)

Z = PesoBarco/(Aw0);
end