function [Jaccard] = evalData(bound, uniGT, threshold)
%Funcion que evalua precisi�n y cobertura de bordes dada por par�metro.
%Inputs:
%bound: Boundaries hallados a partir de segmentaciones.
%uniGT: GT unificado para una im�gen.
%threshold: Umbral de distancia (0<threshold).
%Outputs:
%Jaccard: Indice de Jaccard.

SE = strel('diamond', threshold);
dil = imdilate(uniGT, SE);     %Dilata como alternativa a m�trica de distancia.

union = bound+uniGT;            %La uni�n son la suma de las originales.
union = mean(mean(union));

inter = bound.*dil;            %Interseca con la dilatada.
inter = mean(mean(inter));

Jaccard = inter/union;

end