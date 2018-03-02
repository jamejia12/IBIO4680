function redDataSep(redData, numTrain)
%Función que separa el dataset en train y test, dependiendo del número de datos de train especificado.
%Inputs:
%redData: Dataset reducido completo. Se pasa en un string el nombre del archivo que lo contiene (wxwxp).
%numTrain: Número de datos que se quieren usar para entrenar por categoría.
%Outputs:
%redTrData: Data correspondiente a la sección de train. (mxnxnumTrain).
%redTsData: Data correspondiente a la sección de test. (lo que no es train).
a = load(redData);
redData = a.redData;

%Recorre las categorías.
[m, n, ~] = size(redData);
numTest = 40-numTrain;
redTrData = zeros(m, n, numTrain*25);
redTsData = zeros(m, n, numTest*25);
posITr = 1;
posITs = 1;
for i = 0:24
    redTrData(:,:, posITr:posITr+numTrain-1) = redData(:,:, (40*i+1):(40*i+numTrain));
    redTsData(:,:, posITs:posITs+numTest-1) = redData(:,:, (40*i+1+numTrain):40*(i+1));
    posITr = posITr+numTrain;
    posITs = posITs+numTest;
end

save('redTrData.mat', 'redTrData', '-v7.3');
save('redTsData.mat', 'redTsData', '-v7.3');

end