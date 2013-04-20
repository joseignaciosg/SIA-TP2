%pueba si la red neuronal aprendió a determinar la paridad de 2 a 5 
%entradas

function [count] = testtrainer(series,A,P,error)


%maximo valor de P para formar la matriz
m = max(P);

windowsize = P(1);

index = P(1) -1; %resto -1 para que de bien el index en el vector testing

%Series a tomar en cuenta para entrenamiento
series = series./3.8;

%Variables
x = [];
os=[];
ss=[];
count = 0;

max_diff = 0;
min_diff = inf;
diff = 0;
acceptable_values=0;
while(count < 1)
    i=1;
	while(i<=(length(series)-windowsize))
		s = series(i+windowsize);
		[s,o] = variable4testing(series(i:i+windowsize-1),A,P,s);
		i=i+1;
		final_s = s * 3.8;
		final_o = o * 3.8;
		os = [os final_s];
    	ss = [ss final_o];
    	x = [i x];
        diff = abs(s-o);
        %diff
        if(max_diff<diff)
            max_diff = diff;
        end
        if(min_diff>diff)
            min_diff = diff;
        end
        if (diff <= error)
            acceptable_values = acceptable_values +1;
        end
        
    end
	count = count+1;
end

figure(1);
plot(x,ss,x,os);
min_diff
max_diff
acceptable_values


end

