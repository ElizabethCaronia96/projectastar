function [] = repeated_forward(xStart, yStart, xTarget, yTarget, diagram, plotName)
%% List Setup

% OPEN List structure
% IS ON LIST 1/0 | Xval | Yval | Parent Xval | Parent Yval | h(n) | g(n) |
% f(n)
MAX_VAL = 6;
MAX_X = MAX_VAL, MAX_Y  =MAX_VAL;
MAP = diagram;
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