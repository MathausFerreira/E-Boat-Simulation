%==========================================================================
% PARAMETROS DO MODELO DO VE�CULO
%==========================================================================
% Inicializa todos os par�metros f�sicos do ve�culo
function PhysicalProperties
% Global variable(s)
global ROV APP Sat Fmax Nmax;

% PARAMETROS A SEREM DEFINIDOS - Saturacao
MaxVelX   = 35;
MaxVelY   = 0;
MaxVelAng = pi/10; %rad/s

WpRadius  = 5; % Raio do Waypoint para que o ve�culo assuma Wp alcan�ado

%%  Parametros construtivos

FM = 500  ;                 % For�a de cada motor
G =  9.81 ;                 % For�a da gravidade
N =  2    ;                 % N�mero de motores

%% Massas do ve�culo
motor_mass  = 100;
casco_mass  = 2000;
extra_mass  = 500;
passageiros = 20*80;
bateria     = 50;
N_baterias  = 5;
sist_aciona = 100;
% MASSA TOTAL
Massa_total   =  N*motor_mass + casco_mass + extra_mass + passageiros + ...
    N_baterias*bateria + sist_aciona 

%%
xg            = -0.05;                % DESLOCAMENTO DO CG EM X
Iz            = 2.9824 *15;           % MOMENTO DE IN�RCIA

%% Parametros relacionados a dimens�o do barco
Loa   =  10.;               % Comprimento do casco (metros)
dcx   =  Loa/3;             % Distancia entre a popa e o CG
Bw1   =  2.4;               % Largura da linha d�gua [m] BOCA M�XIMA
L     = dcx ;               % DISTANCIA DO CG AO MOTOR (motor de popa)

Fmax = FM*N;              % For�a max�ma de propuls�o
Nmax = L*Fmax;              % Torque m�ximo de guinada

k1 = (Fmax)/(100);          % k1 Representa a rela��o entre potencia 0 - 100% e for�a 0- Fmax

%% MODELO COMPLETO PARA UTILIZA��O NA SIMULA��O
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

%% Momentos e produtos de In�rcia
CG = [xg;0;0];

% Matriz de massa de corpo r�gido   6.7 --- 7.12
IMrb = [ Massa_total       0       0; 
         0       Massa_total    Massa_total*xg; 
         0       Massa_total*xg      Iz];

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

ROV = struct('mass',Massa_total,'ICG',Iz,'InertiaMatrix',IM,'IMrb',IMrb,'IMra',IMra,...
    'InverseInertia',inv(IM),'Xudot',Xudot,'Yvdot',Yvdot,'Yrdot',Yrdot,...
    'Nrdot',Nrdot,'Xuu', Xuu,'Yvv',Yvv,'Yvr',Yvr,'Nrv',Nrv,'Nvv',Nvv,...
    'Nvr', Nvr, 'Nrr', Nrr,'Xu', Xu, 'Yv', Yv, 'Yr', Yr, 'Nv', Nv,...
    'Nr', Nr, 'dcx', dcx, 'CG', CG,...
    'Bw1',Bw1,'Loa',Loa,'k1',k1,'WpRadius',WpRadius);

APP = struct('tau_mt', tau_mt,'tau_srv',tau_srv);
end