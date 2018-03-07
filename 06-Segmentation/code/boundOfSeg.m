function bound = boundOfSeg(segmentation, threshold)
%Función que halla los contornos de una imágen (la segmentación).
%Si no se introduce threshold, el threshold se autoasigna a defecto de edge (función Matlab).
%Inputs:
%segmentation: Segmentación de segmentByClustering.
%threshold: Umbral de borde de Canny (0<t<1).
%Outputs:
%bound: Bordes de segmentation.

if nargin == 1
    bound = edge(segmentation, 'canny');
else
    bound = edge(segmentation, 'canny', threshold);
end

end