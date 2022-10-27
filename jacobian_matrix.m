% Função para o cálculo da matriz Jacobiana
function [jac_matrix] = jacobian_matrix(Y_matrix,count_PQ,count_PV,index_p,index_q,V,theta,P,Q,connections)
% Separando parte real e imaginária da matriz admitância
G = real(Y_matrix);
B = imag(Y_matrix);

%% Inicializando a submatriz H com zeros
H = zeros(count_PQ + count_PV,count_PQ + count_PV);
% Construindo a submatriz H
for i = 1:length(H)
    index_k = index_p(i);
    for j = 1:length(H)
        if i ~= j % Se não estivermos na diagonal principal
            index_m = index_p(j);
            if find((connections(index_k,:) == index_m),1) % Se existir conexão entre k e m
                theta_km = theta(index_k) - theta(index_m);
                H(i,j) = V(index_k)*V(index_m)*(G(index_k,index_m)*sin(theta_km) - B(index_k,index_m)*cos(theta_km));
                % Obs: se não existir conexão o zero já está na submatriz H
            end
        else % Se estivermos na diagonal principal
            for m = 1:size(connections,2) % Percorre a quantidade de colunas da matriz ligação
                index_m = connections(index_k,m);
                if index_m ~= 0 % verifica se existe conexão
                    theta_km = theta(index_k) - theta(index_m);
                    % Faz o somatório
                    H(i,j) = H(i,j) + V(index_m)*(-G(index_k,index_m)*sin(theta_km) + B(index_k,index_m)*cos(theta_km));
                end
            end
            % Finaliza a fórmula da diagonal principal
            H(i,j) = V(index_k)*H(i,j);
        end
    end
end

%% Inicializando a submatriz N com zeros
N = zeros(count_PQ + count_PV,count_PQ);
% Construindo a submatriz N
for i = 1:size(N,1)
    index_k = index_p(i);
    for j=1:size(N,2)
        index_m = index_q(j);
        if index_k ~= index_m % Se não estivermos em um elemento "(k,k)"
            if find((connections(index_k,:) == index_m),1) % Se existir conexão entre k e m
                theta_km = theta(index_k) - theta(index_m);
                N(i,j) = V(index_k)*(G(index_k,index_m)*cos(theta_km) + B(index_k,index_m)*sin(theta_km));
                % Obs: se não existir conexão o zero já está na submatriz N
            end
        else % Se estivermos em um elemento "(k,k)"
            for m = 1:size(connections,2) % Percorre a quantidade de colunas da matriz ligação
                index_m = connections(index_k,m);
                if index_m ~= 0 % verifica se existe conexão
                    theta_km = theta(index_k) - theta(index_m);
                    % Faz o somatório
                    N(i,j) = N(i,j) + V(index_m)*(G(index_k,index_m)*cos(theta_km) + B(index_k,index_m)*sin(theta_km));
                end
            end
            % Finaliza a fórmula do elemento "(k,k)"
            N(i,j) = 2*V(index_k)*G(index_k, index_k) + N(i,j);
        end
    end
end

%% Inicializando a submatriz M com zeros
M = zeros(count_PQ,count_PQ + count_PV);
% Construindo a submatriz M
for i = 1:size(M,1)
    index_k = index_q(i);
    for j=1:size(M,2)
        index_m = index_p(j);
        if index_k ~= index_m % Se não estivermos em um elemento "(k,k)"
            if find((connections(index_k,:) == index_m),1) % Se existir conexão entre k e m
                theta_km = theta(index_k) - theta(index_m);
                M(i,j) = -V(index_k)*V(index_m)*(G(index_k,index_m)*cos(theta_km) + B(index_k,index_m)*sin(theta_km));
                % Obs: se não existir conexão o zero já está na submatriz M
            end
        else % Se estivermos em um elemento "(k,k)"
            for m = 1:size(connections,2) % Percorre a quantidade de colunas da matriz ligação
                index_m = connections(index_k,m);
                if index_m ~= 0 % verifica se existe conexão
                    theta_km = theta(index_k) - theta(index_m);
                    % Faz o somatório
                    M(i,j) = M(i,j) + V(index_m)*(G(index_k,index_m)*cos(theta_km) + B(index_k,index_m)*sin(theta_km));
                end
            end
            % Finaliza a fórmula do elemento "(k,k)"
            M(i,j) = V(index_k)*M(i,j);
        end
    end
end

%% Inicializando a submatriz L com zeros
L = zeros(count_PQ,count_PQ);
% Construindo a submatriz M
for i = 1:size(L,1)
    index_k = index_q(i);
    for j=1:size(L,2)
        index_m = index_q(j);
        if index_k ~= index_m % Se não estivermos em um elemento "(k,k)"
            if find((connections(index_k,:) == index_m),1) % Se existir conexão entre k e m
                theta_km = theta(index_k) - theta(index_m);
                L(i,j) = V(index_k)*(G(index_k,index_m)*sin(theta_km) - B(index_k,index_m)*cos(theta_km));
                % Obs: se não existir conexão o zero já está na submatriz M
            end
        else % Se estivermos em um elemento "(k,k)"
            for m = 1:size(connections,2) % Percorre a quantidade de colunas da matriz ligação
                index_m = connections(index_k,m);
                if index_m ~= 0 % verifica se existe conexão
                    theta_km = theta(index_k) - theta(index_m);
                    % Faz o somatório
                    L(i,j) = L(i,j) + V(index_m)*(G(index_k,index_m)*sin(theta_km) - B(index_k,index_m)*cos(theta_km));
                end
            end
            % Finaliza a fórmula do elemento "(k,k)"
            L(i,j) = -2*V(index_k)*B(index_k, index_k) + L(i,j);
        end
    end
end

% Matriz Jacobiana
jac_matrix = -[H,N;M,L];

end
