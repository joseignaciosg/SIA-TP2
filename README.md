SIA_TP2

Para poder correr el programa invocar la función net como:

net (SERIE, NET_CONFIGURATION, FUNCTION_TYPE, EPOCHS, ERROR, LRN_RATE, LRN_TYPE, ALPHA, MOMENTUM_ACTIVATED, BETA, SHUFFLE, LRN_LIMIT)

Donde: 

	SERIE = La serie determinada por un vector con números. Generalmente de longitud 1000.
	NET_CONFIGURATION = [3 5 2 1] corresponderá a "3" son los parametros de entrada, "5" las neuranas en la primer capa oculta, "2" neuronas en la segunda capa oculta y "1" de salida. 
	FUNCTION_TYPE = [tanh,exponencial]
	ERROR = Error buscado, valor abitrario determinado por el usuario
	LEARN_RATE = Valor entre 0 y 1
	LEARN_TYPE = [constante, annealed, dinamico]
	ALPHA = Valor entre 0 y 1
	MOMENTUM_ACTIVATED = 1 para activarlo, 0 para no utilizarlo
	BETA = Valor entre 0 y 1
	SHUFFLE = 0 para no mezclar, 1 para hacerlo.
	LRN_LIMIT = En caso de usar annealed como metodo de aprendizaje detemrina cada cuantos pasos se actualiza eta. 

Un ejemplo de invocación:

[V,D,A,s,o,count,dif] = net(x, [3 9 6 4 1], 'tanh', 500, 0.00000001, 0.2, 'dinamico', 0.9, 0, 0.5, 0, 30)

En este caso se corre la serie cargada en la variable x, con una configuración de Neurona [3,9,5,4,1], (3 capas ocultas). Con la función tangencial, 500 epocas, un error de cuadratico medio de corte de 0.00000001, eta igual a 0.2 con aprendizaje dinámico, alpha igual a 0.9 con momentum desactivado, un beta de 0.5, sin shuffle y con un LRN_LIMIT = 30 pero que en este caso al no ser annealed el LRN_TYPE no influye en la ejecución.

Luego para Testear la salida del entrenamiento:

En caso de haber usado la función tangencial:

	testtrainer(x(1,(750:1000)),A,P,0.5,0.6)

En caso de haber usado la función exponencial:

	testtrainerexp(x(1,(750:1000)),A,P,0.5,0.5)

el primer parametro es la serie a probar, luego A es la matriz de salida, P es la configuración de red de la llamada anterior [3 9 6 4 1]. El error (0.5) en este caso la función devolverá todos los valores de la aproximación que esten a delta 0.5 del original. y 0.5 es el beta usado en el paso anterior.