% Script para salvar as tabelas em .xlsx
%% Tabela das barras
xlswrite('Dados_Saida_Barras.xlsx',bars_table(:,1:4),1,'B3');
xlswrite('Dados_Saida_Barras.xlsx',rad2deg(cell2mat(bars_table(:,4))),1,'F3');
xlswrite('Dados_Saida_Barras.xlsx',bars_table(:,5:7),1,'G3');
xlswrite('Dados_Saida_Barras.xlsx',max_error,1,'K3');

%% Tabela da LT
xlswrite('Dados_Saida_Fluxo_Potência.xlsx',power_flux(:,1:3),1,'B3');
xlswrite('Dados_Saida_Fluxo_Potência.xlsx',rad2deg(cell2mat(power_flux(:,3))),1,'E3');
xlswrite('Dados_Saida_Fluxo_Potência.xlsx',power_flux(:,4:9),1,'F3');
