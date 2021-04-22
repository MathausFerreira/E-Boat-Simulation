%======================================================================
% This function computes the Coriolis Effects C(v)v acting on the ROV
%======================================================================
function [Results] = Coriolis_Effect_Cat()
global ROV Sim  V_relative;

% Parametros construtivos
m  = ROV.mass;
xg = ROV.CG(1);

% Parametros de massa adicionada
Xudot =  ROV.Xudot;
Yvdot =  ROV.Yvdot;
Yrdot =  ROV.Yrdot;
Nrdot =  ROV.Nrdot;

% --- Montagem da matriz de coriolis

u = Sim.Current_u_v_r(1) - V_relative(1);
v = Sim.Current_u_v_r(2) - V_relative(2);
r = Sim.Current_u_v_r(3) - V_relative(3);

% Matriz de Coriolis - Corpo rígido 7.13

CRB = [            0          0    -m*(xg*r + v);
                   0          0              m*u;
        m*(xg*r + v)       -m*u                0];

% Matriz de Coriolis - Massa Adicionada   6.51 --7.15
   
CA = [                  0              0          Yvdot*v+Yrdot*r;
                        0              0                 -Xudot*u;
         -Yvdot*v-Yrdot*r        Xudot*u                        0];

CV = CA + CRB; %Equação 7.9

% % Parte da Equação 8.1 -- Fossen   

Results = CV*[u;v;r];

end