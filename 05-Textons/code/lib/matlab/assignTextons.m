function [map] = assignTextons(fim,textons)
% function [map] = assignTextons(fim,textons)

d = numel(fim);         %Mira el número de respuestas a filtros.
n = numel(fim{1});      %Mira las dimensiones de la respuesta a un filtro.
data = zeros(d,n);      %Inicializa data
for i = 1:d,
  data(i,:) = fim{i}(:)';       %Manda a la fila 1 la info de la i-esima respuesta al filtro.
end

d2 = distSqr(data,textons);     %Mira distancia entre data y textones (centroides anteriormente hallados).
[y,map] = min(d2,[],2);         %En map guarda el índice del mínimo de d2 por fila (filasx1).
[w,h] = size(fim{1});
map = reshape(map,w,h);         %Pasa
