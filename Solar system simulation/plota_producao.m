% Plotagem da produção mensal de energia (kWh)
function plota_producao(Ed)
D = [31;28;31;30;31;30;31;31;30;31;30;31]; % Número de dias em cada mês
mes = [1:12]; % Número de meses
E = zeros(1,length(mes)); % Energia mensal acumulada
for i=1:length(D)
    E(i) = Ed(i)*D(i)/1000;
end
% Plotagem da produção mensal de energia
figure();
plot(mes,E,'r','linewidth',2);
title('Energia produzida por mês do ano'); 
xlabel('Mês do ano'); ylabel('Energia produzida (kWh)');
grid on; hold on;
axis([1 12 min(E)*0.95 max(E)*1.05]);

% Anotação dos pontos de interesse
info_Y = E';
info = cellstr(num2str(info_Y,'%.2f'));
scatter(mes,E,'red','filled');
text(mes+0.2, E, info);

end