function down = downsampling2(up, nivel)
%Genera una pirámide Gaussiana.
%Inputs:
%up: Imágen a la cuál se le realizará el downsample.
%nivel: Número de niveles que se quiere que tenga la pirámide.
%Outputs:
%down: Imágen tras hacerle el downsample. Es una celda, en cada espacio hay un nivel de la imágen.
    down = cell(1, nivel);
    down{1,1} = up;
    comp = 1;       %Compara nivel inicial con el nivel objetivo.
    
    while nivel > comp
        [m, n, ~] = size(up);
        comp = comp +1;
        
        down{1,comp} = (zeros(ceil(m/2), ceil(n/2)));
        
        %Genera el nivel con un filtro gaussiano de 3x3 y sigma especificado.
        sigma = 0.1; 
        h = fspecial('gaussian', 3, sigma);
        for i = 1:2:m
            for j = 1:2:n
                down{1,comp}(ceil(i/2),ceil(j/2)) =  imfilter(up(i,j,:), h);
            end
        end
        
        %Actualiza los ids y vuelve a generar un nivel de la pirámide.
        up = down{1,comp};
    end
    
end