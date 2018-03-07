function uGT = unifyGT (boundGT)
%Funci�n que unifica las distintas anotaciones.
%Inputs:
%boundGT: GT de boundaries de una imagen.
%Outputs:
%uGT: GT unificado (una �nica anotaci�n).

n = length(boundGT);
actualGT = boundGT{1};
for i = 2:n
    actualGT = actualGT + boundGT{i};
end

uGT = actualGT > 1;

end