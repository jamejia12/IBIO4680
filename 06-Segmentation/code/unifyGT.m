function uGT = unifyGT (boundGT)
%Función que unifica las distintas anotaciones.
%Inputs:
%boundGT: GT de boundaries de una imagen.
%Outputs:
%uGT: GT unificado (una única anotación).

n = length(boundGT);
actualGT = boundGT{1};
for i = 2:n
    actualGT = actualGT + boundGT{i};
end

uGT = actualGT > 1;

end