all_files = dir('audio')';
files = [];

%Remove non audio files:
for j = 1 : length(all_files)
     if(contains(all_files(j).name, [".m4a",".wav"]))
         files = [files,string(all_files(j).name)];
     end    
end

files = sort(files);

data_count = length(files);

for i = 1 : data_count
    
    %Read and trim input data:
    file_name = files(i);
    name_temp = split(file_name,"_");
    source_dist(i) = name_temp(1);
    roomID(i) = (name_temp(2));
    temp = name_temp(3);
    temp = extractBefore(temp,".");
    trial(i) = temp;

    [measured_IR, Fs] = audioread("audio/"+file_name); 

    %Trim IR

    [~,max_ind] = max(abs(measured_IR));
    measured_IR = measured_IR( max_ind-pre_buffer : max_ind+len);
    IR_data(:,i) = measured_IR;
    
    
end