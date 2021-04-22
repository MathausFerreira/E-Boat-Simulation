%==========================================================================
% PARAMETROS DO MODELO DO VEÍCULO
% Inicializa todos os parâmetros físicos do veículo
function PhysicalProperties2(passageiros,extra_mass,Gain)
% Global variable(s)
global ROV Sat Fmax Nmax;
min = 3;
% PARAMETROS A SEREM DEFINIDOS - Saturacao
MaxVelX   = 100; % Velocidade máxima deve ser a maior possível para a embarcação 
MaxVelY   = 0;   % Barco não anda de lado
MaxVelAng = pi/10; %rad/s

WpRadius  = 5; % Raio do Waypoint para que o veículo assuma Wp alcançado

%%  Parametros construtivos
FM = 5000  ;                % 5000N de Força de cada motor
G  =  9.81 ;                % Força da gravidade
N_motor =  2 ;              % Número de motores

%% Massas do veículo
motor_mass  = 62.5; % cruise 10 XL
casco_mass  = 2022.6;
% extra_mass  = 500;
% passageiros = 20*80;
bateria     = 36.5; % Power 48-5000
N_baterias  = 8;
sist_acionamaneto = 100;

% MASSA TOTAL
Massa_total  =  N_motor*motor_mass + casco_mass + extra_mass + ...
                passageiros + N_baterias*bateria + sist_acionamaneto;

%%
% Gain = 25;
xg            = -.05;                % DESLOCAMENTO DO CG EM X
Iz            = 2.9824 *(Gain+min);           % MOMENTO DE INÉRCIA

%% Parametros relacionados a dimensão do barco
Loa   =  10.;               % Comprimento do casco (metros)
dcx   =  Loa/3;             % Distancia entre a popa e o CG
Bw1   =  2.4;               % Largura da linha dágua [m] BOCA MÁXIMA
L     =  dcx;               % DISTANCIA DO CG AO MOTOR (motor de popa)

Fmax = FM*N_motor;          % Força maxíma de propulsão
Nmax = L*Fmax;              % Torque máximo de guinada

k1 = (Fmax)/(100);	% k1 Relação entre potencia 0 - 100% e força 0- Fmax

%% Variáveis Hidrodinâmicas

Xudot = -1.0400 *(Gain+min);
Xu    = -16.3292 *(Gain+min);
Xuu   = -3.5313 *(Gain+min);
Yvdot = -17.2552 *(Gain+min);
Yv    = -0.0013 *(Gain+min);
Yr    = 0;
Yvv   = -48.8006 *(Gain+min);
Nrdot = -3.7020 *(Gain+min);
Nv    = 0;
Nr    = -18.9686 *(Gain+min);
Nrr   = -1.1958e-05 *(Gain+min);
Yrdot = 0;
Yvr   = 0;
Nrv   = 0;
Nvv   = 0;
Nvr   = 0;

%% Momentos e produtos de Inércia
CG = [xg;0;0];

% Matriz de massa de corpo rígido   6.7 --- 7.12
IMrb = [ Massa_total       0       0; 
         0       Massa_total    Massa_total*xg; 
         0       Massa_total*xg      Iz];

% Matrix de massa adicionada    6.50 -- 7.14
IMra =  [ -Xudot    0         0; 
          0     -Yvdot    -Yrdot; 
          0     -Yrdot    -Nrdot]; 

%% Matriz de massa
IM = IMrb + IMra;                 % 6.48    7.8     

Sat = struct('F_motor',Fmax,'torque', Nmax,'MaxVelX',MaxVelX,'MaxVelY',...
            MaxVelY,'MaxVelAng',MaxVelAng);

ROV = struct('mass',Massa_total,'ICG',Iz,'InertiaMatrix',IM,'IMrb',IMrb,...
        'IMra',IMra,'InverseInertia',inv(IM),'Xudot',Xudot,'Yvdot',...
        Yvdot,'Yrdot',Yrdot,'Nrdot',Nrdot,'Xuu', Xuu,'Yvv',Yvv,'Yvr',Yvr,...
        'Nrv',Nrv,'Nvv',Nvv,'Nvr', Nvr, 'Nrr', Nrr,'Xu', Xu, 'Yv', Yv,...
        'Yr', Yr, 'Nv', Nv,'Nr', Nr, 'dcx', dcx, 'CG', CG,'Bw1',Bw1,...
        'Loa',Loa,'k1',k1,'WpRadius',WpRadius);

end

% %% Constante de Tempo  -- PARA RESPOSTA DO MOTOR -- FUTURAMENTE
% settling_time_mt  = 0.3;
% settling_time_srv = 1.0; 
% 
% tau_mt  = settling_time_mt/5;    % Motors
% tau_srv = settling_time_srv/5;   % Servos
% APP = struct('tau_mt', tau_mt,'tau_srv',tau_srv);