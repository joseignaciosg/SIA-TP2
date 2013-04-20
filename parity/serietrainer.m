%pueba si la red neuronal aprendió a determinar la paridad de 2 a 5 
%entradas

function [V,D,A,s,o,count,dif] = serietrainer(series,P, etta, err, dinamic_learning,momentum_activated)


%maximo valor de P para formar la matriz
m = max(P);
%matriz que guarda deltas W para realizar el Momentum
%difference_weight = rand(m,m+1,length(P)-1); 
%A = rand(m,m+1,length(P)-1)./2 - 0.25;


difference_weight = zeros(m,m+1,length(P)-1); %Delta_Peso
A = randommatrix(P,2,0.25);

A

windowsize = P(1);

index = P(1) -1; %resto -1 para que de bien el index en el vector testing

%Series a tomar en cuenta para entrenamiento
series = series(1:20)./3.8;

series
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

while(dif > err && count < 50000 && abs(dif-old) > 1e-10)

	i=1;
	old = dif;
	cuadratic_error = 0;
	dif = 0;

	while(i<=(length(series)-windowsize))
		s = series(i+windowsize);
		[V,D,A,difference_weight,s,o,ret] = variable(series(i:i+windowsize-1),A,P,s, etta, difference_weight, momentum_activated);	
		i=i+1;
		s
		o
		cuadratic_error = cuadratic_error + (s-o)^2;
		dif = dif + (s-o)^2;
    end
    dif = dif / (i-1); % # patterns;
    dif
    os = [os o];
    ss = [ss s];
    ettas = [ettas etta];

    errors = [dif errors];
    x = [count x];
    cuadratic_errors = [cuadratic_errors cuadratic_error/(i-1)];
    if( dinamic_learning == 1)
    	[etta, contar] = update_lrn_rate ( etta, cuadratic_error/(i-1), cuadratic_errors(length(cuadratic_errors)-1), contar);
%		contar;
%		etta;
	end

    if (mod(count,10) == 0)
            %imprimo la evolución del error
     	      figure(1);
    	      plot(x,errors);
    	      %figure(2)
    	      %plot(x, ettas);
    	     % figure(3)
    	      %plot(x,ss,x,os);
    	     % plot(x,cuadratic_errors(1,1:length(cuadratic_errors) -1 ));
    end
	count = count+1;
end


if(count >= 50000 || (old - dif)<1e-6)
	disp('Solution not reached');
	disp('old');disp(old);
	disp('dif');disp(dif);
end

plot(x,errors);

end

