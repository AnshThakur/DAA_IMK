function k= euc_distance(x1, x2)
%%PURPOSE: To compute the euclidean distance between two vectors

%INPUTS

%          x1:                   The first vector

%          x2:                   The second vector

%OUTPUTS

%          dist:                 The computed euclidean distance

%%
x = (x1-x2).^2;
k = sum(x,2);
k = k.^0.5;
end
    
    