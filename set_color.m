%Adiciona cor na tabela
[row,col] = find_missing(app.UITable_2.Data);
addStyle(app.UITable_2,uistyle('BackgroundColor',[1 1 0.50]),'cell',[row,col]);
addStyle(app.UITable_2,uistyle('BackgroundColor',[0.50 0.63 0.76]),'cell',[row_1,row_1*0+2]);
addStyle(app.UITable_2,uistyle('BackgroundColor',[0.78 0.52 0.56]),'cell',[row_2,row_2*0+2]);
addStyle(app.UITable_2,uistyle('BackgroundColor',[0.69 0.78 0.56]),'cell',[row_3,row_3*0+2]);
