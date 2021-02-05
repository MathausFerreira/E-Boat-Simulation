% C�lculo da energia di�ria m�dia produzida pelo pain�l, para cada m�s do ano
function Ed = geracao_solar(Tamed, Rsmed)
% Loop que percorre cada m�s do ano
Ed = zeros(1,length(Tamed)); % Energia di�ria produzida pelo painel para cada m�s do ano (Wh/dia)
for i=1:length(Tamed)
    Isd = Rsmed(i)*1000/12; % C�lculo da irradi�ncia solar m�dia hor�ria (W/m^2)
    % Equacionamento da quadr�tica que aproxima o comportamento da irradi�ncia ao longo do dia
    B = [0; 0; Isd];
    A = [36 6 1; 324 18 1; 156 12 1];
    x = inv(A)*B;
    % C�lculo da energia produzida por hora do dia
    t = [6:1:18]; % Intervalo de horas do dia com luz solar
    Gth = zeros(1,length(t)); % Irradi�ncia por hora do dia
    Edh = zeros(1,length(t)); % Produ��o de energia por hora do dia
    for j=1:length(Gth)
        Gth(j) = x(1)*t(j)^2 + x(2)*t(j) + x(3);
        caso = correcao(Tamed(i), Gth(j));
        % Considerando que o painel opera em m�xima pot�ncia
        Edh(j) = caso.Imp*caso.Vmp;
    end
    Ed(i) = sum(Edh);
    % Realiza a plotagem de um comparativo entre produ��o de energia e irradi�ncia
    if i == 1
        figure();
        plot(t,Gth,'y','linewidth',2); hold on;
        plot(t,Edh,'g','linewidth',2); legend('Irradi�ncia','Energia gerada');
        title(sprintf('Produ��o de energia e irradi�ncia por dia no m�s %d', i));
        xlabel('Hora do dia');
        grid on; hold on;
        axis([0 24 0 Gth(7)*1.1]);
        
        % Anota��o dos pontos de interesse
        scatter(t,Gth,'yellow','filled'); hold on; scatter(t,Edh,'green','filled');
        text(t(7),Gth(7)*1.05,strcat(num2str(Gth(7)),' W/m^2'));
        text(t(7),Edh(7)*1.5,strcat(num2str(Edh(7),'%.2f'),' Wh'));
    end
end

end