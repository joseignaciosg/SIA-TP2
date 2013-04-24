%pueba si la red neuronal aprendió a determinar la paridad de 2 a 5 
%entradas

function [count] = testtrainer(series,A,P,error,beta)

%maximo valor de P para formar la matriz
m = max(P);

windowsize = P(1);

index = P(1) -1; %resto -1 para que de bien el index en el vector testing

%Series a tomar en cuenta para entrenamiento

series1 = series;
series = (series + 3.8)./7.6;

%Variables
x = [];
os=[];
ss=[];
diffs = [];
diffs2 = [];
count = 0;

max_diff = 0;
min_diff = inf;
diff = 0;
diff2 = 0;

acceptable_values=0;
while(count < 1)
    i=1;
	while(i<=(length(series)-windowsize))
		s = series(i+windowsize);
		[s,o] = variable4testingexp(series(i:i+windowsize-1),A,P,s,beta);
		i=i+1;
		final_s = (s .*7.6) - 3.8;
		final_o = (o .*7.6) - 3.8;

		os = [os final_o];
    	ss = [ss final_s];
    	x = [i x];
        diff = abs(final_s-final_o);
        diff2 = final_s-final_o;
        diffs = [diffs diff];
        diffs2 = [diffs2 diff2];
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

subplot(2,2,1);
plot(x,ss,'b');
title('serie original')
xlabel('muestras')

subplot(2,2,2)
plot(x,os,'g');
title('serie predecida')
xlabel('muestras')



meanS = mean(ss)
meanPredicted = mean(os)
STDS = std(ss)
STDPredicted = std(os)

%show the error
subplot(2,2,3)
plot(x,diffs,'r');
title('errores en valor absoluto')
xlabel('muestras')
ylabel('error')

subplot(2,2,4)
hist(diffs2,10);
title('hostograma de errores')
xlabel('error')
ylabel('ocurrencias')

min_diff
max_diff
meanError = mean(diffs)
acceptable_values
i
end

