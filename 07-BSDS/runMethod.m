function outPath = runMethod(featureSpace, clusteringMethod, kEnd, data)
%Función que segmenta por clustering.
%Inputs:
%featureSpace: Canal en el que se quiere realizar la segmentación.
%clusetringMethod: Método de clusterización que se quiere utilizar.
%kEnd: k Clusters máximo. Debe ser múltiplo de 5.
%data: 'full' si se va a evaluar en toda la base de datos, 'sub' si se va a usar la sub-base de bench_fast.
%Outputs:
%segs: Segmentaciones para todas las imágenes y distintos K-clusters.
%outPath: Ruta en la que se guardarán segs.

[oImgs, gblDir] = loadImgs(data);        %Carga toda la base de datos.
n = length(oImgs);      %Número de imágenes de 'test' de la base de datos.

%Mira a qué carpeta guardar (la carpeta debe ser creada antes de).
if strcmp(featureSpace, 'HSV') == 1 && strcmp(clusteringMethod, 'kmeans') == 1
    outPath = fullfile(pwd, 'HK');
    mkdir(outPath);
elseif strcmp(featureSpace, 'RGB+XY') == 1 && strcmp(clusteringMethod, 'kmeans') == 1
    outPath = fullfile(pwd, 'RXK');
    mkdir(outPath);
else
    outPath = pwd;
end

for i = 1:n         %Recorre imágenes.
    aImg = oImgs{i};
    dImg = featChange(aImg, featureSpace);
    segs = cell(1,kEnd/5);
    pos = 1;
    for k = 5:5:kEnd     %Recorre para diferentes k-clusters.
        if k == 0
            segs{pos} = useCluster(aImg, dImg, clusteringMethod, 1);
            pos = pos+1;
        else
            segs{pos} = useCluster(aImg, dImg, clusteringMethod, k);
            pos = pos+1;
        end
    end
    imgName = gblDir(i).name;
    imgName = strsplit(imgName, '.');
    imgName = imgName{1};
    segName = strcat(imgName, '.mat');
    save(fullfile(outPath, segName), 'segs', '-v7.3');
end

end