function [x] = ElimGauss(A, b, piv)
n = length(A);
% Eliminación hacia adelante
for k = 1:n-1
    if piv ~= 0
        [A,b] = Pivoteo(A,b,k);
    end
    for i = k+1:n
        F = A(i,k) / A(k,k);
        for j = 1:n
            A(i,j) = A(i,j) - F * A(k,j);
        end
        b(i) = b(i) - F * b(k);
    end
end
% Sustitución hacia atrás
x = zeros(n,1);  % Inicializa el vector de soluciones
for i = n:-1:1
    suma = 0;
    for j = i+1:n
        suma = suma + A(i,j) * x(j);
    end
    x(i) = (b(i) - suma) / A(i,i);
end
x = x';  % Transponer el vector de soluciones
end