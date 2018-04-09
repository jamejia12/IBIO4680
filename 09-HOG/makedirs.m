function makedirs()

load('wider_face_train.mat');
evalPath = ('eval_tools_Lab9/evalBoxes3');

for i = 1:length(event_list)
    ruta = fullfile(evalPath, event_list{i});
    mkdir(ruta);
end

end