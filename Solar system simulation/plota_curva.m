% Plota a curva tens�o-corrente do painel fotovolt�ico
function plota_curva(V, I)

global spec param;

% Plotagem da curva tens�o-corrente
figure();
plot(V,I,'linewidth',2);
title(sprintf('Curva tens�o-corrente do painel\nPmax: %.2f W, FF: %.2f, nmax: %.4f', param.Pmax, param.FF, param.nmax)); 
xlabel('Tens�o (V)'); ylabel('Corrente (A)');
grid on; hold on;
axis([0 (spec.Voc)*1.1 0 (spec.Isc)*1.1])

% Anota��o dos pontos de interesse
X = [0 spec.Vmp spec.Voc];
Y = [spec.Isc spec.Imp 0];
info_X = X';
info_Y = Y';
info = cellstr(strcat('(',num2str(info_X),', ',num2str(info_Y),')'));
dX = 0.025*spec.Voc; dY = 0.025*spec.Isc;
scatter(X,Y,'blue','filled');
text(X+dX, Y+dY, info);

end