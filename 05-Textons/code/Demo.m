%% Demo del mejor resultado obtenido: Random Forest (window=50, numTrain=20, k-textons=10, numTrees=50).
%Las fases previas son costosas y no se sabe si darán el mismo resultado.
%Por ello SOLO se pone el FINAL del proceso. 
%Si se quiere verificar todo el proceso, correr la sección de abajo.

numTrain = 20;
numTrees = 50;

treeModel('tMapTrain.mat', numTrees, numTrain);
[tr, ts, gbl] = evalData('model.mat', 'tMapTrain.mat', 'tMapTest.mat', numTrain)

%% PROCESO COMPLETO: NO RECOMENDADO.
%Inicializa en el mejor resultado.
ventana = 50;
numTrain = 20;
kTextons = 10;
numTrees = 50;

%Corre todo el código. 
%Necesita que la Database completa esté en una carpeta llamada 'Data'. 
%Los nombres de las subcarpetas deben ser igual a las originales.
loadImgs();
redData('oImgs.mat', ventana);
redDataSep('redData.mat', numTrain);
ApplyFilters('redTrData.mat', 'redTsData.mat');
TextonsComputation('fltrTrain.mat', 'fltrTest.mat', kTextons);
textonAssignation('fltrTrain.mat', 'fltrTest.mat', 'cMat.mat');
treeModel('tMapTrain.mat', numTrees, numTrain);
[tr, ts, gbl] = evalData('model.mat', 'tMapTrain.mat', 'tMapTest.mat', numTrain)