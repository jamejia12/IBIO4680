function bound = boundOfSeg(segmentation, threshold)
%Funci�n que halla los contornos de una im�gen (la segmentaci�n).
%Si no se introduce threshold, el threshold se autoasigna a defecto de edge (funci�n Matlab).
%Inputs:
%segmentation: Segmentaci�n de segmentByClustering.
%threshold: Umbral de borde de Canny (0<t<1).
%Outputs:
%bound: Bordes de segmentation.

if nargin == 1
    bound = edge(segmentation, 'canny');
else
    bound = edge(segmentation, 'canny', threshold);
end

end