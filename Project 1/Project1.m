%%
clc, clear, close all

fprintf('Generating mazes...\n\n');

mazes = cell(50, 1);
for i = 1:50
    fprintf('Generating maze %d\n', i);
    [lines,MAP, hist, result] = maze(50,50);
    MAP(2,2) = 0;
    MAP(99, 99) = 1;
    if (i == 32)
        MAP(99,98) = -1;
        MAP(99,97) = -1;
        MAP(98,99) = -1;
        MAP(97,99) = -1;
    end  % test no solution
    mazes{i} = MAP;
    % creates the mazes
end

fprintf('\nMaze generation complete\n\n');


%% Perform search on grid world

numExpanded = zeros(50,2);

fprintf('Break ties with smaller g-value:\n\n');

tic;

for k = 1:length(mazes)
    fprintf('Searching maze %d... ', k);
    MAP = cell2mat(mazes(k));
    [path, flag, nodesExpanded] = search(MAP, 2, 2, 99, 99, 0);
    
    if (flag == 0)
        fprintf('Solution found in %d steps!\n', length(path(:,1)));
        numExpanded(k,1) = nodesExpanded;
%         j = size(path,1);
%         
%         %Plot the optimal path
%         p=plot(path(j,1)+.5,path(j,2)+.5,'bo');
%         j=j-1;
%         for i=j:-1:1
%             pause(.25);
%             set(p,'XData',path(i,1)+.5,'YData',path(i,2)+.5);
%             drawnow ;
%         end;
%         plot(path(:,1)+.5,path(:,2)+.5);
    else
        fprintf('No solution found.\n');
    end
    
end

fprintf('\n');
toc;

fprintf('\nAll mazes explored.\n\n');

fprintf('Break ties with larger g-value\n\n')

tic;

for k = 1:length(mazes)
    fprintf('Searching maze %d... ', k);
    MAP = cell2mat(mazes(k));
    [path, flag, nodesExpanded] = search(MAP, 2, 2, 99, 99, 1);
    
    if (flag == 0)
        fprintf('Solution found in %d steps!\n', length(path(:,1)));
        numExpanded(k,2) = nodesExpanded;
%         j = size(path,1);
%         
%         %Plot the optimal path
%         p=plot(path(j,1)+.5,path(j,2)+.5,'bo');
%         j=j-1;
%         for i=j:-1:1
%             pause(.25);
%             set(p,'XData',path(i,1)+.5,'YData',path(i,2)+.5);
%             drawnow ;
%         end;
%         plot(path(:,1)+.5,path(:,2)+.5);
    else
        fprintf('No solution found.\n');
    end
    
end

fprintf('\n');
toc;

fprintf('\nAll mazes explored.');

totalSmall_g = 0;
totalBig_g = 0;

for i = 1:length(numExpanded(:,1))
    if numExpanded(i,1) > numExpanded(i,2)
        fprintf('Maze %d, more nodes expanded with small-g\n', i);
        totalSmall_g = totalSmall_g + 1;
    elseif numExpanded(i,1) < numExpanded(i,2)
        fprintf('Maze %d, more nodes expanded with big-g\n', i);
        totalBig_g = totalBig_g + 1;
    else 
        fprintf('Maze %d, same number of nodes expanded\n',i);
    end
end
        


%% Part 6

% size required to perform on a maze of size 1001 x 1001 would require
% 1,002,001 x sizeof(int) memory, since we are using only -1, 0, 1, and 2,
% we can use a short (which is just 2 bytes)

% assuming we are using a short, 4 MB will be able to hold a maze that has
% 2,000,000 nodes, which will be a 1414 x 1414 grid

% this does not include the size of the binary heap of the open list, nor
% does it include the closed list

