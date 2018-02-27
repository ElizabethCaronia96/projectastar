function [ i_min ] = min_fn( OPEN, OPEN_COUNT, xTarget, yTarget, g_flag )
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
    [min_fn, temp_min] = min(temp_array(:,8));
    mins = [];
    k = 1;
    
    len = length(temp_array(:,1));
    
    for i = 1:length(temp_array(:,1))
        if temp_array(i,8) == min_fn
            temp = temp_array(i,:);
            mins(k,:) = temp_array(i,:);
            k = k+1;
        end
    end
    
    if (g_flag == 0)
    
        [min_fn, temp_min] = min(mins(:,7));
    else
        [min_fn, temp_min] = max(mins(:,7));
    end
          
    i_min = temp_array(temp_min,9);
else 
    i_min = -1; % no more paths are available
end


end

