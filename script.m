conf;


for i=startingNode:endingNode
    for j=1:length(queries)
        plotmeanexectime(i,queries{j});
    end
end

function plotmeanexectime(node,query)
    file_regex = 'application_([0-9]+)_([0-9]+)_csv';
    executors_regex = '([0-9]+)Executors';
    num_regex = '([0-9]+)';
    folders = {};
    executors = [];
    formatspec = '%s%s';
    batch = {};
    totExecs = [];
    execs = [];
    directory = strcat('./tmp/',num2str(node),'Nodes/',query);
    executors_files = dir(directory);
    
    for i=1:length(executors_files)
        if(~isempty(regexp(executors_files(i).name,executors_regex,'once')))
            folders{length(folders)+1} = executors_files(i).name;
        end
    end
    for j=1:length(folders)
        item = folders{j};
        [startIndex, endIndex] = regexp(item,num_regex);
        executorIndex = str2double(item(startIndex:endIndex));
        files = dir(strcat(directory,'/', folders{j}));
        for i=1:length(files)
          if(~isempty(regexp(files(i).name,file_regex, 'once')))
            batch{length(batch)+1} = files(i).name;
          end
        end
        for i=1:length(batch)
            tmp = readtable(strcat(directory,'/',item,'/',batch{i},...
                '/app_1.csv'),...
            'Delimiter',',','Format',formatspec);
            execs = [execs, str2double(tmp{2,2}{1})-str2double(tmp{1,2}{1})];
        end
        totExecs = [totExecs; int32(mean(execs))];
        executors = [executors, executorIndex];
        batch = {};
        execs = [];
    end
    title_string = strcat(num2str(node),' Nodes ','Query ',query);
    figure;
    bar(executors, totExecs);
    xlabel('Executors');
    ylabel('Execution time');
end

