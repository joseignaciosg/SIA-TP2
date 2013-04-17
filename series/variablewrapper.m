%entrena a una red iterativamente
%para xor con unidad no lineal tangente hiperbólica

function V,D,A,s,o,count,dif = variablewrapper(P,eta,err)

patterns = [-1 0 0;
-1 0 1;
-1 1 0;  
-1 1 1;];
p=[0 1 1 0];
count = 0;
lower_edge = -0.5;
upper_edge = 0.5;

%inicializar vector de matrices
m = max(P);
A = zeros(m,m+1,length(P)-1);
%for i = 1 : length(P) - 1
%	A(:,:,i) = unifrnd(lower_edge, upper_edge, m, m+1);
%endfor

A(:,:,1)=[0.32 0.42 0.76; 0.43 0.12 0.79];
A(:,:,2)=[0.67 0.23 0.41; 0 0 0];

dif = 10;
old = 11;
threshold = 50000;
while(dif > err && threshold > 0 && abs(dif-old) > 1e-6)
	i=1;
	old = dif;
	dif = 0;
	while(i<=rows(patterns))
		[V,D,A,s,o] = variable(patterns(i,:),A,P,p(i),eta);
		i++;
		dif = dif + (s-o)^2;
	endwhile
	dif = dif / 4; % four patterns;
	count ++;
	threshold--;
endwhile

if(threshold <= 0 || (old - dif)<1e-6)
	disp("Solution not reached");
	disp("old");disp(old);
	disp("dif");disp(dif);
endif

endfunction
