function [tau,A] = verb_params(reverb,Fs)

%DESCRIPTION: Finds exponential time constant for reverb decay

start_offset = 1000;

reverb = reverb(start_offset:end);

t = (0:length(reverb)-1)/Fs; %Time in s
exp_fit = fit(t',reverb,'exp1');

tau = exp_fit.b;
A = exp_fit.a;


end

