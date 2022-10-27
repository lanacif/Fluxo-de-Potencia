% Carregando as tabelas
dados_LT = xlsread('Dados_LT.xlsx');
dados_Barras = xlsread('Dados_Barras_sem_interface.xlsx');
% Escolhendo o erro
erro_desejado = 0.01;
% Chamando o arquivo de cálculos
[bars_table,bars_loss,power_flux,LT_loss,max_error] = calc(dados_LT,dados_Barras,erro_desejado);
% Mostrando os resultados no terminal
disp('Dados das Barras');
disp(bars_table);
disp('Perdas nas barras');
disp(bars_loss);
disp('Fluxo de potência');
disp(power_flux);
disp('Perdas na LT (ativa e reativa)');
disp(LT_loss);
% Salvando os dados em xlsx
save_all; % Script para salvar os dados