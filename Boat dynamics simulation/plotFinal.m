function plotFinal()

ImgParam = parametrizacaoFigura;

global TimeJ Sim_Plot

%% VELOCIDADE
figVel = figure(ImgParam.figOpt2L{:});
ax1    = subplot(311);
plot(TimeJ,Sim_Plot.u_v_r(1,:),'linewidth',2); grid on;
xlabel('Tempo (s)',ImgParam.Label{:},'linewidth',2);
ylabel('Velocidade (m/s)',ImgParam.Label{:});
title('Velocidades',ImgParam.Label{:});

ax2 = subplot(312)
plot(TimeJ,Sim_Plot.u_v_r(2,:),'linewidth',2); grid on;
xlabel('Tempo (s)',ImgParam.Label{:},'linewidth',2);
ylabel('Velocidade (m/s)',ImgParam.Label{:});

ax3 = subplot(313)
plot(TimeJ,Sim_Plot.u_v_r(3,:),'linewidth',2); grid on;
xlabel('Tempo (s)',ImgParam.Label{:},'linewidth',2);
ylabel('Velocidade Angular (rad/s)',ImgParam.Label{:});

linkaxes([ax1 ax2 ax3],'x')

%% POSIÇÃO
figPos = figure(ImgParam.figOpt2L{:});
ax1    = subplot(311);
plot(TimeJ,Sim_Plot.X_Y_psi(1,:),'linewidth',2); grid on;
xlabel('Tempo (s)',ImgParam.Label{:},'linewidth',2);
ylabel('Dist\^{a}ncia (m)',ImgParam.Label{:});
title('Posi\c{c}\~{a}o',ImgParam.Label{:});

ax2 = subplot(312)
plot(TimeJ,Sim_Plot.X_Y_psi(2,:),'linewidth',2); grid on;
xlabel('Tempo (s)',ImgParam.Label{:},'linewidth',2);
ylabel('Dist\^{a}ncia (m)',ImgParam.Label{:});

ax3 = subplot(313)
plot(TimeJ,Sim_Plot.X_Y_psi(3,:),'linewidth',2); grid on;
xlabel('Tempo (s)',ImgParam.Label{:},'linewidth',2);
ylabel('Angulo (graus)',ImgParam.Label{:});

linkaxes([ax1 ax2 ax3],'xy')



end