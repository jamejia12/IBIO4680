function GaussPyramid(oImgs)
%Funcion que genera una pirámide Gaussiana de 7 niveles (sigma de 0.5 y ventana de 3 pixeles).
%Inputs:
%oImgs: Imagenes originales. Debe ser pasada en (mxnxp), donde p es el número de imagenes. Lo que se pasa es el nombre del archivo.
%Outputs:
%pImgs: Pirámide Gaussiana. Es de 1xp donde p. Al interior de cada entrada están los 7 niveles de la pirámide Gaussiana.
a = load(oImgs);
oImgs = a.oImgs;
[m, n, p] = size(oImgs);
pImgs = cell(1,p);
for i = 1:p
    pImgs{1,i} = downsampling2(oImgs(:,:,i), 7);
end
save('pImgs.mat', 'pImgs', '-v7.3');