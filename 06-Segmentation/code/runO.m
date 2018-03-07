function Jac = runO(space, method)

oImgs = loadImgs;       %Carga las imágenes originales, lo guarda en celda.
[~, boundGT] = loadGT;              %Carga las anotaciones, las guarda en una celda.

n = length(oImgs);      %Número de imágenes de la database.

Jac = cell(1,48);
pos = 1;

for clust = 1:4
    if clust == 1
        c = 5;
    elseif clust == 2
        c = 10;
    elseif clust == 3
        c = 20;
    else
        c = 50;
    end
    
    %Carga segmentaciones y anotaciones.
    segmentation = cell(1,n);
    uniGT = cell(1,n);
    Jac{pos} = zeros(1,n);
    
    for i = 1:n
        segmentation{i} = segmentByClustering(oImgs{i}, space, method, c);
        uniGT{i} = unifyGT (boundGT{i}, method);
    end
    
    for dist = 1:3
        if dist == 1
            d = 1;
        elseif dist == 2
            d = 5;
        else
            d = 10;
        end
        
        for canny = 1:4
            if canny == 1
                T = 'd';
            elseif canny == 2
                T = 0.1;
            elseif canny == 3
                T = 0.5;
            else
                T = 0.9;
            end
            
            if ischar(T) == 1
                for i = 1:n
                    bound = boundOfSeg(segmentation{i});
                    Jac{pos}(i) = evalData(bound, uniGT{i}, d);
                end
                pos = pos+1;
            else
                for i = 1:n
                    bound = boundOfSeg(segmentation{i}, T);
                    Jac{pos}(i) = evalData(bound, uniGT{i}, d);
                end
                pos = pos+1;
            end
        end
    end
end

end