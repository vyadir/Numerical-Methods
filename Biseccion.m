% Configuracion necesaria
pkg load symbolic;
format long g;
warning off all;

% Definición de la función Biseccion
function [mBis] = Biseccion(f, x0, x1, iterMax, tol)
    %Parametros de entrada
    %f: función en términos de x
    %x0: inicio del intervalo
    %x1: fin del intervalo
    %iterMax: cantidad máxima de iteraciones por hacer
    %tol: tolerancia del error como criterio de parada
    %mBis: es la matriz de retorno que contiene la iteracion, la aproximación y el error absoluto

    syms x;
    iter = 1;
    errA = tol + 1;
    fx0 = double(subs(f, x, x0)); % evalúo la función f en x0
    fx1 = double(subs(f, x, x1)); % evalúo la función f en x1
    % Verifico si el método se puede aplicar
    if fx0 * fx1 < 0
        mBis = zeros(iterMax, 3); % Inicialización de la matriz de resultados con ceros
        while errA > tol
            if (iter > iterMax)
                break;
            end
            xi = (x0 + x1) / 2; % se calcula el punto medio
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
            mBis(iter, 1) = iter;
            mBis(iter, 2) = xi;
            % Calculo el error absoluto en la iteración actual si iter > 1
            if iter > 1
                errA = abs(mBis(iter, 2) - mBis(iter-1, 2)); % calculo del error absoluto
            else
                errA = abs(x1 - x0); % error inicial para la primera iteración
            end
            mBis(iter, 3) = errA; % en la fila iter de la columna 3 de la matriz mBis se asigna el error
            iter = iter + 1;
        end
        % Eliminar filas no utilizadas de la matriz
        mBis = mBis(1:iter-1, :);
    else % no se cumple la condición
        disp('No se puede aplicar el método');
        mBis = [];
    end
end

% Prueba de la función Biseccion con un ejemplo raiz de 2
syms x;
f = x^2 - 2;
[mBis] = Biseccion(f, 1, 3, 20, 0.0000005);
% Mostrar los resultados
disp('Resultados de la Bisección:');
disp('Iteración   Aproximación   Error');
disp(mBis);
