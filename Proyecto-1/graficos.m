% Configuración necesaria
pkg load symbolic;
format long g;
warning off all;
% Iniciar el diario para guardar la salida en un archivo
diary('output2.txt');  % Especifica el archivo de salida
% Definición de la función f(t)
syms x;
f = 1 - (70/3) * exp(-0.35 * x) + (49/3) * exp(-0.8 * x);
% Aproximaciones iniciales
t0_biseccion = 8;
t1_biseccion = 10;
t0_secante = 8;
t1_secante = 10;
t0_NR = 8.6;
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
% Graficar iteraciones vs aproximación y error para Bisección
figure('Name', 'Biseccion', 'NumberTitle', 'off');
set(gcf, 'PaperPositionMode', 'auto');
subplot(2,1,1);
plot(mBis(:,1), mBis(:,2), '-o', 'LineWidth', 2, 'MarkerSize', 6);
xlabel('Iteraciones', 'FontSize', 12);
ylabel('Aproximación', 'FontSize', 12);
title('Método de Bisección: Iteraciones vs Aproximación', 'FontSize', 14);
grid on;
subplot(2,1,2);
plot(mBis(:,1), mBis(:,3), '-o', 'LineWidth', 2, 'MarkerSize', 6);
xlabel('Iteraciones', 'FontSize', 12);
ylabel('Error', 'FontSize', 12);
title('Método de Bisección: Iteraciones vs Error', 'FontSize', 14);
grid on;
% Guardar la figura como PNG de alta calidad
print('Biseccion.png', '-dpng', '-r300');
% Falsa Posición
disp('Método de Falsa Posición:');
tic;
[mFP, tiempo_falsa_posicion] = FalsaPosicion(f, t0_biseccion, t1_biseccion, iterMax, tol);
toc;
disp(mFP);
disp(['Tiempo de ejecución: ', num2str(tiempo_falsa_posicion), ' segundos']);
disp('--------------------------------------------------------');
% Graficar iteraciones vs aproximación y error para Falsa Posición
figure('Name', 'FalsaPosicion', 'NumberTitle', 'off');
set(gcf, 'PaperPositionMode', 'auto');
subplot(2,1,1);
plot(mFP(:,1), mFP(:,2), '-o', 'LineWidth', 2, 'MarkerSize', 6);
xlabel('Iteraciones', 'FontSize', 12);
ylabel('Aproximación', 'FontSize', 12);
title('Método de Falsa Posición: Iteraciones vs Aproximación', 'FontSize', 14);
grid on;

subplot(2,1,2);
plot(mFP(:,1), mFP(:,3), '-o', 'LineWidth', 2, 'MarkerSize', 6);
xlabel('Iteraciones', 'FontSize', 12);
ylabel('Error', 'FontSize', 12);
title('Método de Falsa Posición: Iteraciones vs Error', 'FontSize', 14);
grid on;
% Guardar la figura como PNG de alta calidad
print('FalsaPosicion.png', '-dpng', '-r300');
% Secante
disp('Método de la Secante:');
tic;
[mSec, tiempo_secante] = Secante(f, t0_secante, t1_secante, iterMax, tol);
toc;
disp(mSec);
disp(['Tiempo de ejecución: ', num2str(tiempo_secante), ' segundos']);
disp('--------------------------------------------------------');
% Graficar iteraciones vs aproximación y error para Secante
figure('Name', 'Secante', 'NumberTitle', 'off');
set(gcf, 'PaperPositionMode', 'auto');
subplot(2,1,1);
plot(mSec(:,1), mSec(:,2), '-o', 'LineWidth', 2, 'MarkerSize', 6);
xlabel('Iteraciones', 'FontSize', 12);
ylabel('Aproximación', 'FontSize', 12);
title('Método de la Secante: Iteraciones vs Aproximación', 'FontSize', 14);
grid on;

subplot(2,1,2);
plot(mSec(:,1), mSec(:,3), '-o', 'LineWidth', 2, 'MarkerSize', 6);
xlabel('Iteraciones', 'FontSize', 12);
ylabel('Error', 'FontSize', 12);
title('Método de la Secante: Iteraciones vs Error', 'FontSize', 14);
grid on;
% Guardar la figura como PNG de alta calidad
print('Secante.png', '-dpng', '-r300');
% Newton-Raphson
disp('Método de Newton-Raphson:');
tic;
[mNR, tiempo_NR] = NewtonRaphson(f, t0_NR, iterMax, tol);
toc;
disp(mNR);
disp(['Tiempo de ejecución: ', num2str(tiempo_NR), ' segundos']);
disp('--------------------------------------------------------');
% Graficar iteraciones vs aproximación y error para Newton-Raphson
figure('Name', 'NewtonRaphson', 'NumberTitle', 'off');
set(gcf, 'PaperPositionMode', 'auto');

% Limitar a las primeras 20 iteraciones para ver los cambios iniciales
iter_limit = min(size(mNR, 1), 20);
subplot(2,1,1);
plot(mNR(1:iter_limit,1), mNR(1:iter_limit,2), '-o', 'LineWidth', 2, 'MarkerSize', 6);
xlabel('Iteraciones', 'FontSize', 12);
ylabel('Aproximación', 'FontSize', 12);
title('Método de Newton-Raphson: Iteraciones vs Aproximación', 'FontSize', 14);
grid on;
ylim([min(mNR(1:iter_limit,2)), max(mNR(1:iter_limit,2))]);  % Ajustar el rango del eje y

subplot(2,1,2);
semilogy(mNR(1:iter_limit,1), mNR(1:iter_limit,3), '-o', 'LineWidth', 2, 'MarkerSize', 6);  % Usar escala logarítmica en y
xlabel('Iteraciones', 'FontSize', 12);
ylabel('Error', 'FontSize', 12);
title('Newton-Raphson: Iteraciones vs Error (Escala Logarítmica)', 'FontSize', 12);
grid on;
% Guardar la figura como PNG de alta calidad
print('NewtonRaphson.png', '-dpng', '-r300');
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
% Graficar iteraciones vs aproximación y error para Punto Fijo
figure('Name', 'PuntoFijo', 'NumberTitle', 'off');
set(gcf, 'PaperPositionMode', 'auto');
subplot(2,1,1);
plot(mPF(:,1), mPF(:,2), '-o', 'LineWidth', 2, 'MarkerSize', 6);
xlabel('Iteraciones', 'FontSize', 12);
ylabel('Aproximación', 'FontSize', 12);
title('Método de Punto Fijo: Iteraciones vs Aproximación', 'FontSize', 14);
grid on;

subplot(2,1,2);
plot(mPF(:,1), mPF(:,3), '-o', 'LineWidth', 2, 'MarkerSize', 6);
xlabel('Iteraciones', 'FontSize', 12);
ylabel('Error', 'FontSize', 12);
title('Método de Punto Fijo: Iteraciones vs Error', 'FontSize', 14);
grid on;
% Guardar la figura como PNG de alta calidad
print('PuntoFijo.png', '-dpng', '-r300');
% Cerrar el diario
diary off;
