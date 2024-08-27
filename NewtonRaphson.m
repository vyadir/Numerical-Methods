function [mNR, tiempo] = NewtonRaphson(f, x0, iterMax, tol)
    %Parametros de entrada
    %f: función en términos de x
    %x0: valor inicial
    %iterMax: cantidad máxima de iteraciones por hacer
    %tol: tolerancia del error como criterio de parada
    %mNR: es la matriz de retorno que contiene la iteracion, la aproximación y el error absoluto
    syms x;
    iter = 1;
    errA = tol + 1;
    fx0 = double(subs(f, x, x0)); % evalúo la función f en x0
    dfx = diff(f, x); % cálculo de la derivada de f
    mNR = []; % Inicializar la matriz de resultados
    % Iniciar la medición del tiempo
    tic;
    while (errA > tol && iter <= iterMax)
        if (iter > iterMax)
            break;
        endif
        mNR(iter, 1) = iter;
        dfx0 = double(subs(dfx, x, x0)); % evalúo la derivada en x0
        if dfx0 == 0
            disp('La derivada es cero, no se puede continuar con el método');
            break;
        endif
        xi = x0 - fx0 / dfx0; % cálculo de la aproximación de Newton-Raphson
        fxi = double(subs(f, x, xi)); % evalúo la función f en xi
        mNR(iter, 2) = xi;
        if iter > 1
            errA = abs(mNR(iter, 2) - mNR(iter-1, 2)); % cálculo del error absoluto
        else
            errA = abs(xi - x0); % error inicial para la primera iteración
        endif
        mNR(iter, 3) = errA; % en la fila iter de la columna 3 de la matriz mNR se asigna el error absoluto
        % Condición de parada por precisión extrema
        if errA < 10^(-100)
            break;
        endif
        % Actualizo x0 para la siguiente iteración
        x0 = xi;
        fx0 = fxi;
        iter = iter + 1;
    endwhile
    % Detener la medición del tiempo
    tiempo = toc;
endfunction
