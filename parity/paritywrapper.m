%entrena a una red iterativamente
%para xor con unidad no lineal tangente hiperbÃ³lica

function [V,D,W,W2,s,o,count] = paritywrapper(patterns,S,W,W2,etta,err)



count = 0;
error = inf;
errors = 0;
x=count;
while(error > err)
	i=1;
	error = 0;
	while(i<=size(patterns,1))
		[V,D,W,W2,s,o,ret] = parity(patterns(i,:),W,W2,S(i),etta,0);
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

%ejemplo con 3 entradas
%[V,D,W,W2,s,o,count] = paritywrapper([0 0 0; 1 1 1; 1 0 0; 0 0 1; 0 1 1; 1 0 1; 1 1 0; 0 1 0],[1 0 0 0 1 1 1 0],[0.23 0.23 0.32 0.1; 0.4 0.3 0.1 0.2; 0.2 0.12 0.35 0.2],[0.3 0.2 0.12 0.21],0.02,0.001)
% test: [V,D,W,W2,s,o,ret] = parity([1 0 1],W,W2,1,0.02)