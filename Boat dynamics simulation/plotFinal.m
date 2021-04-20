function plotFinal()

ImgParam = parametrizacaoFigura;

global TimeJ Sim_Plot Sim Dv_h Cv_h

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

%% FORÇA
figForca = figure(ImgParam.figOpt2L{:});
ax1    = subplot(311);
plot(TimeJ,Sim.F(1,:),'linewidth',2); grid on;
xlabel('Tempo (s)',ImgParam.Label{:},'linewidth',2);
ylabel('Forca (N)',ImgParam.Label{:});
% title('Posi\c{c}\~{a}o',ImgParam.Label{:});

ax2 = subplot(312)
plot(TimeJ,Sim.F(2,:),'linewidth',2); grid on;
xlabel('Tempo (s)',ImgParam.Label{:},'linewidth',2);
ylabel('Forca (N)',ImgParam.Label{:});

ax3 = subplot(313)
plot(TimeJ,Sim.F(3,:),'linewidth',2); grid on;
xlabel('Tempo (s)',ImgParam.Label{:},'linewidth',2);
ylabel('Forca',ImgParam.Label{:});

linkaxes([ax1 ax2 ax3],'x')
%% hidro
fighidro = figure(ImgParam.figOpt2L{:});
ax1    = subplot(311);
Dv_h = Dv_h(:,1:end-1);
Cv_h = Cv_h(:,1:end-1);
plot(TimeJ,Dv_h(1,:),'--b','linewidth',2);hold on
plot(TimeJ,Cv_h(1,:),'-.m','linewidth',2);
xlabel('Tempo (s)',ImgParam.Label{:},'linewidth',2);
ylabel('HIdro X',ImgParam.Label{:});

ax2    = subplot(312);
plot(TimeJ,Dv_h(2,:),'--b','linewidth',2);hold on
plot(TimeJ,Cv_h(2,:),'-.m','linewidth',2);
xlabel('Tempo (s)',ImgParam.Label{:},'linewidth',2);
ylabel('Hidro Y',ImgParam.Label{:});

ax3    = subplot(313);
plot(TimeJ,Dv_h(3,:),'--b','linewidth',2);hold on
plot(TimeJ,Cv_h(3,:),'-.m','linewidth',2);
xlabel('Tempo (s)',ImgParam.Label{:},'linewidth',2);
ylabel('Hidro z',ImgParam.Label{:});

linkaxes([ax1 ax2 ax3],'x')
end