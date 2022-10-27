% Função para o cálculo da matriz admitância
function [Y_matrix] = admittance_matrix(index_k, index_m, Ykm, akm, phikm, bkm_sh, bk_sh)

Y_matrix = diag(bk_sh*i); % Preenche os valores das diagonais com bh_sh

for j = 1:length(index_k) % Percorre a quantidade de conexões
    Y_matrix(index_k(j),index_m(j)) = - akm(j)*exp(-i*phikm(j))*Ykm(j);
    Y_matrix(index_m(j),index_k(j)) = - akm(j)*exp(+i*phikm(j))*Ykm(j);
    Y_matrix(index_k(j),index_k(j)) = Y_matrix(index_k(j),index_k(j)) + i*bkm_sh(j) + akm(j)^2*Ykm(j);
    Y_matrix(index_m(j),index_m(j)) = Y_matrix(index_m(j),index_m(j)) + i*bkm_sh(j) + Ykm(j);
end

end