function ApplyFilters2(redTrData, redTsData)
%Aplica filtros Maximum Response (MR) por defecto.
%Inputs:
%redTrData: Data de entrenamiento.
%redTsData: Data de test.
%Outputs:
%fltrTrain: Respuesta del TrainData al banco de filtros.
%fltrTest: Respuesta del TestData al banco de filtros.

%Carga e inicializa los data de cada subsample.
addpath(fullfile('lib', 'matlab'));
a = load(redTrData);
redTrData = a.redTrData;
p1 = size(redTrData, 3);

b = load(redTsData);
redTsData = b.redTsData;
p2 = size(redTsData, 3);

%Filtra ambos subsamples.
fltr = makeRFSfilters;
n = size(fltr, 3);
fb = cell(n,1);
for i = 1:n
    fb{i} = fltr(:, :, i);
end

fltrTrain = cell(1, p1);
for i = 1:p1
    fltrTrain{1, i} = fbRun(fb, redTrData(:, :, i));
end

fltrTest = cell(1, p2);
for i = 1:p2
    fltrTest{1, i} = fbRun(fb, redTsData(:, :, i));
end

save('fltrTrain.mat', 'fltrTrain', '-v7.3');
save('fltrTest.mat', 'fltrTest', '-v7.3');

end