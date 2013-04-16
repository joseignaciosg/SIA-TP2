%E vector de entradas
%W  matriz de pesos de la entras mas el umbral
%W2 vector de pesos para la salida mas el umbral
%etta factor de aprendizaje
%S salidas esperadas 

function [V,D,W,W2,s,o,ret] = prediction1(E,W,W2,s,etta,fixed)

E = [-1 E];
i=1;
%V=[0 0 0];
V(1) =0;V(2) =0;
%se calculan las salidas de la primera capa
while(i<=size(W,1))
	V(i) = tanh(W(i,:) * E');
	i=i+1;	
end

%agregando el umbral de la capa oculta
V = [-1 V]; 

%se calcula la salida final
x = W2 * V';
o =  tanh(x);

D(1) =0;
if ( fixed == 0 )
    %se calcula los deltas
    D(1) = (1-(tanh(x)^2))*(s-o); %delta inicial
    i=2;
    while (i<=length(V))
        x = W(i-1,:)* E';
        D(i) = (1-(tanh(x)^2)) * D(1) * W2(i);
        i=i+1;
    end

    %se modifican los pesos entre la capa oculta y la salida
    i=1;
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
end 

if (s == 1)
	if ( o >= 0.5)
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

%usar etta = 0.02




end

