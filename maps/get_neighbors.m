function [neighbors] = get_neighbors(x, y, mapwidth, mapheight)
neighbors = [];
count = 0;
for xx = -1: 1
    for yy = -1:1
        if (xx == 0 && yy == 0)
            continue
        elseif((xx + x)>0 && (xx +x)<= mapwidth && (y + yy)>0 && (y+yy)<= mapheight)
            count = count +1;
            neighbors(1,count) = x + xx;
            neighbors(2, count) = y + yy;
        end
    end
end
end
