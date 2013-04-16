%entrena a una red iterativamente
%para xor con unidad no lineal tangente hiperbólica

function [V,D,W,W2,s,o,count] = xortanwrapper(W,W2,etta,err)

patterns = [-1 0 0 ; 
	   -1 0 1 ;
	   -1 1 0 ;
	   -1 1 1 ];
p=[0 1 1 0];
count = 0;
error = inf;
while(error > err)
	i=1;
	error = 0;
	while(i<=size(patterns,1))
		[V,D,W,W2,s,o,ret] = xorexp(patterns(i,:),W,W2,p(i),etta);
		i=i+1;
		error = error + (s-o)^2;
    end
	error = error / 4; % four patterns;
	count = count+1;
	i = i+1;
	error
end

end
