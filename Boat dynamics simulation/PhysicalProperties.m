%==========================================================================
% PARAMETROS DO MODELO DO VEÍCULO
%==========================================================================
% Inicializa todos os parâmetros físicos do veículo
function PhysicalProperties
% Global variable(s)
global ROV APP Sat Fmax Nmax;

% PARAMETROS A SEREM DEFINIDOS - Saturacao
MaxVelX   = 3.05;
MaxVelY   = 1;
MaxVelAng = 2.32; %rad/s

WpRadius  = 5; % Raio do Waypoint para que o veículo assuma Wp alcançado

%%  Parametros construtivos
m   = 2800;                 % MASSA TOTAL
xg  = -0.05;                % DESLOCAMENTO DO CG EM X
Iz  = 2.9824 *15;           % MOMENTO DE INÉRCIA

FM = 500  ;                 % Força de cada motor
G =  9.81 ;                 % Força da gravidade
N =  2    ;                 % Número de motores

%% Parametros relacionados ao desenho (plot) do barco
Loa   =   8.;             % Comprimento do casco (metros)
dcx   =  Loa/3;            % Distancia entre a popa e o CG
Bw1   =  2.4;               % Largura da linha dágua [m] BOCA MÁXIMA

L   = dcx ;                  % DISTANCIA DO CG AO MOTOR

Fmax = FM*G*N;              % Força maxíma de propulsão
Nmax = L*Fmax;              % Torque máximo de guinada

k1 = (Fmax)/(100);          % k1 Representa a relação entre potencia 0 - 100% e força 0- Fmax

%% MODELO COMPLETO PARA UTILIZAÇÃO NA SIMULAÇÃO
Xudot = -1.0400 *15;
Xu    = -16.3292 *15;
Xuu   = -3.5313 *15;
Yvdot = -17.2552 *15;
Yv    = -0.0013 *15;
Yr    = 0;
Yvv   = -48.8006 *15;
Nrdot = -3.7020 *15;
Nv    = 0;
Nr    = -18.9686 *15;
Nrr   = -1.1958e-05 *15;
Yrdot = 0;
Yvr   = 0;
Nrv   = 0;
Nvv   = 0;
Nvr   = 0;

%% Momentos e produtos de Inércia
CG = [xg;0;0];

% Matriz de massa de corpo rígido   6.7 --- 7.12
IMrb = [ m       0       0; 
         0       m    m*xg; 
         0    m*xg      Iz];

% Matrix de massa adicionada    6.50 -- 7.14
IMra =  [ -Xudot    0         0; 
          0     -Yvdot    -Yrdot; 
          0     -Yrdot    -Nrdot]; 

%% Matriz de massa
IM = IMrb + IMra;                 % 6.48    7.8     

%% Constante de Tempo  -- PARA RESPOSTA DO MOTOR -- FUTURAMENTE
settling_time_mt  = 0.3;
settling_time_srv = 1.0; 

tau_mt  = settling_time_mt/5;    % Motors
tau_srv = settling_time_srv/5;   % Servos

Sat = struct('F_motor',Fmax,'torque', Nmax,'MaxVelX',MaxVelX,'MaxVelY',MaxVelY,'MaxVelAng',MaxVelAng);

ROV = struct('mass',m,'ICG',Iz,'InertiaMatrix',IM,'IMrb',IMrb,'IMra',IMra,...
    'InverseInertia',inv(IM),'Xudot',Xudot,'Yvdot',Yvdot,'Yrdot',Yrdot,...
    'Nrdot',Nrdot,'Xuu', Xuu,'Yvv',Yvv,'Yvr',Yvr,'Nrv',Nrv,'Nvv',Nvv,...
    'Nvr', Nvr, 'Nrr', Nrr,'Xu', Xu, 'Yv', Yv, 'Yr', Yr, 'Nv', Nv,...
    'Nr', Nr, 'dcx', dcx, 'CG', CG,...
    'Bw1',Bw1,'Loa',Loa,'k1',k1,'WpRadius',WpRadius);

APP = struct('tau_mt', tau_mt,'tau_srv',tau_srv);
end