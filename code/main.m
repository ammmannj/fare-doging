% project: ticket evasion
% editor: Lukas, Jens
% HS 2012

clear all;
%profile on;

amountp=500;
steps=1000;
model={'random' 'line' 'station'};
amounti=3;
lambda=0.0006;

%{
stat2=[];

for i=1:5
    stat2 = [stat2;runsim(steps,amountp,i,0.05,model(3),0.005)];
end

figure;
i=1:steps;

plot(i,stat2(1,:),i,stat2(2,:),i,stat2(3,:),i,stat2(4,:),i,stat2(5,:));

legend('% dodging ins: 1','% dodging ins: 2','% dodging ins: 3','% dodging ins: 4','% dodging ins: 5', 'Location', 'Best');
xlabel('{\bf iteration steps}','fontsize',14);
ylabel('{\bf percentage of dodgers}','fontsize',14);
name = ['figure\station500-500-x.jpg'];
print('-djpeg95', name);


%%

stat2 = runsim(steps,amountp,amounti,0.05,model(1),0.1);
stat2 = [stat2;runsim(steps,amountp,amounti,0.05,model(1),0.05)];
stat2 = [stat2;runsim(steps,amountp,amounti,0.05,model(1),0.01)];
stat2 = [stat2;runsim(steps,amountp,amounti,0.05,model(1),0.005)];
stat2 = [stat2;runsim(steps,amountp,amounti,0.05,model(1),0.001)];


figure;
i=1:steps;

plot(i,stat2(1,:),i,stat2(2,:),i,stat2(3,:),i,stat2(4,:),i,stat2(5,:));

legend('% dodging random 0.1','% dodging random 0.05','% dodging random 0.01','% dodging random 0.005','% dodging random 0.001', 'Location', 'Best');
name = ['figure\random0,1-0,005.jpg'];
print('-djpeg95', name);
%}


   
    stat2=[];

    for i=1:3
        stat2 = [stat2;runsim(steps,amountp,amounti,0.05,model(i),lambda)];
    end
    i=1:3;
    figure; 
   
    subplot(2,1,1);
    plot(i,stat2(:,8).*100,'--g',i,stat2(:,9).*100,'--b')
    legend('% ppl doging','% ppl controlled w. doging', 'Location', 'WestOutside')

    subplot(2,1,2);
    plot(i,stat2(:,7).*100,'--c');
    legend('% controlled', 'Location', 'EastOutside');
    xlabel('{\bf 1:random, 2:line, 3:station}','fontsize',14);
    name = ['figure\fixedevery.jpg'];
    print('-djpeg95', name);

%}