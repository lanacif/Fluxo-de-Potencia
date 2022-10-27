%Função auxiliar para colocar cor na tabela
function [row,col] = find_missing(dataBars)

selected_dataBars = cell2mat(dataBars(:,3:6));
styleIndices = ismissing(selected_dataBars);
[row,col] = find(styleIndices);
col =  col + 2;

end