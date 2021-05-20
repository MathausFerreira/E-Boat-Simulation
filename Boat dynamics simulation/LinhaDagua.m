% Calcula o Calado Atual do Veículo
function CALADO = LinhaDagua(P)

Base = plotBarcoFrente(P);     % Plota o Barco e retorna o valor de referencia para o 0

CALADO = AlturaLinhaAgua  ;  % Calcula a altura da linha d'agua para o peso atual

aguaY = [(Base+CALADO) (Base+CALADO)]; %Não multiplicar por escala
% Esse é o referencial para as escalas
aguaX = [-2 2];     % Comprimento da linha d'água

%% Plot liha d'água
if P>0
    hold on
    V = plot(aguaX,aguaY,'linewidth', 5,'color', [.1 .1 .7]);
    legend(V,"Linha d'água")
    text(aguaX(1)+.1,aguaY(1)+.25,""+CALADO*100+" cm")
    grid on
    hold off
    drawnow
end
end

