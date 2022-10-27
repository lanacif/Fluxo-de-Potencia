function [V,theta] = corrected_values(dx,V,theta,bar_type)
count = 1;

for i = 1:length(bar_type) % Percorre a quantidade de barras
    if bar_type(i) ~= 2 % Não faz correção para a barra de referência
        theta(i) = theta(i) + dx(count);
        count = count + 1;
    end
end

for i = 1:length(bar_type) % Percorre a quantidade de barras
    if bar_type(i) == 1 % Se for uma barra de carga
        V(i) = V(i) + dx(count);
        count = count + 1;
    end
end
end