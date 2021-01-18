clear all; close all; clc;
%% Configuration
global Sim Sim_Plot Time ROV Torque SLC;

% Plot Configuration
Plot       = 01;         % 1 - Plot online Figures or      0 - False
Plot_Step  = 20;         % Step to dynamic plot
Salvar     = 01;         % 1 - Save Data to Plot Figure or 0 - False

%% Initialisation
Initialisation;                 % Time and some variables
PhysicalProperties;             % Catamaran Physical Properties
Calc_Controllers;               % Control gain Project

%% Auxiliar variables
 Aux = [];

%% Start Simulation
tic;                % Starts the stopwatch timer and iterative simulation

%% SP DE ENTRADA

for i = 1:numel(Time)
     Sim.Vel(:,i) = [10;0;0];
 
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
        
        spd(:,j) = BF2NED(Sim.Current_X_Y_psi(3),[Sim.Vel(1,i);0;0]);
        ayp(:,j) = BF2NED(Sim.Current_X_Y_psi(3),[0;2*Sim.Vel(2,i);0]);
    end
    % Plot online Figure
    if(mod(i,Plot_Step)==0 && Plot==1)
        Plot_general(j);
        pause(1)
    end
    
end

%% Stops and reads the stopwatch timer
elapsedTime = toc;
fprintf('Total simulation time = %0.4fs\n', elapsedTime);
