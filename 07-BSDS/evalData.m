function evalPath = evalData(outPath, kEnd)
%Funci�n que aplica la funci�n allBench_fast.m (genera puntos de precisi�n-cobertura).
%Inputs:
%outPath: Path de las segmentaciones.
%Outputs:
%.txts que tienen la info de los puntos de la curva Precisi�n-Cobertura.
%evalPAth: Ruta de los .txts.

k = kEnd/5;

oriPath = fullfile(pwd, 'BSR', 'BSDS500', 'data', 'images', 'test');
gtPath = fullfile(pwd, 'BSR', 'BSDS500', 'data', 'groundTruth', 'test');
evalPath = fullfile(outPath, 'Eval');
mkdir(evalPath);
addpath(fullfile('BSR', 'bench_fast', 'benchmarks'));
allBench_fast(oriPath, gtPath, outPath, evalPath, k);


end