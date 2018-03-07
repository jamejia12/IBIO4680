function [Jaccard] = runAll(featureSpace, clusteringMethod, numberOfClusters, distT, cannyT)
%Corre todo y da el índice de Jaccard para una configuración dada.
%Inputs:
%rgbImage: Matriz en RGB.
%featureSpace: Canal en el que se quiere realizar la segmentación.
%clustringMethod: Método de clusterización que se quiere utilizar.
%numberOfClusters: Número de clusters en los que se quiere dividir la imágen.
%distT: Umbral de distancia (0<threshold).
%cannyT: Umbral de detección de bordes de Canny (0<threshold).
%Outputs:
%Jaccard: Indice de Jaccard para toda la database.

oImgs = loadImgs;       %Carga las imágenes originales, lo guarda en celda.
[~, boundGT] = loadGT;              %Carga las anotaciones, las guarda en una celda.

n = length(oImgs);      %Número de imágenes de la database.
Jaccard = zeros(1,n);   %Inicializa índices de Jaccard para toda la base de datos.

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
    
    %Evalúa.
    Jaccard(i) = evalData(bound, uniGT, distT);
end