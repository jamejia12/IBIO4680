function treeModel(tMapTrain, numTrees, numTrain)
%Función que genera un modelo de Random Forest con numTrees número de árboles.
%Inputs:
%tMapTrain: Textons map de las imágenes de Train.
%numTrees: Número de árboles a considerar.
%numTrain: Número de datos que hay en train (previamente definido en redDataSep).
%Outputs:
%model: Modelo generado de TreeBagger (random forest).

%Cargar tMaps.
a = load(tMapTrain);
tMapTrain = a.tMapTrain;


%Entrena por k-vecinos más cercanos.
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
model = TreeBagger(numTrees, trainData, trGT);

save('model.mat', 'model', '-v7.3');

end