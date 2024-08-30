% Parámetros dados
L0 = 30;    % mg/l
cs = 9;     % mg/l
c0 = 2;     % mg/l
Kd = 0.35;  % 1/día
Kr = 0.35;  % 1/día
Ka = 0.8;   % 1/día
% funcion f(t) = c(t) - 8
f = @(t) cs - (L0 * Kd) / (Ka - Kr) * (exp(-Kr * t) - exp(-Ka * t)) - (cs - c0) * exp(-Ka * t) - 8;
% Graficar la función f(t)
valores_t = linspace(-1, 20, 600); % Rango de tiempo
valores_f = arrayfun(f, valores_t);
figure;
h1 = plot(valores_t, valores_f, 'b-', 'LineWidth', 2);
hold on;
xlabel('Tiempo (días)', 'FontSize', 12, 'FontWeight', 'bold', 'Color', 'k');
ylabel('f(t)', 'FontSize', 12, 'FontWeight', 'bold', 'Color', 'k');
title('Gráfica de la función f(t) = c(t) - 8', 'FontSize', 14, 'FontWeight', 'bold', 'Color', 'k');
grid on;
xlim([-1, 20]); % Ajustar para incluir el rango de tiempo
ylim([-max(abs(valores_f)) - 1, max(abs(valores_f)) + 1]);
line([0 0], ylim, 'Color', 'k', 'LineWidth', 2); % Eje Y en el origen
line(xlim, [0 0], 'Color', 'k', 'LineWidth', 2); % Eje X en el origen
% Encontrar las soluciones numericas
estimaciones_iniciales_t = [-8, 10];  % Valores iniciales para encontrar ambas soluciones
soluciones_t = arrayfun(@(t_init) fsolve(f, t_init), estimaciones_iniciales_t);
% Graficar las soluciones en la gráfica
h3 = plot(soluciones_t(1), 0, 'go', 'MarkerSize', 10, 'LineWidth', 2);
h4 = plot(soluciones_t(2), 0, 'mo', 'MarkerSize', 10, 'LineWidth', 2);
legend([h1, h3, h4], 'f(t) = c(t) - 8', sprintf('Solución negativa'), sprintf('Solución positiva'), 'Location', 'northeast');
% Guardar la gráfica como archivo PNG
print('grafico.png', '-dpng');
fprintf('Las soluciones numéricas para t son: %.2f días (negativa) y %.2f días (positiva)\n', soluciones_t(1), soluciones_t(2));
% Evitar que la ventana del gráfico se cierre inmediatamente (particularmente útil en macOS)
waitforbuttonpress;
