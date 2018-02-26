function [ n_index ] = node_index( OPEN, xval, yval )
%Returns the index of the location of a node in OPEN

i = 1;
while (OPEN(i,2) ~= xval || OPEN(i,3) ~= yval)
    i = i+1;
end

n_index = i;


end
