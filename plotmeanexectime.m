function plotmeanexectime(query,cores_per_executor,root_path,startingNode,endingNode)
    file_regex = 'application_([0-9]+)_([0-9]+)_csv';
    executors_regex = '([0-9]+)Executors';
    num_regex = '([0-9]+)';
    folders = {};
    executors = [];
    formatspec = '%s%s';
    batch = {};
    totExecs = [];
    execs = [];
    for k=startingNode:endingNode
        directory = strcat(root_path,num2str(k),'Nodes/',query);
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
            executors = [executors, executorIndex*cores_per_executor];
            batch = {};
            execs = [];
        end
        folders= {};
    end
    title_string = query;
    figure;
    plot(executors, totExecs,'o r');
    title(title_string);
    xlabel('Executors Cores');
    ylabel('Execution time');
end
