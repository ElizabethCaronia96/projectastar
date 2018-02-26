%% A* algorithm
clc, clear, close all

%% Obstacle, Target, Agent pick up

% Define the 2-d map array
MAX_X = 10;
MAX_Y = 10;

MAX_VAL = 10;

% this array stores the coordinates of the map and the objects in each
% coordinate
MAP = 2*(ones(MAX_X, MAX_Y));

% obtain the obstacles, target, and robot position
% initialize the MAP with input values
% obstacle = -1, target = 0, Robot = 1, space = 2
j = 0;
x_val = 1;
y_val = 1;
axis([1 MAX_X+1 1 MAX_Y+1]);
grid on;
hold on;
n = 0; %number of obstacles

% Begin interactice obstacle, target, start location selection
pause(1);

h = msgbox('Select the target');
uiwait(h, 5);

if ishandle(h) == 1
    delete(h);
end

xlabel('Select the target');

but = 0;
while (but ~= 1) % repear until the left button is not clicked
    [xval, yval, but] = ginput(1);
end

xval = floor(xval);
yval = floor(yval);

xTarget = xval;  % coordinate of the target
yTarget = yval;  % coordinate of the target

MAP(xval, yval) = 0;  % initialize MAP with location of the target
plot(xval+ 0.5, yval + 0.5, 'gd');
text(xval+1, yval+0.5, 'Target');

pause(2);
h = msgbox('Select obstacles');
xlabel('Select obstacles');

uiwait(h, 10);
if ishandle(h) == 1
    delete(h);
end

while but == 1
    [xval, yval, but] = ginput(1);
    xval = floor(xval);
    yval = floor(yval);
    MAP(xval,yval) = -1;  %put on the closed list as well
    plot(xval+0.5, yval+.5, 'ro');
end

pause(1);

h = msgbox('Select the Agent position');
uiwait(h,5);
if ishandle(h) == 1
    delete(h);
end

xlabel('Select the Agent position');
but = 0;
while (but ~= 1)
    [xval, yval, but] = ginput(1);
end

xval = floor(xval);
yval = floor(yval);

xStart = xval;
yStart = yval;

MAP(xval, yval) = 1;
plot(xval+0.5, yval+0.5, 'bo');

%% List Setup

% OPEN List structure
% IS ON LIST 1/0 | Xval | Yval | Parent Xval | Parent Yval | h(n) | g(n) |
% f(n)

OPEN = [];

% CLOSED LIST STRUCTURE
% Xval | Yval

CLOSED = zeros(MAX_VAL,2);

% put all obstacles in the closed list
k = 1;
for i = 1:MAX_X
    for j = 1:MAX_Y
        if (MAP(i,j) == -1)
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
OPEN(OPEN_COUNT,:) = insert_open(xNode, yNode, xNode, yNode, path_cost, goal_distance, goal_distance);
OPEN(OPEN_COUNT,1) = 0;
CLOSED_COUNT = CLOSED_COUNT + 1;
CLOSED(CLOSED_COUNT,1) = xNode;
CLOSED(CLOSED_COUNT,2) = yNode;

NoPath = 1;

%% Begin algorithm

while ((xNode ~= xTarget || yNode ~= yTarget) && NoPath == 1)
    exp_array = expand_array(xNode, yNode, path_cost, xTarget, yTarget, CLOSED, MAX_X, MAX_Y);
    exp_count = size(exp_array,1);
    
    %UPDATE OPEN LIST WITH SUCCESSOR NODES
    
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
            OPEN(OPEN_COUNT, :) = insert_open(exp_array(i,1), exp_array(i, 2), xNode, yNode, exp_array(i,3), exp_array(i,4), exp_array(i, 5));
        end
    end
    

% Find minimum from OPEN list
index_min_node = min_fn(OPEN, OPEN_COUNT, xTarget, yTarget);
if (index_min_node ~= -1)
    xNode = OPEN(index_min_node, 2);
    yNode = OPEN(index_min_node, 3);
    path_cost = OPEN(index_min_node, 6)
    
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
    p=plot(Optimal_path(j,1)+.5,Optimal_path(j,2)+.5,'bo');
 j=j-1;
 for i=j:-1:1
  pause(.25);
  set(p,'XData',Optimal_path(i,1)+.5,'YData',Optimal_path(i,2)+.5);
 drawnow ;
 end;
 plot(Optimal_path(:,1)+.5,Optimal_path(:,2)+.5);
else
 pause(1);
 h=msgbox('Sorry, No path exists to the Target!','warn');
 uiwait(h,5);
end
    



