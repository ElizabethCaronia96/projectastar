function [] = repeated_forward(xStart, yStart, xTarget, yTarget, diagram, plotName)

OPEN = [];

diag_size = size(diagram);
CLOSED = zeros(diag_size(1)*diag_size(2),2);

% put all obstacles in the closed list, design choice from psuedo code
k = 1;
for i = 1:diag_size(1)
    for j = 1:diag_size(2)
        if (diagram(i,j) == -1)
            CLOSED(k,1) = i;
            CLOSED(k,2) = j;
            k = k+1;
        end
    end
end

CLOSED_COUNT = size(CLOSED,1);

% xNode and yNode are the state s

xNode = xStart;
yNode = yStart;

OPEN_COUNT = 1;
pathcost = 0;

goal_distance = distance(xNode, yNode, xTarget, yTarget);
OPEN(OPEN_COUNT,:) = expand_node(xNode, yNode, xNode, yNode, pathcost, goal_distance, goal_distance);
OPEN(OPEN_COUNT,1) = 0;
CLOSED_COUNT = CLOSED_COUNT + 1;
CLOSED(CLOSED_COUNT,1) = xNode;
CLOSED(CLOSED_COUNT,2) = yNode;

pathfound = 1;


while ((xNode ~= xTarget || yNode ~= yTarget) && pathfound == 1)
    exp_array = expand_array(xNode, yNode, pathcost, xTarget, yTarget, CLOSED, diag_size(1), diag_size(2));
    exp_count = size(exp_array,1);
    
   %UPDATE LIST OPEN WITH THE SUCCESSOR NODES
 %OPEN LIST FORMAT
 % X val |Y val |Parent X val |Parent Y val |g(n) |h(n)|f(n)|
 %  1    |  2    |  3         | 4           | 5   |6    | 7  |
 %successor array
 %|X val |Y val ||h(n) |g(n)|f(n)|
 %1         2       3   4   5
    for i = 1:exp_count
        stop = 0;
        for j = 1: OPEN_COUNT
            if ( exp_array(i,2) == OPEN(j, 3) && exp_array(i, 1) == OPEN(j,2))
                OPEN(j,8) = min(exp_array(i,5),OPEN(j,8));
                if (exp_array(i,5)==OPEN(j,8))
                    % keep pointer to parents before moving on
                    OPEN(j,4) = xNode;
                    OPEN(j,5) = yNode;
                    OPEN(j,6) = exp_array(i,3);
                    OPEN(j,7) = exp_array(i,4);
                end
                stop = 1;
            end
            if (stop ==1)
                break;
            end
        end
        if (stop == 0)
            OPEN_COUNT = OPEN_COUNT + 1;
            OPEN(OPEN_COUNT, :) = expand_node(exp_array(i,1), exp_array(i, 2), xNode, yNode, exp_array(i,3), exp_array(i,4), exp_array(i, 5));
        end
    end
    

% need to use min function to break ties
index_min_node = min_fn(OPEN, OPEN_COUNT, xTarget, yTarget, 0);
if (index_min_node ~= -1)
    xNode = OPEN(index_min_node, 2);
    yNode = OPEN(index_min_node, 3);
    pathcost = OPEN(index_min_node, 6);
    
    %closed = [closed, s]
    CLOSED_COUNT = CLOSED_COUNT + 1;
    CLOSED(CLOSED_COUNT, 1) = xNode;
    CLOSED(CLOSED_COUNT, 2) = yNode;
    
    OPEN(index_min_node, 1) = 0;
else
    %No path exists
    pathfound = 0;
end
end

%% End of algorithm

i = size(CLOSED, 1);

Optimal_path = [];
xval = CLOSED(i,1);
yval = CLOSED(i, 2);

i = 1;
Optimal_path(i,1) = xval;
Optimal_path(i, 2) = yval;

i = i + 1;

if ((xval == xTarget) && (yval == yTarget))
    inode = 0;
    parentx = OPEN(node_index(OPEN,xval,yval), 4);
    parenty = OPEN(node_index(OPEN,xval,yval), 5);
    
    while (parentx ~= xStart || parenty ~= yStart)
        Optimal_path(i,1) = parentx;
        Optimal_path(i,2) = parenty;
        
        inode = node_index(OPEN, parentx, parenty);
        parentx = OPEN(inode, 4);
        parenty = OPEN(inode, 5);
        
        i = i+1;
    end
    
    j = size(Optimal_path,1);
    
    %Plot the optimal path
 Optimal_path = [xTarget yTarget; Optimal_path];
 plot(plotName,Optimal_path(:,2),Optimal_path(:,1), 'b-');
 axis([1 diag_size(1) 1 diag_size(2)])
 
else
     pause(1);
     h=msgbox('All Nodes Were Searched, But No Path Found!','warn');
     uiwait(h,5);
end
OPEN_COUNT;
end
    