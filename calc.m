function [bars_table,bars_loss,power_flux,TL_loss,max_error] = calc(dataTL,dataBars,target_error)

% Reordena as linhas da tabela de barras em ordem crescente
[dataBars] = sortrows(dataBars);
% Separa os dados das tabelas
[index_k,index_m,Ykm,akm,phikm,bkm_sh,bar,bar_type,V,theta,P,Q,bk_sh] = vector_cut(dataTL, dataBars);
% Retorna a matriz admitância
[Y_matrix] = admittance_matrix(index_k,index_m,Ykm,akm,phikm,bkm_sh,bk_sh);
% Conta o quantidade de barras PQ e PV e guarda os índices de P e Q
[count_PQ,count_PV,index_p,index_q] = count_PQ_PV_and_index(bar_type,bar,P,Q);
% Retorna a matriz de conexões
[con_matrix] = connections(bar,index_k,index_m);
% Preenche os vetores P,Q,V e theta com um chute inicial
[P,Q,V,theta] = vector_fill(P,Q,V,theta);

g = target_error;
while max(abs(g)) >= target_error
%% SUBSISTEMA 1
% Retorna a matriz jacobiana
[jac_matrix] = jacobian_matrix(Y_matrix,count_PQ,count_PV,index_p,index_q,V,theta,P,Q,con_matrix);
% Cálculo dos deltasP e deltaQ:
[g,p,q] = g_vector(Y_matrix,count_PQ,count_PV,V,theta,P,Q,con_matrix,bar_type);
% Correção para o vetor x
dx = -inv(jac_matrix)*g;
[V,theta] = corrected_values(dx,V,theta,bar_type);

%% SUBSISTEMA 2
% Cálculo do subsistema 2
[P,Q] = subsystem_2(P,Q,p,q,bar_type);
end

% Cálculo das perdas
[theta_km, P_flux,Q_flux] = power_flow(index_k,index_m,akm,phikm,theta,bkm_sh,Ykm,V);
% Perdas de potência no sistema
P_loss = P_flux(:,1) + P_flux(:,2);
Q_loss = Q_flux(:,1) + Q_flux(:,2);
%Potência fornecida pelos bancos de capacitores
Q_sh = (V.^2).*bk_sh;
% Tabela das barras atualizada
bars_table = [num2cell(bar),num2cell(bar_type),num2cell(V),num2cell(theta),num2cell(P),num2cell(Q),num2cell(Q_sh)];
% Perda nas barras
bars_loss = [num2cell(sum(P)),num2cell(sum(Q)+sum(Q_sh))];
% Tabela de fluxo de potência
power_flux =  [num2cell(index_k),num2cell(index_m),num2cell(theta_km),num2cell(P_flux),num2cell(Q_flux),num2cell(P_loss),num2cell(Q_loss)];
% Perdas na LT (ativa e reativa)
TL_loss = [num2cell(sum(P_loss)),num2cell(sum(Q_loss))];
% Erro máximo
max_error = max(g);

end
