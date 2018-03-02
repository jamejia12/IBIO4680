function textonAssignation(fltrTrain, fltrTest, cMat)
%Funcion que asigna los textones a las im�genes teniendo en cuenta el diccionario anteriormente creado.
%Inputs:
%fltrTrain: Respuesta del TrainData al banco de filtros.
%fltrTest: Respuesta del TestData al banco de filtros.
%cMat: Centroides de los textones.
%Outputs:
%tMapTrain: Textons map de las im�genes de train.
%tMapTest: Textons map de las im�genes de test.

addpath(fullfile('lib', 'matlab'));

%Carga info y la pone en el formato para ser le�da por la funci�n assignTextons.m.
a = load(fltrTrain);
fltrTrain = a.fltrTrain;
b = load(fltrTest);
fltrTest = b.fltrTest;
c = load(cMat);
cMat = c.cMat;
cMat = cMat';

p1 = numel(fltrTrain);          %N�mero de im�genes en el train data.
p2 = numel(fltrTrain);          %N�mero de im�genes en el test data.
[m, n] = size(fltrTrain{1,1}{1});     %Tama�o de respuestas al filtro.

%Asigna los textones.
tMapTrain = zeros(m, n, p1);
for i=1:p1
    tMapTrain(:,:,i) = assignTextons(fltrTrain{i}, cMat);
end

tMapTest = zeros(m, n, p2);
for i=1:p2
    tMapTest(:,:,i) = assignTextons(fltrTest{i}, cMat);
end

save('tMapTrain.mat', 'tMapTrain', '-v7.3');
save('tMapTest.mat', 'tMapTest', '-v7.3');

end