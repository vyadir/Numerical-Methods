% Definir la función g(t)
g = @(t) log((3/70) + (7/10) * exp(-0.8 * t)) / -0.35;
% Crear un vector de puntos en el intervalo [8, 10]
valores_t = linspace(0, 15, 100);
% Evaluar g(t) y la identidad y = t
valores_g = g(valores_t);
linea_identidad = valores_t;  % y = t
% Buscar el punto fijo aproximadamente
diferencia = abs(valores_g - valores_t);
[minima_diferencia, indice_minimo] = min(diferencia); % Encuentra la menor diferencia
% Graficar g(t) y y = t
plot(valores_t, valores_g, 'b-', 'LineWidth', 2); hold on;
plot(valores_t, linea_identidad, 'r--', 'LineWidth', 2);
% Verificar si el punto fijo es razonable y etiquetarlo
if minima_diferencia < 0.05  % Umbral ajustado para mayor tolerancia
    punto_fijo_t = valores_t(indice_minimo);
    punto_fijo_g = valores_g(indice_minimo);
    plot(punto_fijo_t, punto_fijo_g, 'ko', 'MarkerFaceColor', 'k'); % Punto fijo
    text(punto_fijo_t, punto_fijo_g, sprintf('  (%.2f, %.2f)', punto_fijo_t, punto_fijo_g), 'VerticalAlignment', 'bottom');
end
% Configurar la gráfica
xlabel('t');
ylabel('g(t) y t');
legend('g(t)', 'y = t', 'Location', 'southeast');
title('Demostración gráfica del punto fijo en [8, 10]');
grid on;
% Ajustar los ejes para que se vea claramente el intervalo [8, 10]
xlim([0, 12]); 
ylim([0,12]); 
hold off;
print('puntoFijo.png', '-dpng');
waitforbuttonpress;