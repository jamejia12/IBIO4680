function [Jaccard] = evalData(bound, uniGT, threshold)
%Funcion que evalua precisión y cobertura de bordes dada por parámetro.
%Inputs:
%bound: Boundaries hallados a partir de segmentaciones.
%uniGT: GT unificado para una imágen.
%threshold: Umbral de distancia (0<threshold).
%Outputs:
%Jaccard: Indice de Jaccard.

SE = strel('diamond', threshold);
dil = imdilate(uniGT, SE);     %Dilata como alternativa a métrica de distancia.

union = bound+uniGT;            %La unión son la suma de las originales.
union = mean(mean(union));

inter = bound.*dil;            %Interseca con la dilatada.
inter = mean(mean(inter));

Jaccard = inter/union;

end