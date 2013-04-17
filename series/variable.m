%E vector de entradas con -1 adelante para el umbral
%A matriz de pesos
%P vector de neuronas por capa
%etta factor de aprendizaje
%S salidas esperadas 

function V,D,A,s,o = variable(E,A,P,s,eta)

m=max(P);
V=zeros(length(P)-1, m + 1);
V(:,1) = -1; %el primer elemento de cada fila es -1 porque corresponde al umbral

i = 1;
while(i <= P(2))
	V(1,i+1) = tanh(A(i,1:P(1)+1,1) * E');
	i++;
endwhile

%se calculan las salidas de las demas capas usando como entrada las salida de las anteriores
i = 2;
while(i < length(P))
	j = 1;
	while(j <= P(i+1))
		V(i,j+1) = tanh(A(j,1:P(i)+1,i) * V(i-1,1:P(i)+1)');
		j++;
	endwhile
	i++;
endwhile

%se calcula la salida final
o = V(length(P)-1,2);

%se calculan los deltas
D = zeros(length(P)-1, m);
D(1,1) = (s-o); %delta inicial
i=2;%filas de D
while (i < length(P))
	k = 1;% ds en mi capa. columnas de la matriz D
	while( k <= P(length(P) - i + 1) )
		j = 1;% valores en V; ds en la capa anterior
		while (j <= P(length(P) - i + 2) )
			D(i,k) += D(i-1,j) * A(P(length(P) - i + 2),k+1,i);
			j++;
		endwhile
		k++;
	endwhile
	i++;
endwhile

%actualizo los pesos de la primera matriz porque uso E en vez de V
j = 1;
while(j <= P(2)) %cantidad de neuronas en la capa siguiente. determina la cantidad de filas en mi matriz.
	k = 1;
	while(k <= P(1) + 1) %cantidad de neuronas en mi capa + 1. determina la cantidad de columnas en mi matriz.
		A(j, k, 1) += eta * (1-(tanh( A(j,1:P(1)+1,1) * E' ))**2) * D(length(P)-1,j) * E(k);
		k++;
	endwhile
j++;
endwhile

%actualizo las matrices de pesos
i = 2;
while(i < length(P)) %cantidad de matrices
	j = 1;
	while(j <= P(i + 1)) %cantidad de neuronas en la capa siguiente. determina la cantidad de filas en mi matriz.
		k = 1;
		while(k <= P(i) + 1) %cantidad de neuronas en mi capa + 1. determina la cantidad de columnas en mi matriz.
			A(j, k, i) += eta * (1-(tanh( A(j,1:P(i)+1,i) * V(i-1,1:P(i)+1)' ))**2) * D(length(P)-i,j) * V(i-1,k);
			k++;
		endwhile
	j++;
	endwhile
i++;
endwhile

ret = 0;
if (s == 1)
	if ( o >= 0.5)
		ret = 1;
	endif
else
	if ( o < 0.5)
                ret = 1;
        endif
endif


endfunction
