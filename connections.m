% Função para organizar as conexões dadas na tabela.

% Retorna uma matriz onde cada linha representa uma barra e cada coluna o
% numero de uma barra que esta conectada a ela. O valor zero não representa
% uma conexão. (O matlab não permite que seja criado um vetor com X linhas 
% e cada linha com uma quantidade de colunas diferente, portanto para que 
% toda linha tenha o mesmo numero de colunas o matlab preenche com zeros.)

function [con_matrix] = connections(bar,index_k,index_m)

for bar_k = 1:length(bar) % Percorre a quantidade de barras
    col = 1;
    for con = 1:length(index_k) % Percorre a quantidade de ligações 
        
        if index_k(con) == bar_k
            con_matrix(bar_k,col) = index_m(con);
            col = col+1;
        end
        
        if index_m(con) == bar_k
           con_matrix(bar_k,col) = index_k(con);
           col = col+1;
        end
        
    end
end

end
