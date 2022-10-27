function [P,Q] = subsystem_2(P,Q,p,q,bar_type)

for index_k = 1:length(bar_type)
    if bar_type(index_k) == 2 % Se for uma barra referência
        P(index_k) = p(index_k);
        Q(index_k) = q(index_k);
    end
    if bar_type(index_k) == 3 % Se for uma barra de tensão controlada
        Q(index_k) = q(index_k);
    end
end

end
