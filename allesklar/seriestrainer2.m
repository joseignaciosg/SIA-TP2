%pueba si la red neuronal aprendió a determinar la paridad de 2 a 5 
%entradas

function [V,D,A,s,o,count,dif] = seriestrainer2(series ,P, etta, err)

global A;
global difference_weight;

%inicializar vector de matrices
m = max(P);
difference_weight = rand(m,m+1,length(P)-1); %Delta_Peso
A = randommatrix(P,4);

windowsize = P(1);

index = P(1) -1; %resto -1 para que de bien el 
%index en el vector testing

%patterns = testing.(strcat('p',num2str(index)));

series = series(1:500);
%cols = size(patterns,2);
dif = 10;
old = 11;
threshold = 50000;
errors = [];
x = [];
count = 0;

cuadratic_errors = 0;
cuadratic_error = 0;
contar = 0;

%while(dif > err && threshold > 0 && abs(dif-old) > 1e-10)
while(dif > err )
	i=1;
	old = dif;
	dif = 0;
	while(i<=(length(series)-windowsize))    
		[V,D,A,s,o,ret] = variable2(series(i:i+windowsize-1),P,A,series(i+windowsize),etta);	
		i=i+1;
        cuadratic_error = cuadratic_error + (s-o)^2;
		dif = dif + (s-o)^2;
    end
	dif = dif / (length(series)-windowsize);
    errors = [dif errors];
    x = [count x];
    cuadratic_errors = [cuadratic_errors cuadratic_error/4];
    if (mod(count,1) == 0)
            %imprimo la evolución del error
            figure(1);
            plot(x,errors);
            dif
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

