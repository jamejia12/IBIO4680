function [Jaccard] = runAll(featureSpace, clusteringMethod, numberOfClusters, distT, cannyT)
%Corre todo y da el �ndice de Jaccard para una configuraci�n dada.
%Inputs:
%rgbImage: Matriz en RGB.
%featureSpace: Canal en el que se quiere realizar la segmentaci�n.
%clustringMethod: M�todo de clusterizaci�n que se quiere utilizar.
%numberOfClusters: N�mero de clusters en los que se quiere dividir la im�gen.
%distT: Umbral de distancia (0<threshold).
%cannyT: Umbral de detecci�n de bordes de Canny (0<threshold).
%Outputs:
%Jaccard: Indice de Jaccard para toda la database.

oImgs = loadImgs;       %Carga las im�genes originales, lo guarda en celda.
[~, boundGT] = loadGT;              %Carga las anotaciones, las guarda en una celda.

n = length(oImgs);      %N�mero de im�genes de la database.
Jaccard = zeros(1,n);   %Inicializa �ndices de Jaccard para toda la base de datos.

for i = 1:n
    %Segmenta.
    segmentation = segmentByClustering(oImgs{i}, featureSpace, clusteringMethod, numberOfClusters);
    
    %Halla bordes.
    if nargin == 4
        bound = boundOfSeg(segmentation);
    else
        bound = boundOfSeg(segmentation, cannyT);
    end
    
    %Carga anotaciones de bordes.
    uniGT = unifyGT (boundGT{i}, clusteringMethod);
    
    %Eval�a.
    Jaccard(i) = evalData(bound, uniGT, distT);
end