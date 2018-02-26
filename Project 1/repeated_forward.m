function [] = repeated_forward(sX, sY, gX, gY, diagram, plotName)
%just an example of how to plot a point on the gui
plot(plotName, 2, 2, 'go');
    disp('here');


%open list properties
%=x;y;parent x; parent y; h(n); g(n);
open = [];
%closed list structure
%=x;y
closed = [];
diagram_size = size(diagram);
%%
k = 1;
for i = 1: diagram_size(1)
    for j = 1: diagram_size(2)
        if(diagram(i,j) == -1) %wall
            closed(k,1) = i;
            closed(k,2) = j;
            k = k+1;
        end
    end
end
%replace with if val == -1 add to closed ow move on
%%
%while((sX ~= gX || sY ~= gY) && NoPath ==1)
    
            
