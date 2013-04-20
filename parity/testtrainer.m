%pueba si la red neuronal aprendió a determinar la paridad de 2 a 5 
%entradas

function [count] = testtrainer(series,A,P)


%maximo valor de P para formar la matriz
m = max(P);

windowsize = P(1);

index = P(1) -1; %resto -1 para que de bien el index en el vector testing

%Series a tomar en cuenta para entrenamiento
series1 = series;
series = series./3.8;

%Variables
x = [];
os=[];
ss=[];
count = 0;

while(count < 1)
	i=1;
	while(i<=(length(series)-windowsize))
		s = series(i+windowsize);
		[s,o] = variable4testing(series(i:i+windowsize-1),A,P,s);
		i=i+1;
		final_s = s * 3.8;
		final_o = o * 3.8;
		os = [os final_o];
    	ss = [ss final_s];
    	x = [i x];
    end
	count = count+1;
end

figure(1);
plot(x,os,x,series1(:,5:length(series1)));

end

