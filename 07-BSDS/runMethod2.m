function outPath = runMethod2(featureSpace, kEnd, redMethod, redLvl, maxIter, centroids, data)
%Función que segmenta por clustering.
%Inputs:
%featureSpace: Canal en el que se quiere realizar la segmentación.
%kEnd: k Clusters máximo. Debe ser múltiplo de 5.
%redMethod: Método de reducción ('G' para gaussiana o 'I' para interpolación cúbica).
%redLvl: Nivel de reducción al que se quiere pasar (1 baja uno, 2 dos y así sucesivamente).
%maxIter: Número máximo de iteraciones que se van a considerar para la convergencia de k-means.
%centroids: 'cluster' o 'plus'.
%data: 'full' si se va a evaluar en test, 'sub' si se va a usar la sub-base de bench_fast, 'val' si se va a usar validación.
%Outputs:
%segs: Segmentaciones para todas las imágenes y distintos K-clusters.
%outPath: Ruta en la que se guardarán segs.

[oImgs, gblDir] = loadImgs(data);        %Carga toda la base de datos.
n = length(oImgs);      %Número de imágenes de 'test' de la base de datos.

%Mira a qué carpeta guardar (la carpeta debe ser creada antes de).
if strcmp(featureSpace, 'HSV')
    outPath = fullfile(pwd, strcat('HK', '_', centroids, '_', redMethod, '_', num2str(redLvl)));
    mkdir(outPath);
elseif strcmp(featureSpace, 'RGB+XY')
    outPath = fullfile(pwd, strcat('RXK', '_', centroids, '_', redMethod, '_', num2str(redLvl)));
    mkdir(outPath);
else
    outPath = pwd;
end

for i = 1:n         %Recorre imágenes.
    %Aplica reducción Gaussiana.
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