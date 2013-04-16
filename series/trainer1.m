%entrena a una red iterativamente
%para xor con unidad no lineal tangente hiperbolica

function [V,D,W,W2,s,o,count] = trainer1(series,windowsize, W,W2,etta,err)

    count = 0;
    error = inf;
    errors = 0;
    x=count;
    while(error > err)
        i=1;
        error = 0;
        while(i<=length(series)-windowsize)
            [V,D,W,W2,s,o,ret] = prediction1(series(i:i+windowsize-1),W,W2,series(i+windowsize),etta,0);
            i=i+windowsize;
            error = error + (s-o)^2;
        end
        error = error / (length(series)/windowsize); 
        errors = [ errors error ];
        x = [x count];
        error
        if (mod(count,10) == 0)
            %imprimo la evolición del error
            plot(x,errors);
        end
        count = count+1;
         
    end


    %imprimo la evolición del error
    plot(x,errors);

end

%ejemplo con 3 entradas
%[V,D,W,W2,s,o,count] = paritywrapper([0 0 0; 1 1 1; 1 0 0; 0 0 1; 0 1 1; 1 0 1; 1 1 0; 0 1 0],[1 0 0 0 1 1 1 0],[0.23 0.23 0.32 0.1; 0.4 0.3 0.1 0.2; 0.2 0.12 0.35 0.2],[0.3 0.2 0.12 0.21],0.02,0.001)
% test: [V,D,W,W2,s,o,ret] = parity([1 0 1],W,W2,1,0.02)