function [theta_km,P_flux,Q_flux] = power_flow(index_k,index_m,akm,phikm,theta,bkm_sh,Ykm,V)
% Pré-alocando para economizar processamento
theta_km = zeros(length(index_k),1);
Ikm = zeros(length(index_k),1);
Imk = zeros(length(index_k),1);
Skm = zeros(length(index_k),1);
Smk = zeros(length(index_k),1);

P_flux = zeros(length(index_k),2);
Q_flux = zeros(length(index_k),2);

% Rotina de cálculo dos fluxos de potência Pkm e Qkm
for i=1:length(index_k)
   theta_km(i) = theta(index_k(i))- theta(index_m(i));
   %Fluxos de corrente
   Ikm(i,1) = ((akm(i)^2)*Ykm(i) + 1j*bkm_sh(i))*(V(index_k(i))*exp(1j*theta(index_k(i)))) + (-akm(i)*exp(-1j*phikm(i))*Ykm(i))*(V(index_m(i))*exp(1j*theta(index_m(i))));
   Imk(i,1) = (-akm(i)*exp(1j*phikm(i))*Ykm(i))*(V(index_k(i))*exp(1j*theta(index_k(i)))) + (Ykm(i) + 1j*bkm_sh(i))*(V(index_m(i))*exp(1j*theta(index_m(i)))); 
   %Fluxos de potência
   Skm(i) = conj(Ikm(i))*(V(index_k(i))*exp(1j*theta(index_k(i))));
   Smk(i) = conj(Imk(i))*(V(index_m(i))*exp(1j*theta(index_m(i))));
end
%Separação para exibição nas tabelas
P_flux(:,1) = real(Skm);
Q_flux(:,1) = imag(Skm);
P_flux(:,2) = real(Smk);
Q_flux(:,2) = imag(Smk);

P_loss = P_flux(:,1) + P_flux(:,2);
Q_loss = Q_flux(:,1) + Q_flux(:,2);
   
end