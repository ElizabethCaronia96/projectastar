function [ exp_array ] = expand_array( node_x, node_y, gn, xTarget, yTarget, CLOSED, MAX_X, MAX_Y )
% Takes a node and returns the expanded list of successors, with the
% calculated fn values
% None of the successors may belong to the CLOSED list

exp_array = [];
exp_count = 1;

c2 = size(CLOSED,1); % number of elements in CLOSED including the zeros
for k = 1:-1:-1
    for j = 1:-1:-1
        if (k ~= j || k ~= 0)
            if (~xor(j,k) == 1)
                continue;
            end
            
            s_x = node_x + k;
            s_y = node_y + j;
            
            if ((s_x > 0 && s_x <= MAX_X) && (s_y > 0 && s_y <= MAX_Y))
                flag = 1;
                for c1 = 1:c2
                    if (s_x == CLOSED(c1,1) && s_y == CLOSED(c1,2))
                        flag = 0;
                    end
                end
                
                if (flag == 1)
                    exp_array(exp_count, 1) = s_x;
                    exp_array(exp_count, 2) = s_y;
                    exp_array(exp_count, 3) = gn + distance(node_x, node_y, s_x, s_y);
                    exp_array(exp_count, 4) = distance(xTarget, yTarget, s_x, s_y);
                    exp_array(exp_count, 5) = exp_array(exp_count, 3) + exp_array(exp_count, 4);
                    exp_count = exp_count + 1;
                end
            end
        end
    end
end

end

