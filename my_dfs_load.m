function [diagram] = my_dfs_load(sX, sY, plotName, mapwidth, mapheight)
diagram = zeros(mapheight, mapwidth);
    % Set starting node as current node and add it in to stack and visited list
    current(1) = sX;
    current(2) = sY;
    stack = [current(1); current(2)];
    visited = [current(1); current(2)];
 
while(~isempty(current))
    neighbors = get_neighbors(current(1), current(2), 6,6);
    newchildfound = 0;
    %if new child found add to list
    for i = 1: length(neighbors)
        if(diagram(neighbors(1,i), neighbors(2,i)) == 0)
            probability = rand;
            if(probability*100 <=30)
                diagram(neighbors(1,i), neighbors(2,i)) = -1;
                plot(plotName,neighbors(1,i), neighbors(2,i), 'ro');
                hold all;
            else
                diagram(neighbors(1,i), neighbors(2,i)) = 1;
            end
            stack = [neighbors(1,i) stack(1, :); neighbors(2, i), stack(2, :)];
            visited = [visited(1,:), neighbors(1,i); visited(2,:), neighbors(2,i)];
            current = [neighbors(1,i), neighbors(2,i)];
            newchildfound  = 1;
        end
    end
    if (newchildfound ==0)
        l =size(stack);
        if(l(2)>0)
                popedItem = stack(:,1);
                stack(:,1) = [];
        end
        l =size(stack);  
        if(l(2)>0)
                current = stack(:,1);
        else
                current = [];
                comment = 'DFS Converged';
        end 
    end
end