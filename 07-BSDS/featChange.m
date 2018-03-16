function dImg = featChange (rgbImage, featureSpace)
%Cambia el espacio de color de img a featSpace
%Devuelve un vector descriptor por pixel de mnxp, donde p es el número de descriptores que se quieran (3 ó 5).
%Input:
%img: Imagen en RGB.
%featSpace: Espacio de color (RGB, Lab, HSV y si se quieren o no XY).
%Output:
%dImg = Descriptores de la imagen (mnxp).

[m, n, ~] = size(rgbImage);

if strcmp(featureSpace, 'RGB') == 1
    dImg = reshape(rgbImage, [m*n, 3]);          %Col1=R, col2=G, col3=B. Primero filas, luego columnas.
elseif strcmp(featureSpace, 'Lab') == 1
    dImg = rgb2lab(rgbImage);
    dImg = reshape(dImg, [m*n, 3]);
elseif strcmp(featureSpace, 'HSV') == 1
    dImg = rgb2hsv(rgbImage);
    dImg = reshape(dImg, [m*n, 3]);
elseif strcmp(featureSpace, 'RGB+XY') == 1
    dImg = zeros(m*n, 5);
    dImg(:,1:3) = reshape(rgbImage, [m*n, 3]);
    
    xCoord = ones(m,1);
    yCoord = (1:m)';
    posI = 1;
    for i = 1:n
        dImg(posI:posI+m-1, 4) = xCoord.*i;          %Obtiene coordenadas 'X' (cambio de columnas).
        dImg(posI:posI+m-1, 5) = yCoord;             %Obtiene coordenadas 'Y' (cambio de filas).
        posI = posI +m;
    end
elseif strcmp(featureSpace, 'Lab+XY') == 1
    temp = rgb2lab(rgbImage);
    dImg = zeros(m*n, 5);
    dImg(:,1:3) = reshape(temp, [m*n, 3]);
    
    xCoord = ones(m,1);
    yCoord = (1:m)';
    posI = 1;
    for i = 1:n
        dImg(posI:posI+m-1, 4) = xCoord.*i;          %Obtiene coordenadas 'X' (cambio de columnas).
        dImg(posI:posI+m-1, 5) = yCoord;             %Obtiene coordenadas 'Y' (cambio de filas).
        posI = posI +m;
    end
elseif strcmp(featureSpace, 'HSV+XY') == 1
    temp = rgb2hsv(rgbImage);
    dImg = zeros(m*n, 5);
    dImg(:,1:3) = reshape(temp, [m*n, 3]);
    
    xCoord = ones(m,1);
    yCoord = (1:m)';
    posI = 1;
    for i = 1:n
        dImg(posI:posI+m-1, 4) = xCoord.*i;          %Obtiene coordenadas 'X' (cambio de columnas).
        dImg(posI:posI+m-1, 5) = yCoord;             %Obtiene coordenadas 'Y' (cambio de filas).
        posI = posI +m;
    end
end

dImg = double(dImg);        %Pasa a double para evitar problemas.
end