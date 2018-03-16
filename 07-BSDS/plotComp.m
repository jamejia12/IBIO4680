%% Aplica la función plot_eval. (Plotea curva de Precisión-Cobertura).
addpath(fullfile('BSR', 'bench_fast', 'benchmarks'));

%Paths de los métodos generados a comparar.
evalPath1 = fullfile('Eval_HK_plus_G_1');
evalPath2 = fullfile('Eval_HK_plus_I_1');
evalPath3 = fullfile('Eval_RXK_plus_G_1');
evalPath4 = fullfile('Eval_HK_plus_G_2');
evalPath5 = fullfile('Eval_HK_plus_I_2');
evalPath6 = fullfile('Eval_RXK_plus_G_2');

%Genera gráficas de los métodos generados.
plot_eval(evalPath1, 'r');
hold on;
plot_eval(evalPath2, 'y');
hold on;
plot_eval(evalPath3, 'b');
hold on;
plot_eval(evalPath4, 'm');
hold on;
plot_eval(evalPath5, 'c');
hold on;
plot_eval(evalPath6, 'k');
hold on;

legend('Human Consistency', '', 'HSV-kmeans-plus-G1', 'HSV-kmeans-plus-I1', 'RGB+XY-kmeans-plus-G1', 'HSV-kmeans-plus-G2', 'HSV-kmeans-plus-I2', 'RGB+XY-kmeans-plus-G2', 'Location', 'southwest');

%% Compara con el método de Pablo (pb).
pbEvalPath = fullfile(pwd, 'BSR', 'bench_fast', 'eval', 'test_all_fast');
plot_eval(pbEvalPath, 'b');
legend('Human Consistency', '', 'HSV-kmeans', 'RGB+XY-kmeans', 'Probability of Boundary', 'Location', 'southwest');