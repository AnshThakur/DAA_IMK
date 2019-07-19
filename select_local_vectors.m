function [local_vector] = select_local_vectors(x,Dict1,Dict2)
%select local vectors using dictionaries

[r2 c2]=size(x);

local_vector=cell(r2,1);

for i=1:r2
    data=x{i,1};
    distance=pdist2(Dict1',data');
    [~,ind] = min(distance,[],2);
    lv1=data(:,ind);
    
    distance=pdist2(Dict2',data');
    [~,ind] = min(distance,[],2);
    lv2=data(:,ind);
    
    
    local_vector(i,1)={[lv1'; lv2']};
end

end
    
    
    
    
    
    
        
        



