function redData (oImgs, ventana)
%Función que toma una ventana de la imágen únicamente para la posterior creación de textones.
%La venta está localizada al centro de la imágen (se parte del supuesto que lo importante está en la mitad.
%Inputs.
%oImgs: Imágenes originales. Entran como un string.
%ventana: Tamaño de la ventana. Entra como un numero i (la ventana es de ixi).
%Outputs:
%redData: Data reducida.

a = load(oImgs);
oImgs = a.oImgs;
[m, n, ~] = size(oImgs);

%Inicializa índices para localizar la ventana.
midM = round(m/2);
midN = round(n/2);
midW = round(ventana/2);

redData = oImgs(midM-midW:midM+midW-1, midN-midW:midN+midW-1, :);
save('redData.mat', 'redData', '-v7.3');

end