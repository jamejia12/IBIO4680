function down = downsampling(up, nivel)
    down = cell(1, nivel);
    down{1,1} = up;
    comp = 1;       %Compara nivel inicial con el nivel objetivo.
    
    while nivel > comp
        [m, n, ~] = size(up);
        comp = comp +1;
        
        down{1,comp} = uint8(zeros(ceil(m/2), ceil(n/2), 3));
        
        %Genera el nivel de la pirámide tomando vecindad de 4x4 y un filtro promedio.
        for i = 1:2:m-1
            for j = 1:2:n-1
                window = up(i:(i+1), j:(j+1), :);
                down{1,comp}(ceil(i/2),ceil(j/2), :) = (sum(sum(window))/4) ;
            end
        end
        
        %Actualiza los ids y vuelve a generar un nivel de la pirámide.
        up = down{1,comp};
    end
    
end