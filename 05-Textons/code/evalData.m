function [trACA, tsACA, gblACA] = evalData (model, tMapTrain, tMapTest, numTrain)
%Evalua el desempe�o del modelo en las categor�as de train, test y global.
%Inputs:
%model: Modelo con el que se va a evaluar.
%tMapTrain: Textons map de las im�genes de Train.
%tMapTest: Textons map de las im�genes de Test.
%numTrain: N�mero de datos que hay en train (previamente definido en redDataSep).
%Outputs:
%trMat: Matriz de confusi�n de train.
%tsMat: Matriz de confusi�n de test.
%gblMat: Matriz de confusi�n global.
%trACA: ACA de Train.
%tsACA: ACA de Test.
%gblACA: ACA global.

rng(1);
a = load(tMapTrain);
tMapTrain = a.tMapTrain;

b = load(tMapTest);
tMapTest = b.tMapTest;

c = load(model);
model = c.model;

p1 = size(tMapTrain, 3);
p2 = size(tMapTest, 3);
n = numel(tMapTrain(:, :, 1));
numTest = 40-numTrain;

%Pasa a vectores fila.
trainData = zeros(numTrain*25, n);
for i = 1:p1
    temp = tMapTrain(:, :, i);
    trainData(i, :) = temp(:)';
end

testData = zeros(numTest*25, n);
for i = 1:p2
    temp = tMapTest(:, :, i);
    testData(i, :) = temp(:)';
end


%Crea anotaciones.
trGT = ones(numTrain*25,1);
posI = 1;
for i = 1:25
    trGT(posI:posI+numTrain-1) = i;
    posI = posI +numTrain;
end

tsGT = ones(numTest*25,1);
posI = 1;
for i = 1:25
    tsGT(posI:posI+numTrain-1) = i;
    posI = posI +numTrain;
end


%Genera los datos y las etiquetas globales.
gblData = vertcat(trainData, testData);
gblGT = vertcat(trGT, tsGT);

trP = predict(model, trainData);
tsP = predict(model, testData);
gblP = predict(model, gblData);

%El output de predict con TreeBagger es cell, toca pasarlo a matr�z.
if iscell(trP) == 1
    for i = 1:numTrain*25
        trP{i} = str2double(trP{i});
        gblP{i} = str2double(gblP{i});
    end
    for i = 1:numTest*25
        tsP{i} = str2double(tsP{i});
        gblP{i+numTrain*25} = str2double(gblP{i+numTrain*25});
    end
    
    trP = cell2mat(trP);
    tsP = cell2mat(tsP);
    gblP = cell2mat(gblP);
end

trMat = confusionmat(trGT, trP);
tsMat = confusionmat(tsGT, tsP);
gblMat = confusionmat(gblGT, gblP);

save('trMat.mat', 'trMat', '-v7.3');
save('tsMat.mat', 'tsMat', '-v7.3');
save('gblMat.mat', 'gblMat', '-v7.3');

trMat = trMat./numTrain;
tsMat = tsMat./numTest;
gblMat = gblMat./40;

trACA = mean(diag(trMat));
tsACA = mean(diag(tsMat));
gblACA = mean(diag(gblMat));

end