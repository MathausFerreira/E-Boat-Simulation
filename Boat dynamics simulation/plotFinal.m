function plotFinal(CALADO,Salvar)

ImgParam = parametrizacaoFigura;

global TimeJ Sim_Plot Sim Dv_h Cv_h Dv_n Dv_l ROV V_relative Time

% % % %% POSI��O
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
% % % %% FOR�A
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
plot(TimeJ,msTokmh(Sim_Plot.u_v_r(1,:)),'linewidth',2); grid on;hold on
plot(Time,msTokmh(Sim.Vel(1,:)),'r','linewidth',2);
xlabel('Tempo (s)',ImgParam.Label{:});
ylabel('Velocidade (km/h)',ImgParam.Label{:});
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
% %% COMPARATIVO
% 
% % lege ={"CC Plena Carga","CC M\'{e}dia Carga","CC A vazio",...
% %         "SC Plena Carga","SC M\'{e}dia Carga","SC A vazio",...
% %         "FC Plena Carga","FC M\'{e}dia Carga","FC A vazio"};
% %     
% lege = {"-10km/h","0km/h","10km/h"};
%     
% ang=10;
% FIGCOMP = figure(ImgParam.figOpt3L{:});
% ax1 =subplot(311);
% plot(SAVE.Fmax,'-o','linewidth',2,'MarkerSize',5); grid on;
% ylabel('For\c{c}a(N)',ImgParam.Label{:});
% set(gca,ImgParam.Tlabel{:})
% % set(gca,'XTickLabel',lege);
% xticks(ax1,[1 2 3])
% xticklabels(ax1,lege)
% xtickangle(ang)
% ylim([0 10000])
% % set(gca,'XTickLabel',lege,'TickLabelInterpreter ','latex')
% 
% ax2 =subplot(312);
% plot(msTokmh(SAVE.Vmax),'-o','linewidth',2,'MarkerSize',5); grid on;
% % xlabel('Simula\c{c}\~{a}o',ImgParam.Label{:});
% ylabel('Velocidade (km/h)',ImgParam.Label{:});
% set(gca,ImgParam.Tlabel{:})
% % set(gca,'XTickLabel',lege);
% xticks(ax2,[1 2 3])
% xticklabels(ax2,lege)
% xtickangle(ang)
% xtickangle(ang)
% 
% ax3 =subplot(313);
% plot(SAVE.DvMax,'-ob','linewidth',2,'MarkerSize',5); grid on;hold on;
% plot(SAVE.Dv_nMax,'-om','linewidth',2,'MarkerSize',5);
% plot(SAVE.Dv_lMax,'-or','linewidth',2,'MarkerSize',5);
% % xlabel('Simula\c{c}\~{a}o',ImgParam.Label{:});
% ylabel('Amortecimento (kg.m/s)',ImgParam.Label{:});
% set(gca,ImgParam.Tlabel{:})
% % set(gca,'XTickLabel',lege);
% xticks(ax3,[1 2 3])
% xticklabels(ax3,lege)
% xtickangle(ang)
% xtickangle(ang)

%% SAVE
if Salvar
    ax1 = strcat('FigsN/Vrelat_',string(V_relative(1)));
    ax2 = strcat(ax1,'_Calado_');
    ax3 = strcat(ax2,string(CALADO));
    ax4 = strcat(ax3,'_carga_');
    ax5 = strcat(ax4,string(ROV.mass));
    ax6 = strcat(ax5,'_Dist_');
    ax7 = strcat(ax6,string(Sim_Plot.X_Y_psi(1,end)));
    
    saveas(figALL,strcat(strcat(ax7,'_ALL'),'.png'))
    saveas(FIGCOMP,strcat('FigsN/Comparativo','.png'))
    %     saveas(figVel,strcat(strcat(ax7,'_Vel'),'.png'))
    %     saveas(figForca,strcat(strcat(ax7,'_Force'),'.png'))
    %     saveas(fighidro,strcat(strcat(ax7,'_hidro'),'.png'))
end

end