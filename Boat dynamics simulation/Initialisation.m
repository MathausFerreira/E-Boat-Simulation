% Inicia todas as vari�veis relacionadas � simula��o em geral
function Initialisation()
global Sim Sim_Plot Time TimeJ SLC;             % Vari�veis Globais

SLC.Freq   = 20;        % No caso de implementa��o de controle - Malha de velocidade j� est� configurada para rodar 20 vezes mais r�pida que a malha de posi��o

TEMPO_Sim  = 100;       % Tempo total de simula��o
Ts         = 0.01;      % Tempo de amostragem para a simula��o

% Vetor de tempo de simula��o
Time  = Ts*SLC.Freq:Ts*SLC.Freq:TEMPO_Sim;  % Time Vector
TimeJ = Ts:Ts:TEMPO_Sim;                    % Auxiliar Time Vector

%% Inicializa��o da posi��o e velocidade
Current_X_Y_psi = [1e-10;1e-10;1e-10];      % Posi��o    [X, Y, Yaw]
Current_u_v_r   = zeros(3,1);               % Velocidade [Vx, Vy, Vyaw]

%% For�a e vetores para plot
Forcas_no_sistema = [];
X_Y_psi           = [];
u_v_w             = [];

F   = zeros(3,1);
PWM = ones(4,1);
Th  = zeros(4,1);

u_v_r_dot = zeros(3,1);

% PositionAndAttitude
Sim_Plot = struct('Forcas_no_sistema', Forcas_no_sistema,'X_Y_psi',X_Y_psi,'u_v_w',u_v_w);

Sim = struct('Current_X_Y_psi',Current_X_Y_psi,'Current_u_v_r', Current_u_v_r,...
    'u_v_r_dot',u_v_r_dot,'tFinal',TEMPO_Sim,'Ts', Ts,'F',F,'PWM',PWM,...
    'Theta',Th,'Vel',zeros(3,1));
end
