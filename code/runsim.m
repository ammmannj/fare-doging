function [stat] = runsim(steps,pass,insp,Ichange,model,lambda_dodg)

%% simulation parameter
%-------------------------------------------------------------------------
itstep=steps;            % iteration steps
amount_passenger=pass;    % amount of Passenger
amount_inspector=insp;    % amount of ticket inspectors
p0_schwarz=1;        % initual evation probability and initual evation fraction
change_probe=0.4;

%Pendelweg
station_mean=4.6;       %mittlerer Weg Pendelhinfahrweg
station_sigma=2.1;              %stantartabweichung vom Pendehinfahrtweg

%-------------------------------------------------------------------------

%% Initialisation
net=createNetz;
[Passenger]=inPass(amount_passenger,p0_schwarz,station_mean,station_sigma,change_probe,net);

Way_P=zeros(amount_passenger,6);

A=zeros(42);
A=num2cell(A);

for p=1:amount_passenger
    % fill in first way of Passenger
    Way_P(p,1:3)=Passenger{p,4}(1,:);  
    % pendelschritt
    Way_P(p,5)=1;                        
end

if(amount_inspector>0)
    %fill in first way of Inspectors
    Way_K=inWay_K(amount_inspector,net);  
end

%Iteration
for i=1:itstep
  schwarz=0;
  erwischt=0;
  poskont=0;
  tours=0;
    
  %update Passenger
  
  for p=1:amount_passenger
    [Way_P(p,1:6), Passenger(p,1:4), schwarzp, toursp,A]= upPass(Way_P(p,1:6),Passenger(p,1:4),1,A,lambda_dodg); 
    schwarz=schwarz+schwarzp;
    tours=tours+toursp;
  end
  
  %update ticket inspector
  for p=1:amount_inspector
    [Way_P, Way_K, erwischtp, poskontp,A]= upKont(Way_P, Way_K, p,A);
    Way_K(p,:)=selectKwaynew(net,1,Way_K(p,:),model,Ichange);
    erwischt=erwischt+erwischtp;
    poskont=poskont+poskontp;
  end
  
  
  %update statistics
  Statistic(i,:)=[schwarz,erwischt,poskont,tours];
  
end

stat = [(Statistic(:,1)./tours)'];
figure;
plot(1:itstep,Statistic(:,1),1:itstep,Statistic(:,2),1:itstep,Statistic(:,3),1:itstep,Statistic(:,4));
legend('schwarz','erwischt','poskont','tours','Location','best')
%title([model 'p' num2str(pass) 'i' num2str(insp)]);
%name = ['figure\' model 'p' num2str(pass) 'i' num2str(insp) '.jpg'];
%print('-djpeg95', name);

[counts, percentage]=getstats(Statistic);

stat=[counts,percentage];
%graph(A,model,insp,pass);
