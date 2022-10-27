%Função para decompor as informações das tabelas em vetores
function [index_k,index_m,Ykm,akm,phikm,bkm_sh,bar,bar_type,V,theta,P,Q,bk_sh] = vector_cut(dataTL, dataBars)

%Obs: todos os valores da primeira tabela são do tipo 'double'
index_k = dataTL(:,1);
index_m = dataTL(:,2);
Ykm = dataTL(:,3) + i*dataTL(:,4);
akm = dataTL(:,5);
phikm = dataTL(:,6);
bkm_sh = dataTL(:,7);

%Obs: todos os valores da segunda tabela são do tipo 'double'
bar = dataBars(:,1);
bar_type = dataBars(:,2);
V = dataBars(:,3);
theta = dataBars(:,4);
P = dataBars(:,5);
Q = dataBars(:,6);
bk_sh = dataBars(:,7);

end
