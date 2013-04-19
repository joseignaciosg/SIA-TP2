%pueba si la red neuronal aprendió a determinar la paridad de 2 a 5 
%entradas

function [V,D,A,s,o,count,dif] = serietrainer(series,P, etta, err, dinamic_learning,momentum_activated)


patters2 = [0 0 1; 0 1 0; 1 0 0; 1 1 1];
patters3 = [0 0 0 1; 0 0 1 0; 0 1 0 0 ; 0 1 1 1; 1 0 0 0; 1 0 1 1;1 1 1 0];
patters4 = [0 0 0 0 1; 0 0 0 1 0; 0 0 1 0 0; 0 0 1 1 1;0 1 0 0 1;0 1 0 1 1; 0 1 1 1 0; 1 0 0 0 1; 1 0 0 1 1; 1 0 1 1 0; 1 1 1 1 1];
patters5 = [0 0 0 0 0 1; 0 0 0 0 1 0; 0 0 0 1 0 0; 0 0 0 1 1 1;0 0 1 0 0 0; 0 0 1 0 1 1; 0 0 1 1 1 0;0 1 0 0 0 0; 0 1 0 0 1 1; 0 1 0 1 1 0; 0 1 1 1 1 1; 1 0 0 0 0 0; 1 0 0 0 1 1; 1 0 0 1 1 1;1 0 1 1 1 0; 1 1 1 1 1 0];
field1 = 'p1'; value1 = patters2;
field2 = 'p2'; value2 = patters3;
field3 = 'p3'; value3 = patters4;
field4 = 'p4'; value4 = patters5;
testing = struct(field1, value1,field2, value2,field3, value3,field4, value4);

%inicializar vector de matrices
m = max(P);
A = rand(m,m+1,length(P)-1)./100;


windowsize = P(1);

index = P(1) -1; %resto -1 para que de bien el 
%index en el vector testing

patterns = testing.(strcat('p',num2str(index)));
DP = zeros(m,m+1,length(P)-1); %Delta_Peso

cols = size(patterns,2);
dif = 10;
old = 11;
threshold = 50000;
errors = [];
x = [];
count = 0;

cuadratic_errors = 0;
cuadratic_error = 0;
contar = 0;

while(dif > err && threshold > 0 && abs(dif-old) > 1e-10)
	i=1;
	old = dif;
	dif = 0;
	while(i<=(length(series)-windowsize))
      %  pattern = patterns(i,1:cols-1);
      %  s = patterns(i,cols:cols);
		[V,D,A,s,o DP] = variable(series(i:i+windowsize-1),A,P,series(i+windowsize),etta,DP,momentum_activated);
		
		i=i+1;
		cuadratic_error = cuadratic_error + (s-o)^2;
		dif = dif + (s-o)^2;
    end
	dif = dif / 4; % four patterns;
    dif
    errors = [dif errors];
    x = [count x];
    cuadratic_errors = [cuadratic_errors cuadratic_error/4];
    if( dinamic_learning == 1)
    	[eta contar] = update_lrn_rate ( etta, cuadratic_error/4, cuadratic_errors(length(cuadratic_errors)-1), contar);
	end
    if (mod(count,10) == 0)
            %imprimo la evolución del error
            figure(1);
            plot(x,errors);
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

