function loadTrainData()

%Inicializa variables de interés.
trainImages = {} ;      %List of train images. event_list + file_list{cat}.
trainBoxes = {} ;       %4xN array (Xmin, Ymin, Xmax, Ymax). face_bbx_list{cat}{img}.
trainBoxImages = {} ;   %For each bounding box, the name of the img containing it. trainImages / trBox.
trainBoxLabels = [] ;   %targetClass. 1
trainBoxPatches = {} ;  %64x64x3xN image patches. 


%Carga los trainBoxPatches.
trCPath = 'TrainCrops/';

trCDir = dir(trCPath);
trBoxIndex = {};

%For para cargar las imágenes recortadas (trainBoxPatches).
for i = 3:length(trCDir)        %Recorre las distintas categorias.
    className = trCDir(i).name;
    
    %Para las recortadas.
    classCPath = fullfile(trCPath, className, '*.jpg');
    classCDir = dir(classCPath);
    for j = 1:length(classCDir)
        ruta = fullfile(trCPath, className, classCDir(j).name);
        im = imread(ruta);
        trainBoxPatches{end+1} = imresize(im, [128, 96]);
        
        boxName = classCDir(j).name;
        boxName = strsplit(boxName, 'm');
        boxName = boxName{2};
        boxName = strsplit(boxName, 'c');
        boxName = boxName{1};
        boxName = str2double(boxName);
        if j==1
            trBoxNums = [];     %Indicador para saber a qué imagen corresponde el patch.
            trBoxNums(end+1) = boxName;
        end
        if trBoxNums(end) ~= boxName
            trBoxNums(end+1) = boxName;
        end
    end
    trBoxNums = sort(trBoxNums);
    trBoxIndex{end+1} = trBoxNums;
end


%Carga info de la base de datos.
load('wider_face_train.mat');

numCats = size(event_list);     %61 cats.

for i = 1:numCats       %For para recorrer todas las categorias.
    pos = trBoxIndex{i};
    newFileList = file_list{i}(pos);
    newFaceBbxList = face_bbx_list{i}(pos);
    
    %trainImages (rutas) a las imágenes originales.
    newTrainImages = fullfile('TrainImages', event_list{i}, newFileList);
    trainImages{end+1} = newTrainImages;
    
    %trainBoxes (4xN).
    trainBoxes{end+1} = cat(1, newFaceBbxList{:});
    
    %trainBoxImages (imagenes de las bbx).
    for j = 1:length(newFaceBbxList)
        for k = 1:size(newFaceBbxList{j}, 1)
            trainBoxImages{end+1} = newTrainImages{j};
        end
    end
end

%Pasa a mxnx3xnumPatches.
trainBoxPatches = cat(4, trainBoxPatches{:}) ;

%Pasa a un solo vector.
trainImages = cat(1, trainImages{:});

%Pasa a 4xN y [xmin, ymin, xmax, xmin].
trainBoxes = cat(1, trainBoxes{:});
trainBoxes(:,3) = trainBoxes(:,1) + trainBoxes(:,3);
trainBoxes(:,4) = trainBoxes(:,2) + trainBoxes(:,4);
trainBoxes = trainBoxes';

%Crea una única etiqueta (cara) igual a 1.
trainBoxLabels = ones(1, length(trainBoxImages));

save('trainImages.mat', 'trainImages', '-v7.3');
save('trainBoxPatches.mat', 'trainBoxPatches', '-v7.3');
save('trainBoxLabels.mat', 'trainBoxLabels', '-v7.3');
save('trainBoxImages.mat', 'trainBoxImages', '-v7.3');
save('trainBoxes.mat', 'trainBoxes', '-v7.3');

end