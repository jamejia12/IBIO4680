function [oImgs, gblDir] = loadImgs(data)
%Funcion que carga las imágenes en una celda de mxnxp, donde p es el número de imágenes.
%Inputs:
%data: 'full' si se va a evaluar en test, 'sub' si se va a usar la sub-base de bench_fast, 'val' si se va a usar validación.
%Outputs:
%oImgs: Imagenes originales guardadas en una matriz de mxnxp.
%gblDir: Directorio en el que se encuentran las imágenes a estudiar.


%Reconoce los folders que tienen info y guarda sus nombres en dataFolders.
if strcmp(data, 'full') == 1
    gblPath = fullfile(pwd, 'BSR', 'BSDS500', 'data', 'images', 'test');
    gblDir = dir(fullfile(gblPath, '*.jpg'));
elseif strcmp(data, 'sub') == 1
    gblPath = fullfile(pwd, 'BSR', 'bench_fast', 'data', 'images');
    gblDir = dir(fullfile(gblPath, '*.jpg'));
elseif strcmp(data, 'val') == 1
    gblPath = fullfile(pwd, 'BSR', 'BSDS500', 'data', 'images', 'val');
    gblDir = dir(fullfile(gblPath, '*.jpg'));
else
    disp('Error');
    return;
end


n = length(gblDir);
oImgs = cell(1, n);
for i = 1:n
    imgName = gblDir(i).name;
    oImgs{i} = imread(fullfile(gblPath, imgName));
end