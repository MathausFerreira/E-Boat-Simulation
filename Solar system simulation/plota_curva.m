% Plotagem da curva tensão-corrente do painel fotovoltáico
function plota_curva(V, I, caso)
% Variáveis globais
global spec;

% Parâmetros calculados
Pmax = caso.Imp*caso.Vmp; % Potência máxima
FF = Pmax/(caso.Isc*caso.Voc); % Fator de forma (ideal > 0.7)
A = spec.dim.C*spec.dim.L*10^-6; % Área do painel em m^2
nmax = Pmax/(A*caso.Gt); % Eficiência máxima

% Plotagem da curva tensão-corrente
figure();
plot(V,I,'linewidth',2);
title(sprintf('Curva tensão-corrente do painel\nPmax: %.2f W, FF: %.2f, nmax: %.4f', Pmax, FF, nmax)); 
xlabel('Tensão (V)'); ylabel('Corrente (A)');
grid on; hold on;
axis([0 (caso.Voc)*1.1 0 (caso.Isc)*1.1]);

% Anotação dos pontos de interesse
X = [0 caso.Vmp caso.Voc];
Y = [caso.Isc caso.Imp 0];
info_X = X';
info_Y = Y';
info = cellstr(strcat('(',num2str(info_X),', ',num2str(info_Y),')'));
dX = 0.025*caso.Voc; dY = 0.025*caso.Isc;
scatter(X,Y,'blue','filled');
text(X+dX, Y+dY, info);

end