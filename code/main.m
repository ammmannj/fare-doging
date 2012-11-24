% project: ticket evasion
% editor: Lukas, Jens
% HS 2012

clear all;
profile on;

%run the simulation with varying parameters

maxsteps=100; %2000;
maxamountp=100; %50000;
maxamounti=1; %100;

figure;
for i=100:maxsteps/10:maxsteps
    for amountp=10:maxamountp/10:maxamountp
        for amounti=1:maxamounti/10:maxamounti
            for p=0.9%0:0.1:1
                stat = [stat,runsim(steps,amountp,amounti,p)]; 
            end
        end
    end
end

for k=1:8
    subplot(4,2,k);
    plot(
end

profile viewer;