% Este codigo implementa un pivoteo parcial que reorganiza las filas de la matriz A y del 
% vector b para mejorar la estabilidad numérica durante el proceso de eliminación Gaussiana.
function [A,b] = Pivoteo(A,b,k)
n = length(A);
e = zeros(n,1);
for i = k:n
    e(i) = abs(A(i,k)) / abs(max(A(i,:)));
end
[~,f] = max(e);
A([k,f],:) = A([f,k],:);
b([k,f],:) = b([f,k],:);
end