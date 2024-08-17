% Configuracion necesaria
pkg load symbolic;
format long g;
warning off all;

% Definición de la función Newton-Raphson
function [mNR] = NewtonRaphson(f, x0, iterMax, tol)
    %Parametros de entrada
    %f: función en términos de x
    %x0: valor inicial para la raíz
    %iterMax: cantidad máxima de iteraciones por hacer
    %tol: tolerancia del error como criterio de parada
    %mNR: es la matriz de retorno que contiene la iteracion, la aproximación y el error absoluto
    syms x;
    df = diff(f, x); % derivada de la función f
    iter = 1;
    errA = tol + 1;
    mNR = zeros(iterMax, 3); % Inicialización de la matriz de resultados con ceros
    while errA > tol
        if (iter > iterMax)
            break;
        end
        fx0 = double(subs(f, x, x0)); % evalúo la función f en x0
        dfx0 = double(subs(df, x, x0)); % evalúo la derivada de f en x0
        % Verifico que la derivada no sea cero
        if dfx0 == 0
            disp('La derivada es cero, no se puede continuar con el método');
            break;
        end
        xi = x0 - fx0 / dfx0; % cálculo de la nueva aproximación
        % Guardar los valores de la iteración, aproximación y error
        mNR(iter, 1) = iter;
        mNR(iter, 2) = xi;
        % Calculo el error absoluto en la iteración actual si iter > 1
        if iter > 1
            errA = abs(mNR(iter, 2) - mNR(iter-1, 2)); % calculo del error absoluto
        else
            errA = abs(xi - x0); % error inicial para la primera iteración
        end
        mNR(iter, 3) = errA; % en la fila iter de la columna 3 de la matriz mNR se asigna el error
        % Actualizo x0 para la siguiente iteración
        x0 = xi;
        iter = iter + 1;
    end
    % Eliminar filas no utilizadas de la matriz
    mNR = mNR(1:iter-1, :);
end

% Prueba de la función Newton-Raphson con un ejemplo para sqrt(2)
syms x;
f = x^2 - 2;
[mNR] = NewtonRaphson(f, 1, 20, 0.0000005);
% Mostrar los resultados
disp('Resultados de Newton-Raphson:');
disp('Iteración   Aproximación   Error');
disp(mNR);
