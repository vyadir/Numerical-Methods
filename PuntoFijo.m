function [mPF, tiempo] = PuntoFijo(f, x0, iterMax, tol)
    % Parametros de entrada
    % f: función en términos de x
    % x0: valor inicial
    % iterMax: cantidad máxima de iteraciones por hacer
    % tol: tolerancia del error como criterio de parada
    % mPF: es la matriz de retorno que contiene la iteracion, la aproximación y el error absoluto
    syms x;
    iter = 1;
    errA = tol + 1;
    mPF = []; % Matriz para almacenar los resultados de cada iteración
    % Iniciar la medición del tiempo
    tic;
    while (errA > tol && iter <= iterMax)
        if (iter > iterMax)
            break;
        end
        mPF(iter, 1) = iter; % Guarda la iteración actual en la primera columna
        x1 = double(subs(f, x, x0)); % Calcula la nueva aproximación
        mPF(iter, 2) = x1; % Guarda la aproximación en la segunda columna
        if iter > 1
            errA = abs(mPF(iter, 2) - mPF(iter - 1, 2)); % Calcula el error absoluto
        else
            errA = abs(x1 - x0); % Error inicial para la primera iteración
        end
        mPF(iter, 3) = errA; % Guarda el error absoluto en la tercera columna
        % Condición de parada por precisión extrema
        if errA < 10^(-100)
            break;
        end
        % Actualizar x0 para la siguiente iteración
        x0 = x1;
        iter = iter + 1;
    end
    % Detener la medición del tiempo
    tiempo = toc;
end
