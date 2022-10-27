%Função para contar a quantidade de barras PQ e PV e os índices de P e Q
function [count_PQ,count_PV,index_p,index_q] = count_PQ_PV_and_index(bar_type,bar,P,Q)
%Inicializando as contagens
count_PQ = 0;
count_PV = 0;

for i = 1:length(bar_type)
    if bar_type(i) == 1
        count_PQ = count_PQ + 1;
    elseif bar_type(i) == 3
        count_PV = count_PV + 1;
    end
end

% Guardando os índices de P e Q para a contrução da matriz jacobiana.
index_p = bar(~isnan(P));
index_q = bar(~isnan(Q));

end
