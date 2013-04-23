function [V,D,A,s,o,count,dif] = serietrainer(series,P, etta, err, lrn_type,momentum_activated, epochs,shuffle, alpha, beta)



%maximo valor de P para formar la matriz
m = max(P);

%para resear a un paso anterior la matriz de pesos
global reset
reset = 0;

difference_weight = zeros(m,m+1,length(P)-1); %Delta_Peso
A = randommatrix(P,2,0.25);

windowsize = P(1);

index = P(1) -1; %resto -1 para que de bien el index en el vector testing

%Series a tomar en cuenta para entrenamiento
max_serie = max(series);
series = series(1:750)./max_serie;

dif = 10;
old = 11;
errors = [];
x = [];
ettas = [];
os=[];
ss=[];
count = 0;

%Almacenamiento de Errores cuadraticos para realizar el dinamic learning rate.
cuadratic_errors = 0;
cuadratic_error = 0;
contar = 0;
jump = 0;



while(dif > err && count < epochs && abs(dif-old) > 1e-10)
	i=1;
	old = dif;
	cuadratic_error = 0;
	dif = 0;
    
    [patterns]  = shufflePatterns(series,windowsize,shuffle);
    while(i<=size(patterns,1))
        pattern = patterns(i,1:windowsize);
        s = patterns(i,windowsize+1); ;
		[V,D,A,difference_weight,s,o,ret,alpha] = variable3(pattern,A,P,s, etta, difference_weight, momentum_activated,alpha, beta);	
		i=i+1;
		final_s = s * max_serie;
		final_o = o * max_serie;
		cuadratic_error = cuadratic_error + (s-o)^2;
		dif = dif + (s-o)^2;
    end
    dif = dif / (i-1); % #patterns;
    %dif
    cuadratic_error = cuadratic_error/(i-1); % #patterns
    errors = [dif errors];
    x = [count x];
    ettas = [ettas etta];
    cuadratic_errors = [cuadratic_errors cuadratic_error];

    %Modifico el etta en caso de ser necesario
    [etta, contar, alpha] = update_lrn_rate (lrn_type, etta, cuadratic_error, cuadratic_errors(length(cuadratic_errors)-1), contar, jump, alpha);


    if(count > 15)
        jump = ifErrorsAreSimilar(errors(1,1:15));
    end

    if (mod(count,10) == 0)
            %imprimo la evoluci�n del error
     	      figure(1);
    	      plot(x,errors);
    end
	count = count+1;
end


if(count >= 50000 || (old - dif)<1e-6)
	disp('Solution not reached');
	disp('old');disp(old);
	disp('dif');disp(dif);
end

figure(4);
plot(x,errors);
figure(5);
plot(x,ettas);

end


