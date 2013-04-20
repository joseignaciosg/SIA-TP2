%ver ejemplo de google drive


function [V,D,A,s,o,ret] = variable2(E,P,s,etta)

    max_neurons =max(P);
    m = length(P); %layers number
    V = zeros(m, max_neurons + 1); %+1 for the threshold

    %TODO: SACAR
    A = randommatrix(P,4);
   
    %the first row of V are the inputs
    aux = zeros(1,length(V(1,:))-length(E)-1);
    if (length(aux)>1)
        V(1,:) = [-1 E aux];
    else
        V(1,:) = [-1 E ];
    end
  
    %computes outputs
    i = 1;
    while(i<m)
       membrane_potential = A(:,:,i)*V(i,:)';
       V(i+1,:) =  [-1 tanh(membrane_potential')];
       i=i+1;
    end
       
    %output
    o = V(m,2);
    
    V 
    
    %computes deltas
    D = zeros(m-1,max_neurons);
    D(1,1) = (1-(tanh(membrane_potential(1)))^2) * (s-o);
    
    i=2;
    while(i<m)
       aux = m-i+1;
       membrane_potential = A(:,:,m-2)*V(aux,:)';
       auxi = A(:,2:max_neurons+1,aux)'* V(aux,2:max_neurons+1)';
       one = ones(1,length(membrane_potential));
       D(i,:) = (one-(tanh(membrane_potential')).^2) * auxi;
       i=i+1;
    end
    
    D
    
    %TODO : computes new weights
    %i=1;
    %while(i<m)
    %    A(:,:,m-i-1)' = A(:,:,m-i-1)'
    %end
    
    %actualizo los pesos de la primera matriz porque uso E en vez de V
    j = 1;
    while(j <= P(2)) %cantidad de neuronas en la capa siguiente. determina la cantidad de filas en mi matriz.
        k = 1;
        while(k <= P(1) + 1) %cantidad de neuronas en mi capa + 1. determina la cantidad de columnas en mi matriz.          
            A(j, k, 1) = A(j, k, 1) + etta * D(length(P)-1,j) * V(1,k);
            k = k+1;
        end
    j=j+1;
    end
    
    %actualizo las matrices de pesos
    i = 2;
    while(i < length(P)) %cantidad de matrices
        j = 1;
        while(j <= P(i + 1)) %cantidad de neuronas en la capa siguiente. determina la cantidad de filas en mi matriz.
            k = 1;
            while(k <= P(i) + 1) %cantidad de neuronas en mi capa + 1. determina la cantidad de columnas en mi matriz.
                A(j, k, i) =A(j, k, i) + etta * D(length(P)-i,j) * V(i-1,k);   
                k=k+1;
            end
        j=j+1;
        end
    i=i+1;
    end
    
    ret = 0;
    if (s == 1)
        if ( o >= 0.5)
            ret = 1;
        end
    else
        if ( o < 0.5)
                    ret = 1;
        end
    end


end
