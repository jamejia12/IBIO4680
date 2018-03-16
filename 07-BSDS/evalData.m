function evalPath = evalData(outPath, kEnd)
%Función que aplica la función allBench_fast.m (genera puntos de precisión-cobertura).
%Inputs:
%outPath: Path de las segmentaciones.
%Outputs:
%.txts que tienen la info de los puntos de la curva Precisión-Cobertura.
%evalPAth: Ruta de los .txts.

k = kEnd/5;

oriPath = fullfile(pwd, 'BSR', 'BSDS500', 'data', 'images', 'test');
gtPath = fullfile(pwd, 'BSR', 'BSDS500', 'data', 'groundTruth', 'test');
evalPath = fullfile(outPath, 'Eval');
mkdir(evalPath);
addpath(fullfile('BSR', 'bench_fast', 'benchmarks'));
allBench_fast(oriPath, gtPath, outPath, evalPath, k);


end