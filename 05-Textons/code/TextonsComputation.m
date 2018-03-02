function TextonsComputation(fltrTrain, k)
%Gives the texton representation of the train data.
%Inputs:
%fltrTrain: Data de entrenamiento filtrada.
%k: Número de clusters que se utilizarán para dividir los textones.
%Outputs:
%textMat: Matriz de las imágenes filtradas.
%cMat: Centroides de los textones.
addpath(fullfile('lib', 'matlab'));

a = load(fltrTrain);
fltrTrain = a.fltrTrain;
p = numel(fltrTrain);       %Número de imágenes en el train data.
n = numel(fltrTrain{1,1});  %Número de respuestas al filtro.

%Crea la matriz concatenada de los datos de entrenamiento.
newMat = cell(1, n);
for i = 1:p             %Recorre las imágenes.
    actualImg = fltrTrain{i};
    for j = 1:n         %Recorre las respuestas a los filtros.
        newMat{j} = horzcat(newMat{j}, actualImg{j});
    end
end

[textMat, cMat] = computeTextons(newMat, k);

save('textMat.mat', 'textMat', '-v7.3');
save('cMat.mat', 'cMat', '-v7.3');

end