% Função para preencher os vetores P,Q,V e theta com um bom chute inicial 
% para um sistema real. (o método de newton raphson requer um chute inicial)
function [P,Q,V,theta] = vector_fill(P,Q,V,theta)
% Os valores vazios nas tabelas são completados com os valores a seguir:
P(isnan(P)) = 0;
Q(isnan(Q)) = 0;
V(isnan(V)) = 1;
theta(isnan(theta)) = 0;

end
