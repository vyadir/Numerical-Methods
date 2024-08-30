% Configuración necesaria
pkg load symbolic;
format long g;
warning off all;

% Iniciar el diario para guardar la salida en un archivo
diary('output.txt');  % Especifica el archivo de salida

% Definición de la función f(t)
syms x;
f = 1 - (70/3) * exp(-0.35 * x) + (49/3) * exp(-0.8 * x);

% Aproximaciones iniciales
t0_biseccion = 8;
t1_biseccion = 10;
t0_secante = 8;
t1_secante = 10;
t0_NR = 9;
t0_puntoFijo = 9;

% Tolerancia y máximo número de iteraciones
tol = 10^(-100);
iterMax = 1000;

% Bisección
disp('Método de Bisección:');
[mBis, tiempo_biseccion] = Biseccion(f, t0_biseccion, t1_biseccion, iterMax, tol);
disp(mBis);
disp(['Tiempo de ejecución: ', num2str(tiempo_biseccion), ' segundos']);
disp('--------------------------------------------------------');

% Falsa Posición
disp('Método de Falsa Posición:');
tic;
[mFP, tiempo_falsa_posicion] = FalsaPosicion(f, t0_biseccion, t1_biseccion, iterMax, tol);
toc;
disp(mFP);
disp(['Tiempo de ejecución: ', num2str(tiempo_falsa_posicion), ' segundos']);
disp('--------------------------------------------------------');

% Secante
disp('Método de la Secante:');
tic;
[mSec, tiempo_secante] = Secante(f, t0_secante, t1_secante, iterMax, tol);
toc;
disp(mSec);
disp(['Tiempo de ejecución: ', num2str(tiempo_secante), ' segundos']);
disp('--------------------------------------------------------');

% Newton-Raphson
disp('Método de Newton-Raphson:');
tic;
[mNR, tiempo_NR] = NewtonRaphson(f, t0_NR, iterMax, tol);
toc;
disp(mNR);
disp(['Tiempo de ejecución: ', num2str(tiempo_NR), ' segundos']);
disp('--------------------------------------------------------');

% Punto Fijo
% Reformulación de la función para el método de Punto Fijo
g = @(x) log((3/70) + (7/10) * exp(-0.8 * x)) / -0.35;
disp('Método de Punto Fijo:');
tic;
[mPF, tiempo_puntoFijo] = PuntoFijo(g, t0_puntoFijo, iterMax, tol);
toc;
disp(mPF);
disp(['Tiempo de ejecución: ', num2str(tiempo_puntoFijo), ' segundos']);
disp('--------------------------------------------------------');

% Cerrar el diario
diary off;
