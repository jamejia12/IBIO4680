function oImgs = loadImgs
%Funcion que carga las imágenes en una celda de mxnxp, donde p es el número de imágenes.
%Outputs:
%oImgs: Imagenes originales guardadas en una matriz de mxnxp.


%Reconoce los folders que tienen info y guarda sus nombres en dataFolders.
gblPath = fullfile(pwd, 'BSDS_tiny');
gblDir = dir(fullfile(gblPath, '*.jpg'));
n = length(gblDir);
oImgs = cell(1, n);
for i = 1:n
    imgName = gblDir(i).name;
    oImgs{i} = imread(fullfile(gblPath, imgName));
end