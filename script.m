conf;


for i=startingNode:endingNode
    for j=1:length(queries)
        plotmeanexectime(i,queries{j});
    end
end


