%% SIMULAÇÃO DESENVOLVIDA NO PROJETO E-BOAT PARA ESTÁTICA E DINÂMCIA DA EMBARCAÇÃO
% Responsável: Mathaus Ferreira da Silva -
% mathaus.silva@engenharia.ufjf.br
%%
% PARAMETROS IMPORTANTES
% CO  - Centro da Origem (center of origin)
% CG  - Centro de gravidade (Center of Gravity)
% CB  - Centro de Flutuação (Center of buoyancy) - Dinâmico
% CF  - Centro de Flutuação (Center of flotation)- Estático é o centro da
% área do fundo do casco

clear all; close all; clc;
%% CONFIGURAÇÃO
global Sim V_relative Sim_Plot Time ROV Torque SLC Dv_h Cv_h Dv_n Dv_l;        % Variáveis Globais

%COnfiguração de Plot
Plot       = 0;         % 1 - Para plotar figuras durante a simulação / 0 caso contrário.
Plot_Step  = 20;        % Tempo para plot dinâmico
Salvar     = 01;        % 1 - Para salvar as figuras plotadas / 0 caso contrário

padrao = [80  0  15/20]
Param = [1*padrao;
    10*padrao;
    20*padrao+[0 0 0]]

% Param = [80 0 15;
%     10*80 0 15;
%     20*80 0 15]
V_relative = [-0 0 0]; % Velocidade da correnteza

for h=1:length(Param(:,1))
    %%
    Dv_h = zeros(3,1);
    Cv_h = zeros(3,1);
    Dv_n = zeros(3,1);
    Dv_l = zeros(3,1);
    
    Initialisation;                 % Time and some variables
    PhysicalProperties2(Param(h,1),Param(h,2),Param(h,3));             % Catamaran Physical Properties
    Calc_Controllers;               % Controladores de velocidade
    
    %% Auxiliar variables
    Aux = [];
    
    %% Inicio da Simulação
    ImgParam = parametrizacaoFigura;
    figLA = figure(ImgParam.figOpt{:});
    CALADO = LinhaDagua;                     % Plota a altura da linha d'agua no casco
    
    tic;
    vc=0;% Inicia o timer da simulação
    for i = 1:numel(Time)
        
        Sim.Vel(:,i) = [vc;0;0];
        vc =vc+50;
        for j = (SLC.Freq*(i-1)+1):SLC.Freq*(i)
            %% Controlador de Velocidade
            Speed_Controller(i,j);
            
            %% Computes the net forces and moments acting on the ROV
            ROVLoads(j);
            
            n_dot = BF2NED(Sim.Current_X_Y_psi(3),Sim.Current_u_v_r);
            v_dot = ROV.InverseInertia * (Torque - Sim.NetForces);
            %% Double integration: accelerations -> velocities -> position/attitude
            X                = [n_dot; v_dot];             % State vector
            [AuxVector, Aux] = Integration(X,Aux,j);
            
            Sim.u_v_r_dot(:,j+1) = v_dot;         % utilizada no controle de Velocidade
            Sim.Current_X_Y_psi  = AuxVector(1:3);% + sqrt(R_gps)*randn(size(AuxVector(1:3)));
            Sim.Current_u_v_r    = AuxVector(4:6);% + sqrt(R_gps)*randn(size(AuxVector(1:3)));
            
            %% Armazena para PLOT
            Sim_Plot.u_v_r(:,j)   = Sim.Current_u_v_r;
            Sim_Plot.X_Y_psi(:,j) = Sim.Current_X_Y_psi;
            
        end
        % Plot online Figure
        if(mod(i,Plot_Step)==0 && Plot==1)
            PlotBarco();
            pause(1)
        end
        
    end
    %% Stops and reads the stopwatch timer
    elapsedTime = toc;
    fprintf('Total simulation time = %0.4fs\n', elapsedTime);
    
    plotFinal;
    
    
    if Salvar
        saveas(figLA,strcat(strcat('LinhaDagua30cm',CALADO),'.png'))
    end
end

