file_regex = 'application_([0-9]+)_([0-9]+)_csv';
directory = './tmp/7Nodes/q26/12Executors'
files = dir(directory);
formatspec = '%s%s'
batch = [];
execs = [];
for i=1:length(files)
  if(length(regexp(files(i).name,file_regex)) ~=0)
    batch{length(batch)+1} = files(i).name;
  end
end
for i=1:length(batch)
  tmp = readtable(strcat(directory,'/',batch{i},'/app_1.csv'),...
  'Delimiter',',','Format',formatspec);
  execs{length(execs)+1} = str2num(tmp{2,2}{1})-str2num(tmp{1,2}{1})
end
int32(mean(cell2mat(execs)))
