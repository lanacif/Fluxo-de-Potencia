function [g,p,q] = g_vector(Y_matrix,count_PQ,count_PV,V,theta,P,Q,connections,bar_type)
% Separando parte real e imaginária da matriz admitância
G = real(Y_matrix);
B = imag(Y_matrix);

% Pre-alocando para economizar processamento
p = zeros(length(V),1);% Poderiamos utilizar V, P ou Q, pois todos eles carregam a quantidade de barras do sistema
q = zeros(length(V),1); % Poderiamos utilizar V, P ou Q, pois todos eles carregam a quantidade de barras do sistema
dP = zeros(count_PQ + count_PV, 1);
dQ = zeros(count_PQ, 1);

count_p = 1;
count_q = 1;
for index_k = 1:length(V) % Poderiamos utilizar V, P ou Q, pois todos eles carregam a quantidade de barras do sistema
    % Inicializa os somatórios
    sum_p = 0;
    sum_q = 0;
    for j = 1:size(connections,2) % Percorre a quantidade de colunas da matriz ligação
        index_m = connections(index_k,j);
        if  index_m ~= 0 % verifica se existe conexão
            theta_km = theta(index_k)-theta(index_m);
            % Faz o somatório
            sum_p = sum_p + V(index_m)*(G(index_k,index_m)*cos(theta_km) + B(index_k,index_m)*sin(theta_km));
            sum_q = sum_q + V(index_m)*(G(index_k,index_m)*sin(theta_km) - B(index_k,index_m)*cos(theta_km));
        end
    end
    p(index_k)= V(index_k)*(sum_p + V(index_k)*G(index_k,index_k));
    q(index_k)= V(index_k)*(sum_q - V(index_k)*B(index_k,index_k));
    
    if(bar_type(index_k) == 1) % 1 indica barra PQ
        dP(count_p) = P(index_k) - p(index_k);
        dQ(count_q) = Q(index_k) - q(index_k);
        count_p = count_p + 1;
        count_q = count_q + 1;
    end
    
    if(bar_type(index_k) == 3) % 3 indica barra PV
        dP(count_p) = P(index_k) - p(index_k);
        count_p = count_p + 1;
    end
end

% Matriz g
g = [dP;dQ];
end