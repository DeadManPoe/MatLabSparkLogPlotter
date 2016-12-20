file_regex = 'application_([0-9]+)_([0-9]+)_csv';
directory = './tmp/7Nodes/q26/12Executors'
files = dir(directory);
batch = [];
execs = [];
for i=1:length(files)
  if(length(regexp(files(i).name,file_regex)) ~=0)
    batch = [batch;files(i).name];
  end
end
for i=1:length(batch)
  tmp = csvread(strcat(directory,batch(0),'app_1.csv'),2,0);
  tmp
end
