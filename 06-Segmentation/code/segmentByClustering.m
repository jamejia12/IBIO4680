function segmentation = segmentByClustering(rgbImage, featureSpace, clusteringMethod, numberOfClusters)
%Función que segmenta por clustering.
%Inputs:
%rgbImage: Matriz en RGB.
%featureSpace: Canal en el que se quiere realizar la segmentación.
%clustringMethod: Método de clusterización que se quiere utilizar.
%numberOfClusters: Número de clusters en los que se quiere dividir la imágen.

dImg = featChange(rgbImage, featureSpace);
segmentation = useCluster(rgbImage, dImg, clusteringMethod, numberOfClusters);

end