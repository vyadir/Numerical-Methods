% Configuracion necesaria
pkg load symbolic;
format long g;
warning off all;

% Definición de la función Secante
function [mSec] = Secante(f, x0, x1, iterMax, tol)
    %Parametros de entrada
    %f: función en términos de x
    %x0: inicio del intervalo
    %x1: fin del intervalo
    %iterMax: cantidad máxima de iteraciones por hacer
    %tol: tolerancia del error como criterio de parada
    %mSec: es la matriz de retorno que contiene la iteracion, la aproximación y el error absoluto
    syms x;
    iter = 1;
    errA = tol + 1;
    fx0 = double(subs(f, x, x0)); % evalúo la función f en x0
    fx1 = double(subs(f, x, x1)); % evalúo la función f en x1
    while (errA > tol)
        if (iter > iterMax)
            break;
        endif
        mSec(iter, 1) = iter;
        xi = x1 - (fx1 * (x1 - x0)) / (fx1 - fx0); % cálculo de la aproximación de secante
        fxi = double(subs(f, x, xi)); % evalúo la función f en xi
        mSec(iter, 2) = xi;
        x0 = x1;
        fx0 = fx1;
        x1 = xi;
        fx1 = fxi;
        if iter > 1
            errA = abs(mSec(iter, 2) - mSec(iter-1, 2)); % cálculo del error absoluto
        else
            errA = abs(x1 - x0); % error inicial para la primera iteración
        endif
        mSec(iter, 3) = errA; % en la fila iter de la columna 3 de la matriz mSec se asigna el error absoluto
        iter = iter + 1;
    endwhile
endfunction

% Prueba de la función Secante con un ejemplo para sqrt(2)
syms x;
f = (x-1)^4*(x^2-64);
[mSec] = Secante(f, 1, 2, 10, 0.0000005);
% Mostrar los resultados
disp('Resultados del método de la Secante:');
disp('Iteración   Aproximación   Error');
disp(mSec);