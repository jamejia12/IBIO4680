%% Carga de imágenes y anotaciones.
oImgs = loadImgs;       %Carga las imágenes originales, lo guarda en celda.
[segGT, boundGT] = loadGT;              %Carga las anotaciones, las guarda en una celda.

%% Visualiza una imágen.
pos = 1;
numPersons = length(segGT{pos});
person = 1;

for i = 1:3:numPersons*3
    subplot(numPersons,3,i), imagesc(oImgs{pos}), colormap colorcube;
    subplot(numPersons,3,i+1), imagesc(segGT{pos}{person}), colormap colorcube;
    subplot(numPersons,3,i+2), imagesc(boundGT{pos}{person}); 
    person = person +1;
end

%% Visualiza una imágen.
pos = 1;
person = 1;
subplot(1,3,1), imagesc(oImgs{pos}), colormap colorcube;
subplot(1,3,2), imagesc(segGT{pos}{person}), colormap colorcube;
subplot(1,3,3), imagesc(boundGT{pos}{person});

%% Carga un featspace.
pos = 1;
featspace = 'Lab';

aImg = oImgs{pos};      %Actual image.
mImg = featChange(aImg, featspace);     %Modified for clustering image.

%% Clusteriza.
cMethod = 'watershed';
seg = useCluster(aImg, mImg, cMethod, 50);

%% Compara resultado de clusterización con las anotaciones.
pos = 1;
person = 1;
subplot(1,3,1), imagesc(aImg), colormap colorcube;
subplot(1,3,2), imagesc(segGT{pos}{person}), colormap colorcube;
subplot(1,3,3), imagesc(seg), colormap colorcube;

%% Unifica GT.
n = length(boundGT);
uniGT = cell(1,n);
for i = 1:n
    uniGT{i} = unifyGT(boundGT{i});
end

%% Compara GT con anotaciones.
bound = edge(seg, 'canny', 0.6);        %Cambiar Canny Threshold.
subplot(1,4,1), imagesc(segGT{pos}{person}), colormap colorcube;
subplot(1,4,2), imagesc(boundGT{pos}{person}), colormap colorcube;
subplot(1,4,3), imagesc(seg), colormap colorcube;
subplot(1,4,4), imagesc(bound), colormap colorcube;

%% Evalua desempeño (de una sola imágen).
threshold = 10;     %Umbral de distancia para considerarlo una intersección.
Jaccard = evalData(bound, uniGT{pos}, threshold);

avJ = mean(Jaccard);
[val, pos] = max(Jaccard);