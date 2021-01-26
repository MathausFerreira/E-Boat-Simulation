% Inicia todas as variáveis relacionadas à simulação em geral
function Initialisation()
global Sim Sim_Plot Time TimeJ SLC;             % Variáveis Globais

SLC.Freq   = 20;        % No caso de implementação de controle - Malha de velocidade já está configurada para rodar 20 vezes mais rápida que a malha de posição

TEMPO_Sim  = 100;       % Tempo total de simulação
Ts         = 0.01;      % Tempo de amostragem para a simulação

% Vetor de tempo de simulação
Time  = Ts*SLC.Freq:Ts*SLC.Freq:TEMPO_Sim;  % Time Vector
TimeJ = Ts:Ts:TEMPO_Sim;                    % Auxiliar Time Vector

%% Inicialização da posição e velocidade
Current_X_Y_psi = [1e-10;1e-10;1e-10];      % Posição    [X, Y, Yaw]
Current_u_v_r   = zeros(3,1);               % Velocidade [Vx, Vy, Vyaw]

%% Força e vetores para plot
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
