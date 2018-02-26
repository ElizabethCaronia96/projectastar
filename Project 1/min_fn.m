function [ i_min ] = min_fn( OPEN, OPEN_COUNT, xTarget, yTarget )
% Takes the list of OPEN nodes and returns the index of the node with the
% least cost

temp_array = [];
k = 1;
flag = 0;
goal_index = 0;
for j = 1:OPEN_COUNT
    if (OPEN(j,1) == 1)
        temp_array(k,:) = [OPEN(j,:) j];
        if (OPEN(j, 2) == xTarget && OPEN(j,3) == yTarget)
            flag = 1;
            goal_index = j;
        end
        k = k+1;
    end
end

% send the goal node
if flag == 1
    i_min = goal_index;
end

%otherwise send the minimum cost node
if (size(temp_array ~= 0))
    [min_fn, temp_min] = min(temp_array(:,8))
    i_min = temp_array(temp_min,9)
else 
    i_min = -1 % no more paths are available
end


end

