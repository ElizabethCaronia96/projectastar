for i = 51: 53
    mapwidth = 10;
    mapheight = 10;
    randomStart = randi([1 mapwidth], 1, 2);
    diagram = my_dfs_load(randomStart(1),randomStart(2),mapwidth, mapheight);
    filename = ['loadmap_', num2str(i),'.dat'];
    csvwrite(filename,diagram)
end