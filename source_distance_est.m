%%  Measument of Distance from Direct and Reverberant Energy
% Audio files should be saved in "audio" folder, and named "d_room_trial.m4a", where d
% is the source distance in meters, room is the room ID, and trial is the trial number.

close all;
clear all;
clc;


%% Create variables

len = 44100*.8; %Total length
pre_buffer = 5; %Samples
impulse_len = 100; %Length of actual impulse in samples
rev_start = 800; %Beginning of reverb in samples
smoothing = 500; %Amount of smoothing
scale = 10; %Scales range of mesured R/D ratio

plot_map = containers.Map; %Used for plotting data
for k = 4:2:16
    plot_map(num2str(k)) = [];
end

results = []; %Vector to hold results


%% Process each file

audio_load; %Load files from folder

for i = 1 : data_count
    
    measured_IR = IR_data(:,i); %Read IR
    measured_IR = measured_IR.^2; %Square signal to express in terms of energy
    
    
    %Separate reveberb/direct
    direct = measured_IR( 1:impulse_len );
    reverb = measured_IR( rev_start:end );
   
    %Calculate energy
    direct_energy = sum( direct );
    rev_energy = sum( reverb );
 
    %Extract decay parameters
    [tau, ~] = verb_params( reverb, Fs );
    tau_vals(i) = tau;
    
    ratio(i) = scale*rev_energy/(direct_energy); %R/D energy ratio
    
    dist(i) = str2num( source_dist(i) );
    results = [results, IR(dist(i),roomID(i),trial(i),tau,ratio(i),measured_IR)]; %Store results
    plot_map(source_dist(i)) = [plot_map(source_dist(i)), ratio(i)]; %For plotting
     
end 
   

%% Plot Results:

tau_avg = -mean(tau_vals); %Find averge time constant for room normilzation

%Scatter Plot:
figure();
plt = scatter(dist,ratio./(tau_avg),'Marker','x');
plt.MarkerFaceColor = '#ff4105';
plt.LineWidth = 1.2;
xlim([2,18]);
xlabel('Source Distance (ft)', 'FontSize', 13);
ylabel('R/D Energy Ratio (arbitrary units)', 'FontSize', 13);
title('Ratio of Reverberant to Direct Energy vs. Source Distance (Room ' + results(1).room_ID +")", 'FontSize', 16);

%Line Plot:

figure();
d = [4:2:16];

%Generate plot:
for i = 2:8
    plot_map(num2str(i*2)) = plot_map(num2str(i*2))./tau_avg;
    y(i-1) = mean(plot_map(num2str(i*2)));
    err(i-1) = std(plot_map(num2str(i*2)));
end

plt = errorbar(d,y,err,'Marker','.','MarkerSize',15);
plt.Color = '#ff4105';
plt.LineWidth = 1.2;
xlim([2,18]);
xlabel('Source Distance (ft)', 'FontSize', 13);
ylabel('R/D Energy Ratio (arbitrary units)', 'FontSize', 13);
title('Ratio of Reverberant to Direct Energy vs. Source Distance (Room ' + results(1).room_ID +")", 'FontSize', 16);



