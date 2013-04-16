% TODO BUCKET LIST: 		
%			Hacer una funcion que haga un shuffel dado unos patrones de entrenamientos
%			Hacer funcion que evalue dada la entrada y retorne la salida
%			Hacer funcion que te devuela los deltas
%			Hacer funcion que te acomode los pesos
%
%								A LABURAR VAGOS
%

function main (net_configuration, op_type, function_type, epochs, lrn_rate, lrn_type )

	%	net_configuration corresponde a un vector ej: [3 2 1] en donde 3 son los parametros
	%	de entrada, 2 neuronas en la capa oculta y 1 de salida.
	%	op_type correponde al problema a analizar
	%	function_type corresponde al tipo de función con la que se va a analizar el problema
	%	epochs corresponde a la cantidad de epocas a correr el algoritmo
	%	lrn_rate corresponde al factor de aprendizaje a usar inicialmente.
	%	lrn_type corresponde al tipo de aprendizaje que será simulado.
	%	Un ejemplo de llamado de la función sería: TODO!


	%
	%	COMANDO HELP
	%

	if (strcmp(tolower(operator_type), 'help'))
		printf('\nInvocar como TODO!***\n');
		printf('\nNET_CONFIGURATION = [3 2 1] corresponderá a "3" son los parametros
	% de entrada, "2" neuronas en la capa oculta y "1" de salida. \n');
		printf('\nFUNCTION_TYPE = [escalon, lineal, sigmoidea]\n');
		printf('\nLEARN_TYPE = [constante, dinamico]\n');
		return;
	endif

	%
	%	ITERO SOBRE LOS TIPOS DE FUNCIONES DE TRANSFERENCIA
	%	SI NO ES CORRECTA ENTONCES ABORTA
	%

	fucntion_type = tolower(function_type);
	if(strcmp(function_type, 'escalon'))
		printf('\nUsando la funcion de transferencia ESCALON\n');
		function_type = 1;
	elseif (strcmp(function_type, 'lineal'))
		printf('\nUsando la funcion de transferencia LINEAL\n');
		function_type = 2;
	elseif (strcmp(function_type, 'sigmoidea'))
		printf('\nUsando la funcion de transferencia SIGMOIDEA\n');
		function_type = 3;
	else
		printf('\nError: Tipo de funcion no reconocida\n\t Ingresar alguna de las siguientes: [escalon, lineal, sigmoidea]\n');
		return;
	endif

	%
	%	ITERO SOBRE LOS TIPOS DE APRENDIZAJE
	%	SI NO ES CORRECTA ENTONCES ABORTA
	%

	if(strcmp(tolower(lrn_type), 'constante'))
		printf('\nUsando CONSTANTE como metodo de aprendizaje\n');
		lrn_type = 1;
	elseif (strcmp(tolower(lrn_type), 'annealed'))
		printf('\nUsando DINAMICO como metodo de aprendizaje\n');
		lrn_type = 2;
	else
		printf('\nError: Metodo de aprendizaje invalido.\n\tAbortando ejecución. Ingrese un tipo valido: [constante, dinamico]\n');
		return;
	endif

	%
	%	ITERO SOBRE LAS EPOCAS, Luego sobre los set de entrenamiento, luego hago los calculos.
	%

	for i = 1:epochs 

	end

	%
	%	IMPRIMO ESTADÍSTICAS (TODO!)
	%


	%
	%	IMPRIMO GRÁFICOS (TODO!)
	%


endfunction