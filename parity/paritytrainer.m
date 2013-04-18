%pueba si la red neuronal aprendió a determinar la paridad de 2 a 5 
%entradas

function [V,D,A,s,o,count,dif] = paritytrainer(P, etta, err)


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
A = rand(m,m+1,length(P)-1);



index = P(1) -1; %resto -1 para que de bien el 
%index en el vector testing

patterns = testing.(strcat('p',num2str(index)));

cols = size(patterns,2);
dif = 10;
old = 11;
threshold = 50000;
errors = [];
x = [];
count = 0;
while(dif > err && threshold > 0 && abs(dif-old) > 1e-6)
	i=1;
	old = dif;
	dif = 0;
	while(i<=size(patterns,1))
        pattern = patterns(i,1:cols-1);
        s = patterns(i,cols:cols);
		[V,D,A,s,o] = variable(pattern,A,P,s,etta);
		i=i+1;
		dif = dif + (s-o)^2;
        
    end
	dif = dif / 4; % four patterns;
    dif
    errors = [dif errors];
    x = [count x];
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

