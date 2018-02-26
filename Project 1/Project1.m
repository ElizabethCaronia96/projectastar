%%

clc, clear, close all

% %%  Generate grid worlds
% 
% % Define the 2-d map array
% MAX_X = 10;
% MAX_Y = 10;
% 
% MAX_VAL = 10;
% 
% % this array stores the coordinates of the map and the objects in each
% % coordinate
% MAP = 2*(ones(MAX_X, MAX_Y));
% 
% % obtain the obstacles, target, and robot position
% % initialize the MAP with input values
% % obstacle = -1, target = 0, Robot = 1, space = 2
% j = 0;
% x_val = 1;
% y_val = 1;
% axis([1 MAX_X+1 1 MAX_Y+1]);
% grid on;
% hold on;
% n = 0; %number of obstacles
% 
% % Begin interactice obstacle, target, start location selection
% pause(1);
% 
% h = msgbox('Select the target');
% uiwait(h, 5);
% 
% if ishandle(h) == 1
%     delete(h);
% end
% 
% xlabel('Select the target');
% 
% but = 0;
% while (but ~= 1) % repear until the left button is not clicked
%     [xval, yval, but] = ginput(1);
% end
% 
% xval = floor(xval);
% yval = floor(yval);
% 
% xTarget = xval;  % coordinate of the target
% yTarget = yval;  % coordinate of the target
% 
% MAP(xval, yval) = 0;  % initialize MAP with location of the target
% plot(xval+ 0.5, yval + 0.5, 'gd');
% text(xval+1, yval+0.5, 'Target');
% 
% pause(2);
% h = msgbox('Select obstacles');
% xlabel('Select obstacles');
% 
% uiwait(h, 10);
% if ishandle(h) == 1
%     delete(h);
% end
% 
% while but == 1
%     [xval, yval, but] = ginput(1);
%     xval = floor(xval);
%     yval = floor(yval);
%     MAP(xval,yval) = -1;  %put on the closed list as well
%     plot(xval+0.5, yval+.5, 'ro');
% end
% 
% pause(1);
% 
% h = msgbox('Select the Agent position');
% uiwait(h,5);
% if ishandle(h) == 1
%     delete(h);
% end
% 
% xlabel('Select the Agent position');
% but = 0;
% while (but ~= 1)
%     [xval, yval, but] = ginput(1);
% end
% 
% xval = floor(xval);
% yval = floor(yval);
% 
% xStart = xval;
% yStart = yval;
% 
% MAP(xval, yval) = 1;
% plot(xval+0.5, yval+0.5, 'bo');
%%
clc, clear, close all


mazes = [];
for i = 1:51
    [lines,MAP, hist, result] = maze(50,50);
    MAP(2,2) = 0;
    MAP(99, 99) = 1;
    % mazes(i) = MAP %doesnt work lol
    
    % creates the mazes
end


%% Perform search on grid world

[path, flag] = search(MAP, 2, 2, 99, 99);

%% Plot paths (if necessary)

if (flag == 0)
    j = size(path,1);
    
    %Plot the optimal path
    p=plot(path(j,1)+.5,path(j,2)+.5,'bo');
    j=j-1;
    for i=j:-1:1
        pause(.25);
        set(p,'XData',path(i,1)+.5,'YData',path(i,2)+.5);
        drawnow ;
    end;
    plot(path(:,1)+.5,path(:,2)+.5);
else
    pause(1);
    h=msgbox('Sorry, No path exists to the Target!','warn');
    uiwait(h,5);
end