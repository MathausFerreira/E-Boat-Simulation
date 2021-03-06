%% SIMULA��O DESENVOLVIDA NO PROJETO E-BOAT PARA EST�TICA E DIN�MCIA DA EMBARCA��O
% Respons�vel: Mathaus Ferreira da Silva -
% mathaus.silva@engenharia.ufjf.br
%%
% PARAMETROS IMPORTANTES
% CO  - Centro da Origem (center of origin)
% CG  - Centro de gravidade (Center of Gravity)
% CB  - Centro de Flutua��o (Center of buoyancy) - Din�mico
% CF  - Centro de Flutua��o (Center of flotation)- Est�tico � o centro da
% �rea do fundo do casco

clear all; close all; clc;
%% CONFIGURA��O
global Sim V_relative Sim_Plot Time ROV Torque SLC Dv_h Cv_h Dv_n Dv_l;        % Vari�veis Globais

global SAVE
SAVE.Fmax = [];
SAVE.Vmax = [];
SAVE.DvMax = [];
SAVE.Dv_nMax = [];
SAVE.Dv_lMax = [];

%COnfigura��o de Plot
Plot       = 0;         % 1 - Para plotar figuras durante a simula��o / 0 caso contr�rio.
Plot_Step  = 20;        % Tempo para plot din�mico
Salvar     = 1;        % 1 - Para salvar as figuras plotadas / 0 caso contr�rio

pesoPadrao = 80; %kg
Param  = [21*pesoPadrao, 500;
          10*pesoPadrao, 250;
           1*pesoPadrao,  0];

V_relat_vec = [-6;0;6]; %km/h
   

for p = 1:length(V_relat_vec)
    V_relative = [kmhToms(V_relat_vec(p)) 0 0]; % Velocidade da correnteza
    
    for h=1:length(Param(:,1))
        %%
        Dv_h = zeros(3,1);
        Cv_h = zeros(3,1);
        Dv_n = zeros(3,1);
        Dv_l = zeros(3,1);
        
        Initialisation;                 % Time and some variables
        PhysicalProperties2(Param(h,1),Param(h,2));             % Catamaran Physical Properties
        Calc_Controllers;               % Controladores de velocidade
        
        %% Auxiliar variables
        Aux = [];
        vel = Sp_poli(0,5,0,50,0,0,Sim.Ts*SLC.Freq,Time(end));
        
        %% Inicio da Simula��o
        ImgParam = parametrizacaoFigura;
        figLA = figure(ImgParam.figOpt{:});
        CALADO = LinhaDagua(1);                     % Plota a altura da linha d'agua no casco
        
        tic; % Inicia o timer da simula��o
        for i = 1:numel(Time)
            
            Sim.Vel(:,i) = [vel(i);0;0];
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
        %%
        SAVE.Fmax(end+1)    = max(Sim.F(1,:));
        SAVE.Vmax(end+1)    = max(Sim_Plot.u_v_r(1,:));
        SAVE.DvMax(end+1)   = max(-Dv_h(1,:));
        SAVE.Dv_nMax(end+1) = max(-Dv_n(1,:));
        SAVE.Dv_lMax(end+1) = max(-Dv_l(1,:));
        
        %% Stops and reads the stopwatch timer
        elapsedTime = toc;
        fprintf('Total simulation time = %0.4fs\n', elapsedTime);
        
        plotFinal(CALADO,Salvar);
        
        
    end
end
