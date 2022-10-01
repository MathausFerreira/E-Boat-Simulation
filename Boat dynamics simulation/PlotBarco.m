%% 
% Função para plotar o Barco em tamanho real 2D
% x   = Posição x do veículo no referencial Global
% y   = Posição y do veículo no referencial Global
% z   = Posição z do veículo no referencial Global
% yaw = Angulo de yaw do veículo no referencial fixo do corpo
%%
function [] = PlotBarco() 
global ROV Sim Sim_Plot;

yaw = Sim.Current_X_Y_psi(3);       % Guinada atual do veículo

M_rotacao = NED2BF(yaw,eye(3));     % Matriz de Rotação (Rotação em Z)

Bcl = ROV.Bwl;                      % Bcl = largura do casco (maior que a linha dagua)

%% Estrutura externa 
yd = [(Bcl/2)    , (Bcl/2)   , 0           , (-Bcl/2)  , (-Bcl/2)   ,  (+Bcl/2)];
xd = [-ROV.Loa/2 , ROV.Loa/2 ,(ROV.Loa/2+2), ROV.Loa/2 , -ROV.Loa/2 ,  -ROV.Loa/2 ];
zd = zeros(1,length(yd));

% Aplica a Rotação ajustando a posição ao centro do desenho
XY = M_rotacao * [xd;yd;zd];

figure(2)
%% SEMPRE QUE PLOTAR POSIÇÃO - TROCAR X POR Y POR CONTA DO FRAME DO BARCO
fill(Sim.Current_X_Y_psi(1) + XY(1,:), Sim.Current_X_Y_psi(2) + XY(2,:),[0.5 0.5 1],'linewidth',1); % Barco
hold on 
plot(Sim_Plot.X_Y_psi(1,1:20:end),Sim_Plot.X_Y_psi(2,1:20:end),'.b')
Zoom = 20;
axis([(Sim.Current_X_Y_psi(1)-Zoom) (Sim.Current_X_Y_psi(1)+Zoom)...
      (Sim.Current_X_Y_psi(2)-Zoom) (Sim.Current_X_Y_psi(2)+Zoom)])
grid on
hold off



end