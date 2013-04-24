%pueba si la red neuronal aprendi� a determinar la paridad de 2 a 5 
%entradas

function [V,D,A,s,o,count,dif] = serietrainer(series,P, eta, err, lrn_type,momentum_activated, epochs,shuffle, alpha, beta)


%maximo valor de P para formar la matriz
m = max(P);
%matriz que guarda deltas W para realizar el Momentum
%difference_weight = rand(m,m+1,length(P)-1); 
%A = rand(m,m+1,length(P)-1)./2 - 0.25;

%para resear a un paso anterior la matriz de pesos
global reset
reset = 0;



difference_weight = zeros(m,m+1,length(P)-1); %Delta_Peso
A = randommatrix(P,2,0.25);

windowsize = P(1);

index = P(1) -1; %resto -1 para que de bien el index en el vector testing


%Series a tomar en cuenta para entrenamiento
series = (series(1:750) + 3.8)./7.6;

dif = 10;
old = 11;
errors = [];
x = [];
etas = [];
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
    os = [];
    ss = [];
    os_x = [];

    
    [patterns]  = shufflePatterns(series,windowsize,shuffle);
    while(i<=size(patterns,1))
        pattern = patterns(i,1:windowsize);
        s = patterns(i,windowsize+1); ;
		[V,D,A,difference_weight,s,o,ret,alpha] = variable3exp(pattern,A,P,s, eta, difference_weight, momentum_activated,alpha,beta);

		i=i+1;
		final_s = (s * max_serie_doble) - max_serie;
		final_o = (o * max_serie_doble) - max_serie;
		      os = [final_o os];
        ss = [final_s ss];
        os_x = [i os_x];
        cuadratic_error = cuadratic_error + (s-o)^2;
		dif = dif + (s-o)^2;
    end
   
    dif = dif / (i-1); % # patterns;
    dif
    cuadratic_error = cuadratic_error/(i-1); % #patterns
    etas = [etas eta];

    errors = [dif errors];
    x = [count x];
    cuadratic_errors = [cuadratic_errors cuadratic_error];
    [eta, contar, alpha] = update_lrn_rate (lrn_type, eta, cuadratic_error, cuadratic_errors(length(cuadratic_errors)-1), contar, jump, alpha);
    if(count > 50)
        jump = ifErrorsAreSimilar(errors(1,1:50));
    end

    if (mod(count,10) == 0)
             %imprimo la evoluci�n del error
             figure(1);
p1 = plot(x,errors);
set(p1,'Color','red','LineWidth',1);
title('Variaci�n del error a lo largo de las iteraciones');
xlabel('x');
ylabel('error value');
figure(5);
p2 = plot(x,etas);
set(p2,'Color','green','LineWidth',1);
title('Variacion de Eta a lo largo de las iteraciones');
xlabel('x');
ylabel('eta-value');
              figure(2);
              plot(os_x,ss,os_x,os);
              title('Variacion de la salida esperada y obtenida a lo largo de las iteraciones');
              xlabel('x');
              ylabel('Salidas');
    end
	count = count+1;
end


if(count >= 50000 || (old - dif)<1e-6)
	disp('Solution not reached');
	disp('old');disp(old);
	disp('dif');disp(dif);
end

end

