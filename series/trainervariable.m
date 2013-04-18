%entrena a una red iterativamente
%para xor con unidad no lineal tangente hiperbÃ³lica
%correr así ejemplo: variablewrapper([2 2 1],0.045,1e-2)

function [V,D,A,s,o,count,dif] = trainervariable(series,P,eta,err)

%patterns = [-1 0 0;
%-1 0 1;
%-1 1 0;  
%-1 1 1;];
%p=[0 1 1 0];
count = 0;
lower_edge = -0.5;
upper_edge = 0.5;
windowsize = P(1);

%inicializar vector de matrices
m = max(P);
A = rand(m,m+1,length(P)-1);

dif = 10;
old = 11;
threshold = 50000;
errors = [];
x = [];
while(dif > err && threshold > 0 && abs(dif-old) > 1e-6)
	i=1;
	old = dif;
	dif = 0;
	while(i<=length(series)-windowsize)
		[V,D,A,s,o] = variable(series(i:i+windowsize-1),A,P,series(i+windowsize),eta);
		i=i+windowsize;
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
