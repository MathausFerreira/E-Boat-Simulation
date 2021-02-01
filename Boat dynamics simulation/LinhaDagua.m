function LinhaDagua()

Base = plotBarcoFrente;     % Plota o Barco e retorna o valor de referencia para o 0

CALADO = AlturaLinhaAgua    % Calcula a altura da linha d'agua para o peso atual

aguaY = [(Base+CALADO) (Base+CALADO)]; %Não multiplicar por escala -> esse é o referencial para as escalas
aguaX = [-2 2];

hold on 
plot(aguaX,aguaY,'linewidth', 5,'color', [.1 .1 .7]);
grid on
hold off
drawnow

end

