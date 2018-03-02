function kModel(tMapTrain, kN, numTrain)
%Funci�n que genera un modelo de KNN con distancia por defecto y kN vecinos.
%Inputs:
%tMapTrain: Textons map de las im�genes de Train.
%kN: kN vecinos m�s cercanos a considerar.
%numTrain: N�mero de datos que hay en train (previamente definido en redDataSep).
%Outputs:
%model: Modelo generado de KNN.

%Cargar tMaps.
a = load(tMapTrain);
tMapTrain = a.tMapTrain;


%Entrena por k-vecinos m�s cercanos.
p = size(tMapTrain, 3);
n = numel(tMapTrain(:, :, 1));


%Pasa los datos a vectores fila.
trainData = zeros(p, n);
for i = 1:p
    temp = tMapTrain(:, :, i);
    trainData(i, :) = temp(:)';
end


%Crea anotaciones.
trGT = ones(p,1);
posI = 1;
for i = 1:25
    trGT(posI:posI+numTrain-1) = i;
    posI = posI +numTrain;
end


rng(1);
model = fitcknn(trainData, trGT, 'NumNeighbors', kN);

save('model.mat', 'model', '-v7.3');

end