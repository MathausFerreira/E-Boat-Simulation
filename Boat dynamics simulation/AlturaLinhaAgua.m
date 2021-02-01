%% For�a de boyance para o peso do barco

function Z = AlturaLinhaAgua() % TAMB�M CONHECIDA COMO CALADO
global ROV

rho = 997; % Densidade da agua em m3
G   = 9.8; % Acelera��o da gravidade

PesoBarco = ROV.mass*G;

Aw0 = ROV.Bw1*ROV.Loa*G*rho/1.5;  % Z seria a altura da agu� (deve ser encontrada para o equil�brio)
                                  % a Constante 1.5 � escolhida para a
                                  % aproxima��o do casco do ve�culo 
Z = PesoBarco/(Aw0);
end