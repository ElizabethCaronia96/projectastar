function [] = repeated_forward(xStart, yStart, xTarget, yTarget, diagram, plotName)

OPEN = [];

% CLOSED LIST STRUCTURE
% Xval | Yval
diag_size = size(diagram);
CLOSED = zeros(diag_size(1)*diag_size(2),2);

% put all obstacles in the closed list
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

% set the starting node as the first node

xNode = xStart;
yNode = yStart;

OPEN_COUNT = 1;
path_cost = 0;

goal_distance = distance(xNode, yNode, xTarget, yTarget);
OPEN(OPEN_COUNT,:) = expand_node(xNode, yNode, xNode, yNode, path_cost, goal_distance, goal_distance);
OPEN(OPEN_COUNT,1) = 0;
CLOSED_COUNT = CLOSED_COUNT + 1;
CLOSED(CLOSED_COUNT,1) = xNode;
CLOSED(CLOSED_COUNT,2) = yNode;

NoPath = 1;

%% Begin algorithm

while ((xNode ~= xTarget || yNode ~= yTarget) && NoPath == 1)
    exp_array = expand_array(xNode, yNode, path_cost, xTarget, yTarget, CLOSED, diag_size(1), diag_size(2));
    exp_count = size(exp_array,1);
    
   %UPDATE LIST OPEN WITH THE SUCCESSOR NODES
 %OPEN LIST FORMAT
 %--------------------------------------------------------------------------
 %IS ON LIST 1/0 |X val |Y val |Parent X val |Parent Y val |h(n) |g(n)|f(n)|
 %--------------------------------------------------------------------------
 %EXPANDED ARRAY FORMAT
 %--------------------------------
 %|X val |Y val ||h(n) |g(n)|f(n)|
 %--------------------------------
    for i = 1:exp_count
        flag = 0;
        for j = 1: OPEN_COUNT
            if (exp_array(i, 1) == OPEN(j,2) && exp_array(i,2) == OPEN(j, 3))
                OPEN(j,8) = min(OPEN(j,8), exp_array(i,5));
                if (OPEN(j,8) == exp_array(i,5))
                    % UPDATE PARENTS
                    OPEN(j,4) = xNode;
                    OPEN(j,5) = yNode;
                    OPEN(j,6) = exp_array(i,3);
                    OPEN(j,7) = exp_array(i,4);
                end
                flag = 1;
            end
            if (flag ==1)
                break;
            end
        end
        if (flag == 0)
            OPEN_COUNT = OPEN_COUNT + 1;
            OPEN(OPEN_COUNT, :) = expand_node(exp_array(i,1), exp_array(i, 2), xNode, yNode, exp_array(i,3), exp_array(i,4), exp_array(i, 5));
        end
    end
    

% Find minimum from OPEN list
index_min_node = min_fn(OPEN, OPEN_COUNT, xTarget, yTarget);
if (index_min_node ~= -1)
    xNode = OPEN(index_min_node, 2);
    yNode = OPEN(index_min_node, 3);
    path_cost = OPEN(index_min_node, 6);
    
    %Move node to the list of closed nodes
    CLOSED_COUNT = CLOSED_COUNT + 1;
    CLOSED(CLOSED_COUNT, 1) = xNode;
    CLOSED(CLOSED_COUNT, 2) = yNode;
    
    OPEN(index_min_node, 1) = 0;
else
    %No path exists
    NoPath = 0;
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
    parent_x = OPEN(node_index(OPEN,xval,yval), 4);
    parent_y = OPEN(node_index(OPEN,xval,yval), 5);
    
    while (parent_x ~= xStart || parent_y ~= yStart)
        Optimal_path(i,1) = parent_x;
        Optimal_path(i,2) = parent_y;
        
        inode = node_index(OPEN, parent_x, parent_y);
        parent_x = OPEN(inode, 4);
        parent_y = OPEN(inode, 5);
        
        i = i+1;
    end
    
    j = size(Optimal_path,1);
    
    %Plot the optimal path
 Optimal_path = [xTarget yTarget; Optimal_path]
 plot(plotName,Optimal_path(:,2),Optimal_path(:,1), 'b-');
 axis([1 diag_size(1) 1 diag_size(2)])
else
     pause(1);
     h=msgbox('Sorry, No path exists to the Target!','warn');
     uiwait(h,5);
end
end
    