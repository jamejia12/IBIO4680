function segmentation = useCluster(rgbImage, dImg, clusteringMethod, numberOfClusters)
%Clusteriza img por el método y número de clusters dados por parámetro.
%Inputs:
%rgbImage: Imagen original (input en featChange).
%dImg: Representación vectorial de la imagen original (output de featChange).
%cluseringMethod: Método de clusterización (kmeans, gmm, hierarchical, watershed).
%numberOfClusters: Número de clusters a usar.
%Outputs:
%segmentation: Segmentación obtenida (en forma matricial).

if strcmp(clusteringMethod, 'kmeans') == 1
    segmentation = kmeans(dImg, numberOfClusters);
    
elseif strcmp(clusteringMethod, 'gmm') == 1
    gmModel = fitgmdist(dImg, numberOfClusters);
    segmentation = cluster(gmModel, dImg);
    
elseif strcmp(clusteringMethod, 'hierarchical') == 1
    %Creación de árboles no se puede hacer directamente (excede limite de array).
    
    %Pasa dImg a forma matricial.
    [mO, nO, pO] = size(rgbImage);
    nL = size(dImg, 2); 
    if nL<4
        mImg = reshape(dImg, [mO, nO, pO]);
    else
        mImg = reshape(dImg(:,:,1:3), [mO, nO, pO]);
    end
    
    %Reduce resolución.    
    mImg = impyramid(mImg, 'reduce');
    rgbImage = mImg;
    
    %Devuelve a representación vectorial.
    [m, n, ~] = size(mImg);
    if nL < 4        %Tiene 3 descriptores.
        dImg = reshape(mImg, [m*n, 3]);
    else            %Tiene 5 descriptores.
        dImg = zeros(m*n, 5);
        dImg(:,1:3) = reshape(mImg, [m*n, 3]);
        
        xCoord = ones(m,1);
        yCoord = (1:m)';
        posI = 1;
        for i = 1:n
            dImg(posI:posI+m-1, 4) = xCoord.*i;          %Obtiene coordenadas 'X' (cambio de columnas).
            dImg(posI:posI+m-1, 5) = yCoord;             %Obtiene coordenadas 'Y' (cambio de filas).
            posI = posI +m;
        end
    end
    
    %Obtiene árbol de clusterización jerárquica.
    tree = linkage(dImg, 'ward');     %Single NO SIRVE.
    segmentation = cluster(tree, 'maxclust', numberOfClusters);
    
elseif strcmp(clusteringMethod, 'watershed') == 1
    %Pasa dImg a forma matricial.
    [mO, nO, pO] = size(rgbImage);
    nL = size(dImg, 2); 
    if nL<4
        mImg = reshape(dImg, [mO, nO, pO]);
    else
        mImg = reshape(dImg(:,:,1:3), [mO, nO, pO]);
    end
    rgbImage = mImg;
    
    %Construye gradientes.
    hy = fspecial('sobel');
    hx = hy';
    
    Iy = imfilter(double(mImg(:,:,1)), hy, 'replicate');
    Ix = imfilter(double(mImg(:,:,1)), hx, 'replicate');
    grad1 = sqrt(Ix.^2 + Iy.^2);
    
    Iy = imfilter(double(mImg(:,:,2)), hy, 'replicate');
    Ix = imfilter(double(mImg(:,:,2)), hx, 'replicate');
    grad2 = sqrt(Ix.^2 + Iy.^2);
    
    Iy = imfilter(double(mImg(:,:,3)), hy, 'replicate');
    Ix = imfilter(double(mImg(:,:,3)), hx, 'replicate');
    grad3 = sqrt(Ix.^2 + Iy.^2);
    
    grad = grad1+grad2+grad3;       %Suma gradientes de cada canal.
    
    %Aplica watersheds al gradiente anteriormente definido.
    h = 10;
    maxi = inf;
    while (maxi > numberOfClusters)
        marker = imextendedmin(grad, h);
        new_grad = imimposemin(grad, marker);
        ws = watershed(new_grad);
        segmentation = ws;
        h = h+10;
        maxi = max(max(segmentation));
    end
    
else 
    segmentation = 'Error. Introduzca un clustering method válido';
    disp(segmentation);
end

%Devuelve segmentacion en forma matricial (si los parámetros de entrada son correctos).
if ischar(segmentation) ~= 1
    [mO, nO, ~] = size(rgbImage);
    nL = size(segmentation, 2); 
    if nL<4
        segmentation = reshape(segmentation, [mO, nO]);
    else
        segmentation = reshape(segmentation(1:(mO*nO)), [mO, nO]);
    end
end

end