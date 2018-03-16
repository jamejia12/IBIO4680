function outPath = runMethod2(featureSpace, kEnd, redMethod, redLvl, maxIter, centroids, data)
%Funci�n que segmenta por clustering.
%Inputs:
%featureSpace: Canal en el que se quiere realizar la segmentaci�n.
%kEnd: k Clusters m�ximo. Debe ser m�ltiplo de 5.
%redMethod: M�todo de reducci�n ('G' para gaussiana o 'I' para interpolaci�n c�bica).
%redLvl: Nivel de reducci�n al que se quiere pasar (1 baja uno, 2 dos y as� sucesivamente).
%maxIter: N�mero m�ximo de iteraciones que se van a considerar para la convergencia de k-means.
%centroids: 'cluster' o 'plus'.
%data: 'full' si se va a evaluar en test, 'sub' si se va a usar la sub-base de bench_fast, 'val' si se va a usar validaci�n.
%Outputs:
%segs: Segmentaciones para todas las im�genes y distintos K-clusters.
%outPath: Ruta en la que se guardar�n segs.

[oImgs, gblDir] = loadImgs(data);        %Carga toda la base de datos.
n = length(oImgs);      %N�mero de im�genes de 'test' de la base de datos.

%Mira a qu� carpeta guardar (la carpeta debe ser creada antes de).
if strcmp(featureSpace, 'HSV')
    outPath = fullfile(pwd, strcat('HK', '_', centroids, '_', redMethod, '_', num2str(redLvl)));
    mkdir(outPath);
elseif strcmp(featureSpace, 'RGB+XY')
    outPath = fullfile(pwd, strcat('RXK', '_', centroids, '_', redMethod, '_', num2str(redLvl)));
    mkdir(outPath);
else
    outPath = pwd;
end

for i = 1:n         %Recorre im�genes.
    %Aplica reducci�n Gaussiana.
    aImg = oImgs{i};
    [rows, cols, ~] = size(aImg);
    
    for j = 1:redLvl
        if strcmp(redMethod, 'G') == 1
            aImg = impyramid(aImg, 'reduce');
        elseif strcmp(redMethod, 'I') == 1
            aImg = imresize(aImg, 0.5);
        end
    end
    
    dImg = featChange(aImg, featureSpace);
    segs = cell(1,kEnd/5);
    pos = 1;
    for k = 5:5:kEnd     %Recorre para diferentes k-clusters.
        temp = useCluster2(aImg, dImg, k, maxIter, centroids);
        temp = imresize(temp, [rows, cols], 'nearest');
        segs{pos} = temp;
        pos = pos+1;
    end
    
    imgName = gblDir(i).name;
    imgName = strsplit(imgName, '.');
    imgName = imgName{1};
    segName = strcat(imgName, '.mat');
    save(fullfile(outPath, segName), 'segs', '-v7.3');
end

end