% Cálculo da energia diária média produzida pelo painél, para cada mês do ano
function Ed = geracao_solar(Tamed, Rsmed)
% Loop que percorre cada mês do ano
Ed = zeros(1,length(Tamed)); % Energia diária produzida pelo painel para cada mês do ano (Wh/dia)
for i=1:length(Tamed)
    Isd = Rsmed(i)*1000/12; % Cálculo da irradiância solar média horária (W/m^2)
    % Equacionamento da quadrática que aproxima o comportamento da irradiância ao longo do dia
    B = [0; 0; Isd];
    A = [36 6 1; 324 18 1; 156 12 1];
    x = inv(A)*B;
    % Cálculo da energia produzida por hora do dia
    t = [6:1:18]; % Intervalo de horas do dia com luz solar
    Gth = zeros(1,length(t)); % Irradiância por hora do dia
    Edh = zeros(1,length(t)); % Produção de energia por hora do dia
    for j=1:length(Gth)
        Gth(j) = x(1)*t(j)^2 + x(2)*t(j) + x(3);
        caso = correcao(Tamed(i), Gth(j));
        % Considerando que o painel opera em máxima potência
        Edh(j) = caso.Imp*caso.Vmp;
    end
    Ed(i) = sum(Edh);
    % Realiza a plotagem de um comparativo entre produção de energia e irradiância
    if i == 1
        figure();
        plot(t,Gth,'y','linewidth',2); hold on;
        plot(t,Edh,'g','linewidth',2); legend('Irradiância','Energia gerada');
        title(sprintf('Produção de energia e irradiância por dia no mês %d', i));
        xlabel('Hora do dia');
        grid on; hold on;
        axis([0 24 0 Gth(7)*1.1]);
        
        % Anotação dos pontos de interesse
        scatter(t,Gth,'yellow','filled'); hold on; scatter(t,Edh,'green','filled');
        text(t(7),Gth(7)*1.05,strcat(num2str(Gth(7)),' W/m^2'));
        text(t(7),Edh(7)*1.5,strcat(num2str(Edh(7),'%.2f'),' Wh'));
    end
end

end