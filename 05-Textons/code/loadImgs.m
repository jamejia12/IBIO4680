function loadImgs
%Funcion que carga las imágenes en una matríz de 640x480xp, donde p es el número de imágenes.
%Outputs:
%oImgs: Imagenes originales guardadas en una matriz de 640x480xp.


%Reconoce los folders que tienen info y guarda sus nombres en dataFolders.
gblPath = fullfile(pwd, 'Data');
gblDir = dir(gblPath);
n = length(gblDir);
cont = 1;
dataFolders = [];
for i = 1:n
    names = gblDir(i).name;
    isData = strfind(names, 'T');
    if isempty(isData) == 0
        dataFolders{cont} = names;
        cont = cont +1;
    end
end

%Recorre los folders y va guardando sus imágenes.
numImgs = 40*25;
oImgs = zeros(480, 640, numImgs);
n = length(dataFolders);
pos = 1;
for i = 1:n
    dataPath = fullfile(gblPath, dataFolders{i});
    dataDir = dir(fullfile(dataPath, '*.jpg'));
    m = length(dataDir);
    for j = 1:m
        imgPath = fullfile(dataPath, dataDir(j).name);
        oImgs(:,:,pos) = double(imread(imgPath))/255;
        pos = pos+1;
    end
end
save('oImgs.mat', 'oImgs', '-v7.3');