function up = upsampling(down, nivel)
    up = cell(1, nivel);
    up{1,1} = down;
    comp = 1;       %Compara nivel inicial con el nivel objetivo.
    
    %Crea kernels con los que se va a realizar el upsample.
    sigma = 0.5;
    h = fspecial('gaussian', 5, sigma);
    
    hUL = zeros(3);
    hLL = zeros(3);
    
    hUL(1:2, 1:2) = h(2:3, 2:3);
    hUL(3, 1:3) = h(5, 3:5);
    hUL(1:3, 3) = h(3:5, 5);
    
    hLL(3,:) = hUL(1, :);
    hLL(1,:) = hUL(3, :);
    hLL(2,:) = hUL(2, :);
    
    hUR = hLL';
    
    hLR(:, 1) = hLL(:, 3);
    hLR(:, 3) = hLL(:, 1);
    hLR(:, 2) = hLL(:, 2);
    
    while nivel > comp
        comp = comp +1;
        
        [m, n, ~] = size(down);
        up{1, comp} = uint8(zeros(2*m, 2*n, 3));
        
        for i = 1:m
            posi = 2*i-1;
            for j = 1:n
                posj = 2*j-1;
                
                UL = imfilter(down(i,j), hUL);
                UR = imfilter(down(i,j), hUR);
                LL = imfilter(down(i,j), hLL);
                LR = imfilter(down(i,j), hLR);
                
                up{1,comp}(posi, posj, :) = UL;
                up{1,comp}(posi, posj+1, :) = UR;
                up{1,comp}(posi+1, posj, :) = LL;
                up{1,comp}(posi+1, posj+1, :) = LR;
            end
        end
        
        down = up{1, comp};
    end
end