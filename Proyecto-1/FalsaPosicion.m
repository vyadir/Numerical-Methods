function [MFP, tiempo] = FalsaPosicion(f, x0, x1, iterMax, tol)
    %Parametros de entrada
    %f: función en términos de x
    %x0: inicio del intervalo
    %x1: fin del intervalo
    %iterMax: cantidad máxima de iteraciones por hacer
    %tol: tolerancia del error como criterio de parada
    %MFP: es la matriz de retorno que contiene la iteracion, la aproximación y el error absoluto
    syms x;
    iter = 1;
    errA = tol + 1;
    fx0 = double(subs(f, x, x0)); % evalúo la función f en x0
    fx1 = double(subs(f, x, x1)); % evalúo la función f en x1
    % Iniciar la medición del tiempo
    tic;
    % Verifico si el método se puede aplicar
    if fx0 * fx1 < 0
        MFP = zeros(iterMax, 3); % Inicialización de la matriz de resultados con ceros
        while errA > tol && iter <= iterMax
            if (iter > iterMax)
                break;
            end 
            xi = x1 - (fx1 * (x1 - x0)) / (fx1 - fx0);
            fxi = double(subs(f, x, xi)); % evalúo la función f en xi
            if fxi == 0
                break;
            elseif fxi * fx0 < 0 % en el intervalo [x0, xi] está la solución
                x1 = xi; % actualizo el extremo del intervalo
                fx1 = fxi; % actualizo la imagen del extremo del intervalo
            elseif fxi * fx1 < 0 % en el intervalo [xi, x1] está la solución
                x0 = xi; % actualizo el extremo del intervalo
                fx0 = fxi; % actualizo la imagen del extremo del intervalo
            end
            % Guardar los valores de la iteración, aproximación y error
            MFP(iter, 1) = iter;
            MFP(iter, 2) = xi;
            % Calculo el error absoluto en la iteración actual si iter > 1
            if iter > 1
                errA = abs(MFP(iter, 2) - MFP(iter-1, 2)); % calculo del error absoluto
            else
                errA = abs(x1 - x0); % error inicial para la primera iteración
            end
            MFP(iter, 3) = errA; % en la fila iter de la columna 3 de la matriz MFP se asigna el error
            
            % Condición de parada por precisión extrema
            if errA < 10^(-100)
                break;
            end
            iter = iter + 1;
        end
        % Eliminar filas no utilizadas de la matriz
        MFP = MFP(1:iter-1, :);
    else % no se cumple la condición
        disp('No se puede aplicar el método');
        MFP = [];
    end
    % Detener la medición del tiempo
    tiempo = toc;
end
