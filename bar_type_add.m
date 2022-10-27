function [dataBars_out,dataBars_mod,row_1,row_2,row_3] = bar_type_add(dataBars)

% Separando os valores presentes na tabela de barras
div1 = dataBars(:,1);
div3 = dataBars(:,2:6);
% Pré-alocando para economizar processamento
div2 = cell(size(dataBars,1),1);
bar_type = zeros(size(dataBars,1),1);
dataBars_out = cell(size(dataBars,1),size(dataBars,2)+1);
% Descobrindo o tipo de barra para cada linha da tabela
for i = 1:length(div1)
    if isnan(dataBars(i,2)) && isnan(dataBars(i,3))
        div2{i} = 'Barra de Carga';
        row_1(i,1) = 1;
        bar_type(i) = 1;
    elseif isnan(dataBars(i,4)) && isnan(dataBars(i,5))
        div2{i} = 'Barra de Referência';
        row_2(i,1) = i;
        bar_type(i) = 2;
    else
        div2{i} = 'Barra de Tensão controlada';
        row_3(i,1) = 1;
        bar_type(i) = 3;
    end
end

% Variáveis para colocar cor nas tabelas
row_1 = find(row_1);
row_2 = find(row_2);
row_3 = find(row_3);

% Montando a tabela atualizada que será mostrada na interface
dataBars_out = [num2cell(div1),div2,num2cell(div3)];

% Montando a tabela atualizada que será enviada para o arquivo de cálculos
% Nessa tabela o tipo de barra é passado em forma de índices
dataBars_mod = [div1 bar_type div3];

end