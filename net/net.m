function [V,D,A,s,o,count,dif] = net (series, net_configuration, function_type, epochs, error, lrn_rate, lrn_type, alpha, momentum_activated, beta, shuffle, lrn_limit)

	%	series representa la serie a analizar para poder predecirla.
	%	net_configuration corresponde a un vector ej: [3 5 2 1] en donde 3 son los parametros.
	%	de entrada, 5 neuronas en la 1er capa oculta, 2 neuronas en la 2da capa oculta y 1 de salida.
	%	function_type corresponde al tipo de función con la que se va a analizar el problema.
	%	epochs corresponde a la cantidad de epocas a correr el algoritmo.
	%	error se refiere al error a cometer en la aproximacion.
	%	lrn_rate corresponde al factor de aprendizaje a usar inicialmente.
	%	lrn_type corresponde al tipo de aprendizaje que será simulado.
	%	alpha corresponde al factor para el momentum.
	%	momentum_activated activa o desactiva esta funcionalidad.
	%	beta permite ingresar como parametro el beta a utilizar para la funcion sigmoidea
	% 	shuffle si se desea mezclar los patrones

	global etta_limit;
	etta_limit = lrn_limit;

	%
	%	COMANDO HELP
	%

	if (strcmp(function_type, 'help'))
		disp('\nInvocar como net (SERIE, NET_CONFIGURATION, FUNCTION_TYPE, EPOCHS, ERROR, LRN_RATE, LRN_TYPE, ALPHA, MOMENTUM_ACTIVATED, BETA, SHUFFLE)\n');
		disp('\nNET_CONFIGURATION = [3 5 2 1] corresponderá a "3" son los parametros de entrada, "5" las neuranas en la primer capa oculta, "2" neuronas en la segunda capa oculta y "1" de salida. \n');
		disp('\nFUNCTION_TYPE = [tanh,exponencial]\n');
		disp('\nERROR = Error buscado, valor abitrario determinado por el usuario\n');
		disp('\nLEARN_RATE = Valor entre 0 y 1\n');
		disp('\nLEARN_TYPE = [constante, annealed, dinamico]\n');
		disp('\nALPHA = Valor entre 0 y 1\n');
		disp('\nMOMENTUM_ACTIVATED = 1 para activarlo, 0 para no utilizarlo\n');
		disp('\nBETA = Valor entre 0 y 1\n');
		disp('\nSHUFFLE = 0 para no mezclar, 1 para hacerlo.\n');
		return;
	end

	%
	%	ITERO SOBRE LOS TIPOS DE FUNCIONES DE TRANSFERENCIA
	%	SI NO ES CORRECTA ENTONCES ABORTA
	%

	%fucntion_type = tolower(function_type);
	if(strcmp(function_type, 'tanh'))
		disp('\nUsando la funcion de transferencia TANH\n');
		function_type = 1;
	elseif (strcmp(function_type, 'exponencial'))
		disp('\nUsando la funcion de transferencia EXPONENCIAL\n');
		function_type = 2;
	else
		disp('\nError: Tipo de funcion no reconocida\n\t Ingresar alguna de las siguientes: [tanh, exponencial]\n');
		return;
	end

	%
	%	ITERO SOBRE LOS TIPOS DE APRENDIZAJE
	%	SI NO ES CORRECTA ENTONCES ABORTA
	%

	if(strcmp(lrn_type, 'constante'))
		disp('\nUsando CONSTANTE como metodo de aprendizaje\n');
		lrn_type = 1;
	elseif (strcmp(lrn_type, 'annealed'))
		disp('\nUsando ANNEALED como metodo de aprendizaje\n');
		lrn_type = 2;
	elseif (strcmp(lrn_type, 'dinamico'))
		disp('\nUsando DINAMICO como metodo de aprendizaje\n');
		lrn_type = 3;
	else
		disp('\nError: Metodo de aprendizaje invalido.\n\tAbortando ejecución. Ingrese un tipo valido: [constante, annealed, dinamico]\n');
		return;
	end

	if ( momentum_activated == 1)
		disp('\nMomentum ACTIVADO!\n');
	else
		disp('\nMomentum DESACTIVADO!\n');
	end

	if ( shuffle == 1)
		disp('\nShuffle ACTIVADO!\n');
	else
		disp('\nShuffle DESACTIVADO!\n');
	end

disp('\nOtros Parametros:\n');
disp( sprintf( '\nEta inicial: %d\n', lrn_rate ) );
disp( sprintf( '\nBeta: %d\n', beta ) );
disp( sprintf( '\nAlpha: %d\n', alpha ) );
disp( sprintf( '\nEpochs: %d\n', epochs ) );
disp( sprintf( '\nError: %d\n', error ) );

	%
	%	Llamo a la funcion correspondiente con los parametros ingresados para que realice la simulacion.
	%

	if(function_type == 1)
		[V,D,A,s,o,count,dif] = serietrainer(series,net_configuration, lrn_rate, error, lrn_type, momentum_activated, epochs,shuffle, alpha, beta);
	else
		[V,D,A,s,o,count,dif] = serietrainer(series,net_configuration, lrn_rate, error, lrn_type,momentum_activated, epochs, shuffle, alpha, beta);
	end

end