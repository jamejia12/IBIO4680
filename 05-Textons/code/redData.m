function redData (oImgs, ventana)
%Funci�n que toma una ventana de la im�gen �nicamente para la posterior creaci�n de textones.
%La venta est� localizada al centro de la im�gen (se parte del supuesto que lo importante est� en la mitad.
%Inputs.
%oImgs: Im�genes originales. Entran como un string.
%ventana: Tama�o de la ventana. Entra como un numero i (la ventana es de ixi).
%Outputs:
%redData: Data reducida.

a = load(oImgs);
oImgs = a.oImgs;
[m, n, ~] = size(oImgs);

%Inicializa �ndices para localizar la ventana.
midM = round(m/2);
midN = round(n/2);
midW = round(ventana/2);

redData = oImgs(midM-midW:midM+midW-1, midN-midW:midN+midW-1, :);
save('redData.mat', 'redData', '-v7.3');

end