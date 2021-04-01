% Cálculo da energia diária média produzida pelo painél, para cada mês do ano
function Ed = geracao_solar(Tamed, Rsmed)
Ed = zeros(size(Tamed)); % Energia diária produzida pelo painel, para cada mês do ano

ws = [100 90 90 90 80 80 80 90 90 90 100 100]; % Ângulo do nascimento do sol, em graus
ws = deg2rad(ws);
wi = -172.5:15:172.5; % Ãngulo horário na metade de cada período de hora
wi = deg2rad(wi);
t=0.5:1:23.5; % Vetor de horas
erro = zeros(size(Tamed)); % Vetor de erros da conversão dia/hora

for i=1:length(Tamed) % Loop que percorre cada mês do ano
    Edh = zeros(size(t)); % Energia horária produzida pelo painel, para cada mês do ano
    a = 0.409 + 0.5016*sin(ws(i)-1.047);
    b = 0.6609 - 0.4767*sin(ws(i)-1.047);
    H = Rsmed(i)*1000; % Irradiação solar global diária média mensal em Wh/m^2.dia
    I = zeros(size(t)); % Irradiação solar global horária média mensal
    for k=1:length(t)
        I(k) = (H*pi/24)*(a+b*cos(wi(k)))*(cos(wi(k))-cos(ws(i)))/(sin(ws(i))-ws(i)*cos(ws(i)));
        I(k) = max(I(k),0.0); % A irradiação horária não pode ser menor que zero
    end
    A = trapz(t,I); % Calcula a área abaixo da curva, deve ser próxima a H
    erro(i) = H - A;
    for j=1:length(I)
        caso = correcao(Tamed(i), I(j));
        % Considerando que o painel opera em máxima potência
        Edh(j) = caso.Imp*caso.Vmp;
    end
    Ed(i) = sum(Edh);
    % Realiza a plotagem de um comparativo entre produção de energia e irradiância
    if i == 1
        figure();
        plot(t,I,'y','linewidth',2); hold on;
        plot(t,Edh,'g','linewidth',2); legend('Irradiância','Energia gerada');
        title(sprintf('Produção de energia e irradiância por dia no mês %d', i));
        xlabel('Hora do dia');
        grid on; hold on;
        axis([0 24 0 max(I)*1.2]);
        
        % Anotação dos pontos de interesse
        scatter(t,I,'yellow','filled'); hold on; scatter(t,Edh,'green','filled');
        text(t(12),max(I)*1.05,strcat(num2str(max(I)),' W/m^2'));
        text(t(12),max(Edh)*1.5,strcat(num2str(max(Edh),'%.2f'),' Wh'));
    end
end

end