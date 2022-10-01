%==========================================================================
% PARAMETROS DO MODELO DO VE�CULO
% Inicializa todos os par�metros f�sicos do ve�culo
function PhysicalProperties2()
% Global variable(s)
global ROV Sat Fmax Nmax;

% PARAMETROS A SEREM DEFINIDOS - Saturacao
MaxVelX   = 100; % Velocidade m�xima deve ser a maior poss�vel para a embarca��o 
MaxVelY   = 0;   % Barco n�o anda de lado
MaxVelAng = pi/10; %rad/s

WpRadius  = 5; % Raio do Waypoint para que o ve�culo assuma Wp alcan�ado

%%  Parametros construtivos
FM = 70  ;                 % 70N de For�a de cada motor
G  =  9.81 ;                % For�a da gravidade
N_motor =  4 ;              % N�mero de motores

%% Massas do ve�culo
% motor_mass  = 62.5; % cruise 10 XL
% casco_mass  = 2022.6;
% % extra_mass  = 500;
% % passageiros = 20*80;
% bateria     = 97;%36.5; % Power 48-5000
% N_baterias  = 0;
% sist_acionamaneto = 50;

% MASSA TOTAL
Massa_total  = 92.67;% N_motor*motor_mass + casco_mass + extra_mass + ...
                %passageiros + N_baterias*bateria + sist_acionamaneto;

%% Parametros relacionados a dimens�o do barco
Loa   =  2.3;              % Comprimento do casco (metros)
dcx   =  0.3;              % Distancia entre a popa e o CG
Bwl   =  0.201;            % Largura da linha d�gua [m] BOCA M�XIMA
L     =  dcx;              % DISTANCIA DO CG AO MOTOR (motor de popa)

ROV.mass = Massa_total;
ROV.Loa = Loa;
ROV.Bwl = Bwl;

%%
Gmin = 0.5;
Gp = 22/(0.33); %(Gmax/LwMax)
Gain = 0*Gp*(LinhaDagua(0));
%%
xg            = -.05;                           % DESLOCAMENTO DO CG EM X
Iz            = 21.7828;            % kg*m�

Fmax = FM*N_motor;          % For�a max�ma de propuls�o
Nmax = L*Fmax;              % Torque m�ximo de guinada

k1 = (Fmax)/(100);	% k1 Rela��o entre potencia 0 - 100% e for�a 0- Fmax

%% Vari�veis Hidrodin�micas

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