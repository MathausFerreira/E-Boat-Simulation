function Plot_general(j)
global Sim Sim_Plot
PlotBarco(j);

hold on
%% SEMPRE QUE PLOTAR POSIÇÃO - TROCAR X POR Y POR CONTA DO FRAME DO BARCO
plot(Sim_Plot.X_Y_psi(2,1:100:j),Sim_Plot.X_Y_psi(1,1:100:j),'.r','markersize',20);
axis equal
hold off
title(sprintf('Tempo: %.2f s FX: %.4f FY: %.4f TN: %.4f\nPosicao: X = %.2f m, Y = %.2f m, yaw = %.2f graus\nVelocidade: u = %.4f m/s, v = %.4f m/s, r = %.4f graus/s',...
    j*Sim.Ts,Sim.F(1,j),Sim.F(2,j) ,Sim.F(3,j), Sim.Current_X_Y_psi(1),Sim.Current_X_Y_psi(2),Sim.Current_X_Y_psi(3)*180/pi,Sim.Current_u_v_r(1),Sim.Current_u_v_r(2),Sim.Current_u_v_r(3)*180/pi));
drawnow

end