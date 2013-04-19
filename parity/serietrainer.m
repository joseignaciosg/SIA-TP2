%pueba si la red neuronal aprendió a determinar la paridad de 2 a 5 
%entradas

function [V,D,A,s,o,count,dif] = serietrainer(series,P, etta, err, dinamic_learning,momentum_activated)

global A;
global difference_weight;

%maximo valor de P para formar la matriz
m = max(P);
%matriz que guarda deltas W para realizar el Momentum
difference_weight = rand(m,m+1,length(P)-1); 
A = rand(m,m+1,length(P)-1)./4 - 0.125;


%Tamanio de la ventana
windowsize = P(1);

index = P(1) -1; %resto -1 para que de bien el 

%Series a tomar en cuenta para entrenamiento
series = series(1:750);

dif = 10;
old = 11;
threshold = 50000;
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

while(dif > err && threshold > 0 && abs(dif-old) > 1e-10)
	i=1;
	old = dif;
	dif = 0;
	while(i<=(length(series)-windowsize))
    
		[V,D,A,difference_weight,s,o,ret] = variable(series(i:i+windowsize-1),A,P,series(i+windowsize),etta,difference_weight,momentum_activated);	
		i=i+1;
		cuadratic_error = cuadratic_error + (s-o)^2;
		dif = dif + (s-o)^2;
    end
	dif = dif / 4; % four patterns;
    dif
    os = [os o];
    ss = [ss s];
    ettas = [ettas etta];
    errors = [dif errors];
    x = [count x];
    cuadratic_errors = [cuadratic_errors cuadratic_error/4];
    if( dinamic_learning == 1)
    	[etta contar] = update_lrn_rate ( etta, cuadratic_error/4, cuadratic_errors(length(cuadratic_errors)-1), contar);
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
	count= count+1;
	threshold= threshold-1;
end


if(threshold <= 0 || (old - dif)<1e-6)
	disp('Solution not reached');
	disp('old');disp(old);
	disp('dif');disp(dif);
end


plot(x,errors);
A
end

