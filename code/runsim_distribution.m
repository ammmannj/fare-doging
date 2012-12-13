function [stat,den_P,den_K] = runsim_distribution(steps,pass,insp,p,model)

%postcondition
%den [station x station]:atributes of nodes in each cell

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
den_P=zeros(size(net,1));
den_K=zeros(size(net,1));
[Passenger]=inPass(amount_passenger,p0_schwarz,station_mean,station_sigma,change_probe,net);

Way_P=zeros(amount_passenger,6);

A=zeros(42);
A=num2cell(A);

for p=1:amount_passenger
    Way_P(p,1:3)=Passenger{p,4}(1,:);    % fill in first way of Passenger
    Way_P(p,5)=1;                        % pendelschritt
end

if(amount_inspector>0)
    Way_K=inWay_K(amount_inspector,net);  %fill in first way of Inspectors
end

%Iteration
for i=1:itstep
  schwarz=0;
  erwischt=0;
  poskont=0;
  tours=0;
    
  %update Passenger
  
  for p=1:amount_passenger
    [Way_P(p,1:6), Passenger(p,1:4), schwarzp, toursp,A]= upPass(Way_P(p,1:6),Passenger(p,1:4),1,A); 
    schwarz=schwarz+schwarzp;
    tours=tours+toursp;
  end
  
  %update ticket inspector
  for p=1:amount_inspector
    [Way_P, Way_K, erwischtp, poskontp,A]= upKont(Way_P, Way_K, p,A);
    Way_K(p,:)=selectKway(net,1,Way_K(p,:),model,randi(10,1)/10);
    erwischt=erwischt+erwischtp;
    poskont=poskont+poskontp;
  end
  
  %update statistics
  Statistic(i,:)=[schwarz,erwischt,poskont,tours];
  for m=1:size(Way_P,1)
        den_P(Way_P(m,1),Way_P(m,2))=den_P(Way_P(m,1),Way_P(m,2))+1;
  end
  for m=1:size(Way_K,1)
        den_K(Way_K(m,1),Way_K(m,2))=den_K(Way_K(m,1),Way_K(m,2))+1;
  end

  %attNodes_P= attNodes_P+hist(Way_P(:,1),size(net,1));
  %attNodes_K= attNodes_K+hist(Way_K(:,1),size(net,1));
end

figure;
plot(1:itstep,Statistic(:,1),1:itstep,Statistic(:,2),1:itstep,Statistic(:,3),1:itstep,Statistic(:,4));
legend('schwarz','erwischt','poskont','tours','Location','best')
title([model 'p' num2str(pass) 'i' num2str(insp)]);
name = ['figure\' model 'p' num2str(pass) 'i' num2str(insp) '.jpg'];
print('-djpeg95', name);

[counts, percentage]=getstats(Statistic);
%[counts, percentage]=showstats(Statistic);
 den_P=den_P'+den_P;
 den_K=den_K'+den_K;

stat=[counts,percentage];
graph_distribution(den_K,model,insp,pass,'denK');
graph_distribution(den_P,model,insp,pass,'denP');
