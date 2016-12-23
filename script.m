conf;
for j=1:length(queries)
    plotmeanexectime(queries{j},cores_per_executor,root_path,startingNode,endingNode);
end
