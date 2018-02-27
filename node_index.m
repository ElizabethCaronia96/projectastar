function [ n_index ] = node_index( OPEN, x, y )
%Returns the index of the location of a node in OPEN

index = 1;
while (OPEN(index,2) ~= x || OPEN(index,3) ~= y)
    index = index+1;
end

n_index = index;


end

