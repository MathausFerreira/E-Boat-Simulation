% PARAMETROS IMPORTANTES
% CO  - Centro da Origem (center of origin)
% CG  - Centro de gravidade (Center of Gravity)
% CB  - Centro de Flutuação (Center of buoyancy) - Dinâmico
% CF  - Centro de Flutuação (Center of flotation)- Estático é o centro da
% área do fundo do casco

%% SIMULAÇÃO DESENVOLVIDA NO PROJETO E-BOAT PARA ESTÁTICA E DINÂMCIA DA EMBARCAÇÃO
% Responsável: Mathaus Ferreira da Silva -
% mathaus.silva@engenharia.ufjf.br
%%

clear all; close all; clc;
%% CONFIGURAÇÃO 
global Sim Sim_Plot Time ROV Torque SLC;        % Variáveis Globais

%COnfiguração de Plot
Plot       = 0;         % 1 - Para plotar figuras durante a simulação / 0 caso contrário.
Plot_Step  = 20;        % Tempo para plot dinâmico
Salvar     = 01;        % 1 - Para salvar as figuras plotadas / 0 caso contrário

%%
Initialisation;                 % Time and some variables
PhysicalProperties;             % Catamaran Physical Properties
Calc_Controllers;               % Controlador de velocidade

%% Auxiliar variables
Aux = [];

%% Inicio da Simulação
figure(1)
LinhaDagua;                     % Plota a altura da linha d'agua no casco

tic;                            % Inicia o timer da simulação
for i = 1:numel(Time)
    
     Sim.Vel(:,i) = [50;0;0];
 
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


