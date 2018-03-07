function uGT = unifyGT (boundGT, method)
%Función que unifica las distintas anotaciones.
%Inputs:
%boundGT: GT de boundaries de una imagen.
%method: Método de segmentación usado.
%Outputs:
%uGT: GT unificado (una única anotación).

n = length(boundGT);
if strcmp(method, 'hierarchical') == 1
    actualGT = impyramid(boundGT{1}, 'reduce');
    for i = 2:n
        actualGT = actualGT + impyramid(boundGT{i}, 'reduce');
    end
    
else
    actualGT = boundGT{1};
    for i = 2:n
        actualGT = actualGT + boundGT{i};
    end
end

uGT = actualGT > 1;

end