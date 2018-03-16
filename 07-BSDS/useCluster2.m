function segmentation = useCluster2(rgbImage, dImg, numberOfClusters, maxIter, centroids)
%Clusteriza img por el método y número de clusters dados por parámetro.
%Inputs:
%rgbImage: Imagen original (input en featChange).
%dImg: Representación vectorial de la imagen original (output de featChange).
%numberOfClusters: Número de clusters a usar.
%maxIter: Número máximo de iteraciones que se van a considerar para la convergencia de k-means.
%centroids: 'cluster' o 'plus'.
%Outputs:
%segmentation: Segmentación obtenida (en forma matricial).

segmentation = kmeans(dImg, numberOfClusters, 'MaxIter', maxIter, 'Start', centroids);

%Devuelve segmentacion en forma matricial (si los parámetros de entrada son correctos).

[mO, nO, ~] = size(rgbImage);
nL = size(dImg, 2);
if nL<4
    segmentation = reshape(segmentation, [mO, nO]);
else
    segmentation = reshape(segmentation(1:(mO*nO)), [mO, nO]);
end

end