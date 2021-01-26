%% 
% Fun��o para plotar o Barco em tamanho real 2D
% x   = Posi��o x do ve�culo no referencial Global
% y   = Posi��o y do ve�culo no referencial Global
% z   = Posi��o z do ve�culo no referencial Global
% yaw = Angulo de yaw do ve�culo no referencial fixo do corpo
%%

function [] = PlotBarco() 
global ROV Sim;

yaw = Sim.Current_X_Y_psi(3);       % Guinada atual do ve�culo

M_rotacao = NED2BF(yaw,eye(3));     % Matriz de Rota��o (Rota��o em Z)

Bcl = ROV.Bw1;                      % Bcl = largura do casco (maior que a linha dagua)

%% Estrutura externa 
yd = [(Bcl/2)    , (Bcl/2)   , 0           , (-Bcl/2)  , (-Bcl/2)   ,  (+Bcl/2)];
xd = [-ROV.Loa/2 , ROV.Loa/2 ,(ROV.Loa/2+2), ROV.Loa/2 , -ROV.Loa/2 ,  -ROV.Loa/2 ];
zd = zeros(1,length(yd));

% Aplica a Rota��o ajustando a posi��o ao centro do desenho
XY = M_rotacao * [xd;yd;zd];

%% SEMPRE QUE PLOTAR POSI��O - TROCAR X POR Y POR CONTA DO FRAME DO BARCO
fill(Sim.Current_X_Y_psi(1) + XY(1,:), Sim.Current_X_Y_psi(2) + XY(2,:),[0.5 0.5 1],'linewidth',1); % Barco

grid on 

Zoom = 20;
axis([(Sim.Current_X_Y_psi(1)-Zoom) (Sim.Current_X_Y_psi(1)+Zoom)...
      (Sim.Current_X_Y_psi(2)-Zoom) (Sim.Current_X_Y_psi(2)+Zoom)])

end