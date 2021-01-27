% Plota o barco e retorna o valor do ponto mínimo (fundo do barco)
function Base = plotBarcoFrente()

% Multiplicadores de proporção
lat = 2.4/12;
alt = 0.75/4;

% Superior
superiorX = [5 5 -5 -5].*lat;
superiorY = [1 5  5  1].*alt;

% Inferior
inferiorX = [6 6 -6 -6 ].*lat;
inferiorY = [-1 1 1 -1 ].*alt;

% Inferior 2
inferior2X = [6 -6 -3 3 ].*lat;
inferior2Y = [-1 -1 -3 -3].*alt;

fill(superiorX,superiorY,[.5 .5 .5]);
hold on 
fill(inferiorX,inferiorY,'red');
fill(inferior2X,inferior2Y,'red');
hold off

axis equal
Base   = min(inferior2Y);
end