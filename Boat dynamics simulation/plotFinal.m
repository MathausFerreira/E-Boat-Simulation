function plotFinal(CALADO,Salvar)

ImgParam = parametrizacaoFigura;

global TimeJ Sim_Plot Sim Dv_h Cv_h Dv_n Dv_l ROV V_relative

% % % %% POSIÇÃO
% % % figPos = figure(ImgParam.figOpt1L{:});
% % % % ax1    = subplot(311);
% % % plot(TimeJ,Sim_Plot.X_Y_psi(1,:),'linewidth',2); grid on;
% % % xlabel('Tempo (s)',ImgParam.Label{:});
% % % ylabel('Dist\^{a}ncia (m)',ImgParam.Label{:});
% % % legend('Posi\c{c}\~{a}o',ImgParam.Legend{:});
% % % 
% % % % ax2 = subplot(312)
% % % % plot(TimeJ,Sim_Plot.X_Y_psi(2,:),'linewidth',2); grid on;
% % % % xlabel('Tempo (s)',ImgParam.Label{:},'linewidth',2);
% % % % ylabel('Dist\^{a}ncia (m)',ImgParam.Label{:});
% % % %
% % % % ax3 = subplot(313)
% % % % plot(TimeJ,Sim_Plot.X_Y_psi(3,:),'linewidth',2); grid on;
% % % % xlabel('Tempo (s)',ImgParam.Label{:},'linewidth',2);
% % % % ylabel('Angulo (graus)',ImgParam.Label{:});
% % % %
% % % % linkaxes([ax1 ax2 ax3],'xy')
% % % 
% % % %% VELOCIDADE
% % % figVel = figure(ImgParam.figOpt1L{:});
% % % % ax1    = subplot(311);
% % % plot(TimeJ,Sim_Plot.u_v_r(1,:),'linewidth',2); grid on;
% % % xlabel('Tempo (s)',ImgParam.Label{:});
% % % ylabel('Velocidade (m/s)',ImgParam.Label{:});
% % % legend('Velocidade Linear',ImgParam.Legend{:});
% % % %
% % % % ax2 = subplot(312)
% % % % plot(TimeJ,Sim_Plot.u_v_r(2,:),'linewidth',2); grid on;
% % % % xlabel('Tempo (s)',ImgParam.Label{:},'linewidth',2);
% % % % ylabel('Velocidade (m/s)',ImgParam.Label{:});
% % % %
% % % % ax3 = subplot(313)
% % % % plot(TimeJ,Sim_Plot.u_v_r(3,:),'linewidth',2); grid on;
% % % % xlabel('Tempo (s)',ImgParam.Label{:},'linewidth',2);
% % % % ylabel('Velocidade Angular (rad/s)',ImgParam.Label{:});
% % % %
% % % % linkaxes([ax1 ax2 ax3],'x')
% % % 
% % % %% FORÇA
% % % figForca = figure(ImgParam.figOpt1L{:});
% % % % ax1    = subplot(311);
% % % plot(TimeJ,Sim.F(1,:),'linewidth',2); grid on;
% % % xlabel('Tempo (s)',ImgParam.Label{:});
% % % ylabel('Forca (N)',ImgParam.Label{:});
% % % legend('Motores',ImgParam.Legend{:});
% % % % title('Posi\c{c}\~{a}o',ImgParam.Label{:});
% % % 
% % % % ax2 = subplot(312)
% % % % plot(TimeJ,Sim.F(2,:),'linewidth',2); grid on;
% % % % xlabel('Tempo (s)',ImgParam.Label{:},'linewidth',2);
% % % % ylabel('Forca (N)',ImgParam.Label{:});
% % % %
% % % % ax3 = subplot(313)
% % % % plot(TimeJ,Sim.F(3,:),'linewidth',2); grid on;
% % % % xlabel('Tempo (s)',ImgParam.Label{:},'linewidth',2);
% % % % ylabel('Forca',ImgParam.Label{:});
% % % 
% % % % linkaxes([ax1 ax2 ax3],'x')
% % % %% HIDRODINAMICA
% % % fighidro = figure(ImgParam.figOpt1L{:});
% % % % ax1    = subplot(211);
% % % 
% % % Dv_h = Dv_h(:,2:end);
% % % Dv_n = Dv_n(:,2:end);
% % % Dv_l = Dv_l(:,2:end);
% % % Cv_h = Cv_h(:,2:end);
% % % 
% % % plot(TimeJ,Dv_h(1,:),'--b','linewidth',2);hold on;grid on
% % % plot(TimeJ,Dv_n(1,:),'-.m','linewidth',2);
% % % plot(TimeJ,Dv_l(1,:),'-.r','linewidth',2);
% % % xlabel('Tempo (s)',ImgParam.Label{:});
% % % ylabel('Resistencia Hidrodinamica (kg.m/s)',ImgParam.Label{:});
% % % legend('Amortecimento Hidrodinamico','Amortecimento N\~{a}o Linear',...
% % %     'Amortecimento Linear',ImgParam.Legend{:})
% % % 
% % % % ax3    = subplot(313);
% % % % plot(TimeJ,Dv_h(3,:),'--b','linewidth',2);hold on;grid on
% % % % % plot(TimeJ,Cv_h(3,:),'-.m','linewidth',2);
% % % % xlabel('Tempo (s)',ImgParam.Label{:},'linewidth',2);
% % % % ylabel('Hidro z',ImgParam.Label{:});
% % % %
% % % % linkaxes([ax1 ax2 ax3],'x')
%% TODAS
figALL = figure(ImgParam.figOpt3L{:});
ax1 =subplot(311);
plot(TimeJ,Sim_Plot.u_v_r(1,:),'linewidth',2); grid on;
xlabel('Tempo (s)',ImgParam.Label{:});
ylabel('Velocidade (m/s)',ImgParam.Label{:});
legend('Velocidade X',ImgParam.Legend{:});

ax2 =subplot(312);
plot(TimeJ,Sim.F(1,:),'linewidth',2); grid on;
xlabel('Tempo (s)',ImgParam.Label{:});
ylabel('Forca (N)',ImgParam.Label{:});
legend('Motores',ImgParam.Legend{:});

ax3 =subplot(313);
Dv_h = Dv_h(:,2:end);
Dv_n = Dv_n(:,2:end);
Dv_l = Dv_l(:,2:end);
Cv_h = Cv_h(:,2:end);

plot(TimeJ,Dv_h(1,:),'-b','linewidth',2);hold on;grid on
plot(TimeJ,Dv_n(1,:),'-.m','linewidth',2);
plot(TimeJ,Dv_l(1,:),'-.r','linewidth',2);
xlabel('Tempo (s)',ImgParam.Label{:});
ylabel('Amortecimento (kg.m/s)',ImgParam.Label{:});
legend('Total','N\~{a}o Linear',...
    'Linear',ImgParam.Legend{:},'Location','best','NumColumns',3)

linkaxes([ax1 ax2 ax3],'x');

if Salvar
    ax1 = strcat('Figs/Vrelat_',string(V_relative(1)));
    ax2 = strcat(ax1,'_Calado_');
    ax3 = strcat(ax2,string(CALADO));
    ax4 = strcat(ax3,'_carga_');
    ax5 = strcat(ax4,string(ROV.mass));
    ax6 = strcat(ax5,'_Dist_');
    ax7 = strcat(ax6,string(Sim_Plot.X_Y_psi(1,end)));
    
    saveas(figALL,strcat(strcat(ax7,'_ALL'),'.png'))
    %     saveas(figVel,strcat(strcat(ax7,'_Vel'),'.png'))
    %     saveas(figForca,strcat(strcat(ax7,'_Force'),'.png'))
    %     saveas(fighidro,strcat(strcat(ax7,'_hidro'),'.png'))
end

end