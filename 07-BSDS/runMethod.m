function outPath = runMethod(featureSpace, clusteringMethod, kEnd, data)
%Funci�n que segmenta por clustering.
%Inputs:
%featureSpace: Canal en el que se quiere realizar la segmentaci�n.
%clusetringMethod: M�todo de clusterizaci�n que se quiere utilizar.
%kEnd: k Clusters m�ximo. Debe ser m�ltiplo de 5.
%data: 'full' si se va a evaluar en toda la base de datos, 'sub' si se va a usar la sub-base de bench_fast.
%Outputs:
%segs: Segmentaciones para todas las im�genes y distintos K-clusters.
%outPath: Ruta en la que se guardar�n segs.

[oImgs, gblDir] = loadImgs(data);        %Carga toda la base de datos.
n = length(oImgs);      %N�mero de im�genes de 'test' de la base de datos.

%Mira a qu� carpeta guardar (la carpeta debe ser creada antes de).
if strcmp(featureSpace, 'HSV') == 1 && strcmp(clusteringMethod, 'kmeans') == 1
    outPath = fullfile(pwd, 'HK');
    mkdir(outPath);
elseif strcmp(featureSpace, 'RGB+XY') == 1 && strcmp(clusteringMethod, 'kmeans') == 1
    outPath = fullfile(pwd, 'RXK');
    mkdir(outPath);
else
    outPath = pwd;
end

for i = 1:n         %Recorre im�genes.
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