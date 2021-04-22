function plotFinal()

ImgParam = parametrizacaoFigura;

global TimeJ Sim_Plot Sim Dv_h Cv_h Dv_n Dv_l

%% VELOCIDADE
figVel = figure(ImgParam.figOpt1L{:});
% ax1    = subplot(311);
plot(TimeJ,Sim_Plot.u_v_r(1,:),'linewidth',2); grid on;
xlabel('Tempo (s)',ImgParam.Label{:});
ylabel('Velocidade (m/s)',ImgParam.Label{:});
legend('Velocidade Linear',ImgParam.Legend{:});
% 
% ax2 = subplot(312)
% plot(TimeJ,Sim_Plot.u_v_r(2,:),'linewidth',2); grid on;
% xlabel('Tempo (s)',ImgParam.Label{:},'linewidth',2);
% ylabel('Velocidade (m/s)',ImgParam.Label{:});
% 
% ax3 = subplot(313)
% plot(TimeJ,Sim_Plot.u_v_r(3,:),'linewidth',2); grid on;
% xlabel('Tempo (s)',ImgParam.Label{:},'linewidth',2);
% ylabel('Velocidade Angular (rad/s)',ImgParam.Label{:});
% 
% linkaxes([ax1 ax2 ax3],'x')

%% POSIÇÃO
figPos = figure(ImgParam.figOpt1L{:});
% ax1    = subplot(311);
plot(TimeJ,Sim_Plot.X_Y_psi(1,:),'linewidth',2); grid on;
xlabel('Tempo (s)',ImgParam.Label{:});
ylabel('Dist\^{a}ncia (m)',ImgParam.Label{:});
legend('Posi\c{c}\~{a}o',ImgParam.Legend{:});

% ax2 = subplot(312)
% plot(TimeJ,Sim_Plot.X_Y_psi(2,:),'linewidth',2); grid on;
% xlabel('Tempo (s)',ImgParam.Label{:},'linewidth',2);
% ylabel('Dist\^{a}ncia (m)',ImgParam.Label{:});
% 
% ax3 = subplot(313)
% plot(TimeJ,Sim_Plot.X_Y_psi(3,:),'linewidth',2); grid on;
% xlabel('Tempo (s)',ImgParam.Label{:},'linewidth',2);
% ylabel('Angulo (graus)',ImgParam.Label{:});
% 
% linkaxes([ax1 ax2 ax3],'xy')

%% FORÇA
figForca = figure(ImgParam.figOpt1L{:});
% ax1    = subplot(311);
plot(TimeJ,Sim.F(1,:),'linewidth',2); grid on;
xlabel('Tempo (s)',ImgParam.Label{:});
ylabel('Forca (N)',ImgParam.Label{:});
legend('Motores',ImgParam.Legend{:});
% title('Posi\c{c}\~{a}o',ImgParam.Label{:});

% ax2 = subplot(312)
% plot(TimeJ,Sim.F(2,:),'linewidth',2); grid on;
% xlabel('Tempo (s)',ImgParam.Label{:},'linewidth',2);
% ylabel('Forca (N)',ImgParam.Label{:});
% 
% ax3 = subplot(313)
% plot(TimeJ,Sim.F(3,:),'linewidth',2); grid on;
% xlabel('Tempo (s)',ImgParam.Label{:},'linewidth',2);
% ylabel('Forca',ImgParam.Label{:});

% linkaxes([ax1 ax2 ax3],'x')
%% HIDRODINAMICA
fighidro = figure(ImgParam.figOpt1L{:});
% ax1    = subplot(211);

Dv_h = Dv_h(:,2:end);
Dv_n = Dv_n(:,2:end);
Dv_l = Dv_l(:,2:end);
Cv_h = Cv_h(:,2:end);

plot(TimeJ,Dv_h(1,:),'--b','linewidth',2);hold on;grid on
plot(TimeJ,Dv_n(1,:),'-.m','linewidth',2);
plot(TimeJ,Dv_l(1,:),'-.r','linewidth',2);
xlabel('Tempo (s)',ImgParam.Label{:});
ylabel('Resistencia Hidrodinamica (kg.m/s)',ImgParam.Label{:});
legend('Amortecimento Hidrodinamico','Amortecimento N\~{a}o Linear',...
    'Amortecimento Linear',ImgParam.Legend{:})
% 

% 
% ax3    = subplot(313);
% plot(TimeJ,Dv_h(3,:),'--b','linewidth',2);hold on;grid on
% % plot(TimeJ,Cv_h(3,:),'-.m','linewidth',2);
% xlabel('Tempo (s)',ImgParam.Label{:},'linewidth',2);
% ylabel('Hidro z',ImgParam.Label{:});
% 
% linkaxes([ax1 ax2 ax3],'x')
end