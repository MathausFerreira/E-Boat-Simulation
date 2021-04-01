% C�lculo da energia di�ria m�dia produzida pelo pain�l, para cada m�s do ano
function Ed = geracao_solar(Tamed, Rsmed)
Ed = zeros(size(Tamed)); % Energia di�ria produzida pelo painel, para cada m�s do ano

ws = [100 90 90 90 80 80 80 90 90 90 100 100]; % �ngulo do nascimento do sol, em graus
ws = deg2rad(ws);
wi = -172.5:15:172.5; % �ngulo hor�rio na metade de cada per�odo de hora
wi = deg2rad(wi);
t=0.5:1:23.5; % Vetor de horas
erro = zeros(size(Tamed)); % Vetor de erros da convers�o dia/hora

for i=1:length(Tamed) % Loop que percorre cada m�s do ano
    Edh = zeros(size(t)); % Energia hor�ria produzida pelo painel, para cada m�s do ano
    a = 0.409 + 0.5016*sin(ws(i)-1.047);
    b = 0.6609 - 0.4767*sin(ws(i)-1.047);
    H = Rsmed(i)*1000; % Irradia��o solar global di�ria m�dia mensal em Wh/m^2.dia
    I = zeros(size(t)); % Irradia��o solar global hor�ria m�dia mensal
    for k=1:length(t)
        I(k) = (H*pi/24)*(a+b*cos(wi(k)))*(cos(wi(k))-cos(ws(i)))/(sin(ws(i))-ws(i)*cos(ws(i)));
        I(k) = max(I(k),0.0); % A irradia��o hor�ria n�o pode ser menor que zero
    end
    A = trapz(t,I); % Calcula a �rea abaixo da curva, deve ser pr�xima a H
    erro(i) = H - A;
    for j=1:length(I)
        caso = correcao(Tamed(i), I(j));
        % Considerando que o painel opera em m�xima pot�ncia
        Edh(j) = caso.Imp*caso.Vmp;
    end
    Ed(i) = sum(Edh);
    % Realiza a plotagem de um comparativo entre produ��o de energia e irradi�ncia
    if i == 1
        figure();
        plot(t,I,'y','linewidth',2); hold on;
        plot(t,Edh,'g','linewidth',2); legend('Irradi�ncia','Energia gerada');
        title(sprintf('Produ��o de energia e irradi�ncia por dia no m�s %d', i));
        xlabel('Hora do dia');
        grid on; hold on;
        axis([0 24 0 max(I)*1.2]);
        
        % Anota��o dos pontos de interesse
        scatter(t,I,'yellow','filled'); hold on; scatter(t,Edh,'green','filled');
        text(t(12),max(I)*1.05,strcat(num2str(max(I)),' W/m^2'));
        text(t(12),max(Edh)*1.5,strcat(num2str(max(Edh),'%.2f'),' Wh'));
    end
end

end