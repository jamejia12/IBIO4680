function [segmentation, boundaries] = loadGT
%Funcion que carga las anotaciones en una matr�z de mxnxp, donde p es el n�mero de im�genes.
%Outputs:
%segmentation: Celda que contiene distintas segmentaciones para todas las im�genes.
%boundaries: Celda que contiene distintas segmentaciones para todas las im�genes.


%Reconoce los folders que tienen info y guarda sus nombres en dataFolders.
gblPath = fullfile(pwd, 'BSDS_tiny');
gblDir = dir(fullfile(gblPath, '*.mat'));
n = length(gblDir);
segmentation = cell(1, n);
boundaries = cell(1, n);
for i = 1:n         %Recorre las distintas im�genes.
    gtName = gblDir(i).name;
    gt = load(fullfile(gblPath, gtName));
    gt = gt.groundTruth;
    m = length(gt);
    tSeg = cell(1,m);
    tBound = cell(1,m);
    for j =1:m          %Recorre las distintas anotaciones de una misma imagen.
        tSeg{j} = gt{j}.Segmentation;
        tBound{j} = gt{j}.Boundaries;
    end
    segmentation{i} = tSeg;
    boundaries{i} = tBound;
end