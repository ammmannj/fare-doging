function [stat] = runsim(steps,pass,insp,p)

%% simulation parameter
%-------------------------------------------------------------------------
itstep=steps;            % iteration steps
amount_passenger=pass;    % amount of Passenger
amount_inspector=insp;    % amount of ticket inspectors
p0_schwarz=p;        % initual evation probability and initual evation fraction
change_probe=0.4;

%Pendelweg
station_mean=4.6;       %mittlerer Weg Pendelhinfahrweg
station_sigma=2.1;              %stantartabweichung vom Pendehinfahrtweg

%-------------------------------------------------------------------------

%% Initialisation
net=createNetz;
[Passenger]=inPass(amount_passenger,p0_schwarz,station_mean,station_sigma,change_probe,net);

Way_P=zeros(amount_passenger,6);

for p=1:amount_passenger
    Way_P(p,1:3)=Passenger{p,4}(1,:);    % fill in first way of Passenger
    Way_P(p,5)=1;                        % pendelschritt
end

Way_K=inWay_K(amount_inspector,net);  %fill in first way of Inspectors

%Iteration
for i=1:itstep
  schwarz=0;
  erwischt=0;
  poskont=0;
  tours=0;
    
  %update Passenger
  
  for p=1:amount_passenger
    [Way_P(p,1:6), Passenger(p,1:4), schwarzp, toursp]= upPass(Way_P(p,1:6),Passenger(p,1:4),1); 
    schwarz=schwarz+schwarzp;
    tours=tours+toursp;
  end
  
  %update ticket inspector
  for p=1:amount_inspector
    [Way_P, Way_K, erwischtp, poskontp]= upKont(Way_P, Way_K, p, inWay_K(1,net)); %give random position
    erwischt=erwischt+erwischtp;
    poskont=poskont+poskontp;
  end
  
  %update statistics
  Statistic(i,:)=[schwarz,erwischt,poskont,tours];
  
end

[counts, percentage]=getstats(Statistic);
%[counts, percentage]=showstats(Statistic);

stat=[counts,percentage,];
