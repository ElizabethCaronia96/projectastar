for i = 5: 50
    mapwidth = 101;
    mapheight = 101;
    randomStart = randi([1 mapwidth], 1, 2);
    diagram = my_dfs_load(randomStart(1),randomStart(2),mapwidth, mapheight);
    filename = ['loadmap_', num2str(i),'.dat'];
    csvwrite(filename,diagram)
end