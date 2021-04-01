clear all; close all; clc
ws = 100; % Ângulo do nascimento do sol, em graus
ws = deg2rad(ws);
%wi = -180:15:165;
wi = -172.5:15:172.5; % Ãngulo horário na metade de cada período de hora
wi = deg2rad(wi);
a = 0.409 + 0.5016*sin(ws-1.047);
b = 0.6609 - 0.4767*sin(ws-1.047);
H = 4360; % Irradiação solar global diária média mensal
I = zeros(size(wi)); % Irradiação solar global horária média mensal
for i=1:length(wi)
    I(i) = (H*pi/24)*(a+b*cos(wi(i)))*(cos(wi(i))-cos(ws))/(sin(ws)-ws*cos(ws));
    I(i) = max(I(i),0.0); % A irradiação horária não pode ser menor que zero
end
t=0.5:1:23.5; % Vetor de horas
plot(t, I)
axis([0 24 0 max(I)*1.2])
A = trapz(t,I); % Calcula a área abaixo da curva, deve ser próxima a H
erro = H - A