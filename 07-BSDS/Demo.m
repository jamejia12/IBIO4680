%% Genera segmentaciones de la sub-base de datos.
featureSpace = 'HSV';
clusteringMethod = 'kmeans';
data = 'sub';       %No toma la base de datos completa. Toma la pequeña.
kEnd = 20;
redMethod = 'G';
redLvl = 1;
maxIter = 100;
centroids = 'plus';

%tic, outPath = runMethod(featureSpace, clusteringMethod, kEnd, data); toc
tic, outPath = runMethod2(featureSpace, kEnd, redMethod, redLvl, maxIter, centroids, data);

%% Aplica la función allBench_fast. (Genera puntos de Precisión-Cobertura).
evalPath = evalData2(outPath, kEnd);

%% Aplica la función plot_eval. (Plotea curva de Precisión-Cobertura).
addpath(fullfile('BSR', 'bench_fast', 'benchmarks'));
plot_eval(evalPath, 'r');
hold on;

%Compara con el método de Pablo (pb).
pbEvalPath = fullfile(pwd, 'BSR', 'bench_fast', 'eval', 'test_all_fast');
plot_eval(pbEvalPath, 'b');
legend('Human Consistency', '', 'RGB-kmeans', 'Probability of Boundary', 'Location', 'southwest');

%% Visualiza la img original, sus anotaciones, el método de Pablo (pb) y el método propuesto.
img = 1;        %Imagen a ver (Número de 1 a 5).
person = 1;     %Persona que segmenta a ver.

%Carga segmentación generada anteriormente.
outDir = dir(fullfile(outPath, '*.mat'));
outName = outDir(img).name;
a = load(fullfile(outPath, outName));
a = a.segs;
a = a{img};
% a = edge(a, 'canny');     %Descomentar si se quieren comparar bordes.

%Carga imagen original.
oriPath = fullfile(pwd, 'BSR', 'bench_fast', 'data', 'images');
oriDir = dir(fullfile(oriPath, '*.jpg'));
oriName = oriDir(img).name;
b = imread(fullfile(oriPath, oriName));

%Carga anotacion.
gtPath = fullfile(pwd, 'BSR', 'bench_fast', 'data', 'groundTruth');
gtDir = dir(fullfile(gtPath, '*.mat'));
gtName = gtDir(img).name;
c = load(fullfile(gtPath, gtName));
c = c.groundTruth;

c = c{person}.Segmentation;         %Si se quiere ver segmentaciones poner '.Segmentation'.
% c = c{person}.Boundaries;           %Si se quiere ver bordes poner '.Boundaries'.

%Carga imagen de método de Pablo (pb).
pbPath = fullfile(pwd, 'BSR', 'bench_fast', 'data', 'png');
pbDir = dir(fullfile(pbPath, '*.png'));
pbName = pbDir(img).name;
d = imread(fullfile(pbPath, pbName));

%Plotea.
subplot(2,2,1), imagesc(b), title('Original'), colormap colorcube
subplot(2,2,2), imagesc(c), title('Ground Truth'), colormap colorcube
subplot(2,2,3), imagesc(a), title(strcat(featureSpace, '-', clusteringMethod)), colormap colorcube
subplot(2,2,4), imagesc(d), title('pb'), colormap colorcube