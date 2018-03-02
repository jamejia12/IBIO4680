function DataSeparation(pImgs, nivel, numTrain)
%Función que separa el dataset en train y test, dependiendo del número de datos de train que se tenga.
%Inputs:
%pImgs: Pirámide Gaussiana del dataset completo. Se pasa en un string el nombre del archivo que lo contiene (1xp).
%nivel: Nivel de la pirámide Gaussiana que se usará para la posterior generación de textones.
%numTrain: Número de datos que se quieren usar para entrenar.
%Outputs:
%trainData: Data correspondiente a la sección de train. (mxnxnumTrain).
%testData: Data correspondiente a la sección de test. (lo que no es train).

a = load(pImgs);
pImgs = a.pImgs;
p = length(pImgs);

%Recorre para unicamente tener en cuenta un nivel de la pirámide Gaussiana.
[m, n] = size(pImgs{1,1}{1,nivel});
data = zeros(m,n,p);
for i = 1:p
    data(:,:,p) = pImgs{1,i}{1,nivel};
end

trainData = data(:,:, 1:numTrain);
testData = data(:,:, p-numTrain:p);

save('trainData.mat', 'trainData', '-v7.3');
save('testData.mat', 'testData', '-v7.3');

end