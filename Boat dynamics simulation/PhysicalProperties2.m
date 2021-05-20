%==========================================================================
% PARAMETROS DO MODELO DO VEÍCULO
% Inicializa todos os parâmetros físicos do veículo
function PhysicalProperties2(passageiros,extra_mass)
% Global variable(s)
global ROV Sat Fmax Nmax;

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

%% Parametros relacionados a dimensão do barco
Loa   =  10.;               % Comprimento do casco (metros)
dcx   =  Loa/3;             % Distancia entre a popa e o CG
Bwl   =  2.4;               % Largura da linha dágua [m] BOCA MÁXIMA
L     =  dcx;               % DISTANCIA DO CG AO MOTOR (motor de popa)

ROV.mass = Massa_total;
ROV.Loa = Loa;
ROV.Bwl = Bwl;

%%
Gmin = 3;
Gp = 22/(0.33); %(Gmax/LwMax)
Gain = Gp*(LinhaDagua(0));
%%
xg            = -.05;                % DESLOCAMENTO DO CG EM X
Iz            = 2.9824 *(Gain+Gmin);           % MOMENTO DE INÉRCIA

Fmax = FM*N_motor;          % Força maxíma de propulsão
Nmax = L*Fmax;              % Torque máximo de guinada

k1 = (Fmax)/(100);	% k1 Relação entre potencia 0 - 100% e força 0- Fmax

%% Variáveis Hidrodinâmicas

Xudot = -1.0400 *(Gain+Gmin);
Xu    = -16.3292 *(Gain+Gmin);
Xuu   = -3.5313 *(Gain+Gmin);
Yvdot = -17.2552 *(Gain+Gmin);
Yv    = -0.0013 *(Gain+Gmin);
Yr    = 0;
Yvv   = -48.8006 *(Gain+Gmin);
Nrdot = -3.7020 *(Gain+Gmin);
Nv    = 0;
Nr    = -18.9686 *(Gain+Gmin);
Nrr   = -1.1958e-05 *(Gain+Gmin);
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
        'Yr', Yr, 'Nv', Nv,'Nr', Nr, 'dcx', dcx, 'CG', CG,'Bwl',Bwl,...
        'Loa',Loa,'k1',k1,'WpRadius',WpRadius);

end

% %% Constante de Tempo  -- PARA RESPOSTA DO MOTOR -- FUTURAMENTE
% settling_time_mt  = 0.3;
% settling_time_srv = 1.0; 
% 
% tau_mt  = settling_time_mt/5;    % Motors
% tau_srv = settling_time_srv/5;   % Servos
% APP = struct('tau_mt', tau_mt,'tau_srv',tau_srv);