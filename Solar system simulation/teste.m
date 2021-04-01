clear all; close all; clc
ws = 100; % �ngulo do nascimento do sol, em graus
ws = deg2rad(ws);
%wi = -180:15:165;
wi = -172.5:15:172.5; % �ngulo hor�rio na metade de cada per�odo de hora
wi = deg2rad(wi);
a = 0.409 + 0.5016*sin(ws-1.047);
b = 0.6609 - 0.4767*sin(ws-1.047);
H = 4360; % Irradia��o solar global di�ria m�dia mensal
I = zeros(size(wi)); % Irradia��o solar global hor�ria m�dia mensal
for i=1:length(wi)
    I(i) = (H*pi/24)*(a+b*cos(wi(i)))*(cos(wi(i))-cos(ws))/(sin(ws)-ws*cos(ws));
    I(i) = max(I(i),0.0); % A irradia��o hor�ria n�o pode ser menor que zero
end
t=0.5:1:23.5; % Vetor de horas
plot(t, I)
axis([0 24 0 max(I)*1.2])
A = trapz(t,I); % Calcula a �rea abaixo da curva, deve ser pr�xima a H
erro = H - A