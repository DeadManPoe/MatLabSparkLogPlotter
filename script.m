conf;
for i=startingNode:endingNode
    for j=1:length(queries)
        plotmeanexectime(i,queries{j},cores_per_executor,root_path);
    end
end


