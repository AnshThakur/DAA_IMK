function [kgm,sig]= im_kgm_generator(cell1,cell2, train, sigma)
%%PURPOSE: To generate the kernel gram matrix using Intermediate Match Kernel

%INPUTS

%          cell1:                   first cell of reduced set of feature

%                                   vectors

%          cell2:                   second cell of reduced set of feature

%                                   vectors

%          sig:                     the precomputed value of sigma to compute the gaussian kernel.   

%         train: to compute sig (in training) or tu use pre computed values
%         (in testing)

%OUTPUTS

%          Kgm:                      kernel gram matrix
%          sig:                      sigma computed using training  

%%
l1 = length(cell1); l2 = length(cell2);
kgm = zeros(l1, l2);
dist= [];

%Computing the euclidean distance between each pair of sets of feature vectors
for i = 1:l2
    for j = 1:l1
       dist = [dist euc_distance(cell1{j,1},cell2{i,1})];
    end
end

if train==1
    sig = sum(dist,2);
    sig = sig / (l1 * l2); %avg of euclidean distance


elseif train ==0
    sig = sigma;
end
    
sig_rep = repmat(sig, 1,size(dist,2));
k = (sig_rep .^-1).* dist * -1;
k = exp(k);
k = sum(k)/20; %averging kernels, not present in original formulation
kgm = reshape(k, l1, l2);

end