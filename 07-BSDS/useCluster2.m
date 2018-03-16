function segmentation = useCluster2(rgbImage, dImg, numberOfClusters, maxIter, centroids)
%Clusteriza img por el m�todo y n�mero de clusters dados por par�metro.
%Inputs:
%rgbImage: Imagen original (input en featChange).
%dImg: Representaci�n vectorial de la imagen original (output de featChange).
%numberOfClusters: N�mero de clusters a usar.
%maxIter: N�mero m�ximo de iteraciones que se van a considerar para la convergencia de k-means.
%centroids: 'cluster' o 'plus'.
%Outputs:
%segmentation: Segmentaci�n obtenida (en forma matricial).

segmentation = kmeans(dImg, numberOfClusters, 'MaxIter', maxIter, 'Start', centroids);

%Devuelve segmentacion en forma matricial (si los par�metros de entrada son correctos).

[mO, nO, ~] = size(rgbImage);
nL = size(dImg, 2);
if nL<4
    segmentation = reshape(segmentation, [mO, nO]);
else
    segmentation = reshape(segmentation(1:(mO*nO)), [mO, nO]);
end

end