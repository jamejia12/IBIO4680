function evalPath = evalData2(outPath, kEnd)
%Función que aplica la función allBench_fast.m (genera puntos de precisión-cobertura).
%Inputs:
%outPath: Path de las segmentaciones.
%kEnd: k máximo de las segmentaciones.
%gaussianLvl: Nivel de la pirámide que se está considerando (si es 0, no hubo reescalamiento).
%Outputs:
%.txts que tienen la info de los puntos de la curva Precisión-Cobertura.
%newPath: 
%evalPath: Ruta de los .txts.

%Función que aplica la función allBench_fast.m (genera puntos de precisión-cobertura).
%Inputs:
%outPath: Path de las segmentaciones.
%Outputs:
%.txts que tienen la info de los puntos de la curva Precisión-Cobertura.
%evalPAth: Ruta de los .txts.

k = kEnd/5;

% oriPath = fullfile(pwd, 'BSR', 'bench_fast', 'data', 'images');
% gtPath = fullfile(pwd, 'BSR', 'bench_fast', 'data', 'groundTruth');
% evalPath = fullfile(outPath, 'Eval');

oriPath = fullfile(pwd, 'BSR', 'BSDS500', 'data', 'images', 'val');
gtPath = fullfile(pwd, 'BSR', 'BSDS500', 'data', 'groundTruth', 'val');
evalPath = fullfile(outPath, 'Eval');

mkdir(evalPath);
addpath(fullfile('BSR', 'bench_fast', 'benchmarks'));
allBench_fast(oriPath, gtPath, outPath, evalPath, k);


end