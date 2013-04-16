%pueba si la red neuronal aprendió a determinar la paridad de 2 a 5 
%entradas

function [V,D,W,W2,s,o,count] = testparitycluster(W,W2,etta,err)


patters2 = [0 0 1; 0 1 0; 1 0 0; 1 1 1];
patters3 = [0 0 0 1; 0 0 1 0; 0 1 0 0 ; 0 1 1 1; 1 0 0 0; 1 0 1 1;1 1 1 0];
patters4 = [0 0 0 0 1; 0 0 0 1 0; 0 0 1 0 0; 0 0 1 1 1;0 1 0 0 1;0 1 0 1 1; 0 1 1 1 0; 1 0 0 0 1; 1 0 0 1 1; 1 0 1 1 0; 1 1 1 1 1];
patters5 = [0 0 0 0 0 1; 0 0 0 0 1 0; 0 0 0 1 0 0; 0 0 0 1 1 1;0 0 1 0 0 0; 0 0 1 0 1 1; 0 0 1 1 1 0;0 1 0 0 0 0; 0 1 0 0 1 1; 0 1 0 1 1 0; 0 1 1 1 1 1; 1 0 0 0 0 0; 1 0 0 0 1 1; 1 0 0 1 1 1;1 0 1 1 1 0; 1 1 1 1 1 0];
testing = [patters2 patters3 patters4 patters5]


index = size(W,2) -1 -1; %resto 1 por el umbral y otro para que de bien el 
%index en el vector testing

count = 0;
error = inf;
errors = 0;
x=count;
while(error > err)
	i=1;
	error = 0;
	while(i<=size(patterns,1))
		[V,D,W,W2,s,o,ret] = parity(patterns(i,:),W,W2,S(i),etta);
		i=i+1;
		error = error + (s-o)^2;
    end
	error = error / size(patterns,1); 
    errors = [ errors error ];
    x = [x count];
	count = count+1;
	i = i+1;
	error
end


%imprimo la evolición del error
plot(x,errors);

end

