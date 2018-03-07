function segmentation = segmentByClustering(rgbImage, featureSpace, clusteringMethod, numberOfClusters)
%Funci�n que segmenta por clustering.
%Inputs:
%rgbImage: Matriz en RGB.
%featureSpace: Canal en el que se quiere realizar la segmentaci�n.
%clustringMethod: M�todo de clusterizaci�n que se quiere utilizar.
%numberOfClusters: N�mero de clusters en los que se quiere dividir la im�gen.

dImg = featChange(rgbImage, featureSpace);
segmentation = useCluster(rgbImage, dImg, clusteringMethod, numberOfClusters);

end