%pueba si la red neuronal aprendió a determinar la paridad de 2 a 5 
%entradas

function testparitycluster(A, P, etta, err)


patters2 = [0 0 1; 0 1 0; 1 0 0; 1 1 1];
patters3 = [0 0 0 1; 0 0 1 0; 0 1 0 0 ; 0 1 1 1; 1 0 0 0; 1 0 1 1;1 1 1 0];
patters4 = [0 0 0 0 1; 0 0 0 1 0; 0 0 1 0 0; 0 0 1 1 1;0 1 0 0 1;0 1 0 1 1; 0 1 1 1 0; 1 0 0 0 1; 1 0 0 1 1; 1 0 1 1 0; 1 1 1 1 1];
patters5 = [0 0 0 0 0 1; 0 0 0 0 1 0; 0 0 0 1 0 0; 0 0 0 1 1 1;0 0 1 0 0 0; 0 0 1 0 1 1; 0 0 1 1 1 0;0 1 0 0 0 0; 0 1 0 0 1 1; 0 1 0 1 1 0; 0 1 1 1 1 1; 1 0 0 0 0 0; 1 0 0 0 1 1; 1 0 0 1 1 0;1 0 1 1 1 1; 1 1 1 1 1 0];
field1 = 'p1'; value1 = patters2;
field2 = 'p2'; value2 = patters3;
field3 = 'p3'; value3 = patters4;
field4 = 'p4'; value4 = patters5;
testing = struct(field1, value1,field2, value2,field3, value3,field4, value4);

m = P(1);

index = m -1; %resto -1 para que de bien el 
%index en el vector testing


patterns = testing.(strcat('p',num2str(index)));


cols = size(patterns,2);
i=1;
fail =0;
while(i<=size(patterns,1)) 
    pattern = patterns(i,1:cols-1);
    s = patterns(i,cols:cols);
	[V,D,A,s,o,ret] = variable(pattern,A,P,s,etta);
	i=i+1;
    if(ret == 0)
        disp('Falló el partron:')
        pattern
        s
        o
        fail=1;
     end
end

if (fail == 0)
     disp('PASAN TODOS LOS PATRONES!!!')
else
     disp('NO PASAN TODOS LOS PATRONES!!!')
end

end

