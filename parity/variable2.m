%ver ejemplo de google drive


function [V,D,A,difference_weight,s,o,ret] = variable2(E,A,P,s,eta,difference_weight, momentum_activated)

    max_neurons =max(P);
    m = length(P); %layers number
    V = zeros(m, max_neurons + 1); %+1 for the threshold

    alpha = 0.01;
    beta = 0.75;
    
    %the first row of V are the inputs
    aux = zeros(1,length(V(1,:))-length(E)-1);
    if (length(aux)>=1)
        E = [-1 E aux];
        V(1,:) =  E;
    else
        E = [-1 E];
        V(1,:) = E;
    end
  
    %computes outputs 
    i = 1;
    while(i<m)
       membrane_potential = A(:,:,i)*V(i,:)';
       V(i+1,:) =  [-1 tanh(membrane_potential')];
       i=i+1;
    end
       
    %final output
    o = V(m,2);
    
    
    %computes deltas
    D = zeros(m-1,max_neurons);
    D(1,1) = (1-(tanh(membrane_potential(1)))^2) * (s-o);
    %D(1,1) = (s-o);
    
    i=2;
    while(i<m)
       aux = m-i+1;
       %membrane_potential = A(:,:,m-i)*V(m-i,:)';
       auxi = A(:,2:max_neurons+1,aux)'* D(i-1,:)';
       one = ones(1,length(membrane_potential));
       D(i,:) = (one-(tanh(membrane_potential')).^2) .* auxi';
       %D(i,:) = auxi';
       i=i+1;
    end
    

   %actualizo los pesos de la primera matriz porque uso E en vez de V
    j = 1;
    while(j <= P(2)) %cantidad de neuronas en la capa siguiente. determina la cantidad de filas en mi matriz.
        k = 1;
        derivative =  -eta * ( beta * (1-(tanh(beta *  A(j,1:P(1)+1,1) *  E(1:P(1)+1)'))^2) );
        while(k <= P(1) + 1) %cantidad de neuronas en mi capa + 1. determina la cantidad de columnas en mi matriz.
            %derivada = beta * (1-(tanh(beta *  A(j,1:P(1)+1,1) * E' ))^2)
            if(momentum_activated == 1)
                momentum_weight = difference_weight(j,k,1)*alpha;
                delta_W  = derivative * D(length(P)-1,j) * E(k) + momentum_weight; %segundo termino es momentum
                difference_weight(j,k,1) = delta_W;
                A(j, k, 1) = A(j, k, 1) + delta_W;
            else
                A(j, k, 1) = A(j, k, 1) + eta * D(length(P)-1,j) * E(k);
            end
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
            derivative =  -eta * ( beta * (1-(tanh(beta *  A(j,1:P(i)+1,i) * V(i-1,1:P(i)+1)'))^2) );
            while(k <= P(i) + 1) %cantidad de neuronas en mi capa + 1. determina la cantidad de columnas en mi matriz.
                if(momentum_activated == 1)
                    momentum_weight =  difference_weight(j,k,i)*alpha;
                    delta_W  = derivative * D(length(P)-i,j) * V(i-1,k) + momentum_weight; %segundo termino es momentum
                    difference_weight(j, k,i) = delta_W;
                    A(j, k, i) = A(j, k, i) + delta_W;
                else
                    A(j, k, i) =A(j, k, i) + eta * D(length(P)-i,j) * V(i-1,k);
                end
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
