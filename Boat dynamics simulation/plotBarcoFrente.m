% Plota o barco e retorna o valor do ponto mínimo (fundo do barco)
function Base = plotBarcoFrente()

% Multiplicadores de proporção
lat = 2.4/12;
alt = 0.75/4;

% Superior top
superiorX = [1.5 1.5 -1.5 -1.5].*lat;
superiorY = [4 7  7  4].*alt;

% Superior 
superiorX1 = [4 4 -4 -4].*lat;
superiorY1 = [1 4  4  1].*alt;

% Inferior
inferiorX = [6  6 0 -6 -6 0].*lat;
inferiorY = [-1 1 3  1 -1 1].*alt;

% Inferior 2
inferior2X = [6 0 -6 -3 3 ].*lat;
inferior2Y = [-1 1 -1 -3 -3].*alt;

fill(superiorX1,superiorY1,[92/255 88/255 88/255]);
hold on 
fill(inferior2X,inferior2Y,[0 84/255 255/255]);
fill(superiorX,superiorY,[63/255 58/255 58/255]);
plot(superiorX1,superiorY1,'color','red','linewidth',5)
fill(inferiorX,inferiorY,'red');

hold off

axis equal
Base   = min(inferior2Y);
end