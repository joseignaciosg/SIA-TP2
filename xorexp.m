%E vector de entradas con -1 adelante para el umbral
%W  matriz de pesos de la entras mas el umbral
%W2 vector de pesos para la salida mas el umbral
%etta factor de aprendizaje
%S salidas esperadas 

function [V,D,W,W2,s,o,ret] = xorexp(E,W,W2,s,etta)

i=1;
V(1)=0;V(2)=0;
%se calculan las salidas de la primera capa
E = [-1 E];
while(i<=size(W,1))
    x = W(i,:) * E';
	V(i) = 1/(1+exp(-x));
	i=i+1;	
end

%agregando el umbral de la capa oculta
V = [-1 V]; 

%se calcula la salida final
o = 1/(1+exp(-W2*V'));


%se calcula los deltas
x = W2*V';
y = 1/(1+exp(-x));
D(1) = y*(1-y)*(s-o); %delta inicial

i=2;
while (i<=length(V))
    x = W(i-1,:)*E';
    y = 1/(1+exp(-x));
    D(i) = y*(1-y) * (W2(i) *D(1));
	i=i+1;
end

%se modifican los pesos entre la capa oculta y la salida
i=1;
x = W2*V';
while (i<=length(W2))
    W2(i) = W2(i) + etta*D(1)*V(i);
	i=i+1;
end


%se modifican los pesos entre la capa de entrada y la oculta
i=1;
while (i<=size(W,1))
	j=1;
	while(j<=size(W,2))	
        W(i,j) = W(i,j) + etta*D(i+1)*E(j);
		j=j+1;
	end
	i=i+1;
end

if (s == 1)
	if ( o > 0.5)
		ret = 1;
	else
		ret = 0;
	end
else
	if ( o< 0.5)
            ret = 1;
        else
   	        ret = 0;
        end
end




end

