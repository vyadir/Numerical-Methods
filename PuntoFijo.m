% Configuracion necesaria
pkg load symbolic;
format long g;
warning off all;

function [mPF] = PuntoFijo(f,x0,iterMax,tol)
    % Parametros de entrada
    % f: función en términos x
    % x0: inicio del intervalo
    % iterMax: cantidad máxima de iteraciones por hacer
    % tol: tolerancia del error como criterio de parada
    % mPF: es la matriz de retorno que contiene la iteracion, la aproximación y el error absoluto
    syms x;
    iter = 1;
    errA = tol + 1;
    mPF = []; % Matriz para almacenar los resultados de cada iteración
    while (errA > tol)
        if (iter > iterMax)
            break;
        end
        mPF(iter, 1) = iter; % Guarda la iteración actual en la primera columna
        x0 = double(subs(f, x, x0)); % Calcula la nueva aproximación
        mPF(iter, 2) = x0; % Guarda la aproximación en la segunda columna
        if iter > 1
            errA = abs(mPF(iter, 2) - mPF(iter - 1, 2)); % Calcula el error absoluto
        end
        mPF(iter, 3) = errA; % Guarda el error absoluto en la tercera columna
        iter = iter + 1;
    end
end

% Ejemplo 
syms x
f = 0.35 * exp(0.75 * x) / x - 50;
op01 = 0.007 * exp(0.75 * x);
op02 = 4/3 * log(100 * x / 7);

ezplot(op01, [-1, 11])
hold on;
ezplot(x, [-1, 11])
% Evita que el gráfico se cierre automáticamente
waitfor(gcf);