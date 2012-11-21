% project: ticket evasion
% editor: Lukas, Jens
% HS 2012



clear all;

%% simmulation parameter
%-------------------------------------------------------------------------
itstep=10;            % iteration steps
amount_passanger=100;    % amount of passanger
amount_inspector=10;    % amount of ticket inspectors
p0_schwarz=0.1;        % initual evation probability and initual evation fraction
change_probe=0.4;

%Pendelweg
station_mean=4.6;       %mittlerer Weg Pendelhinfahrweg
station_sigma=2.1;              %stantartabweichung vom Pendehinfahrtweg

%-------------------------------------------------------------------------

%% Initialisation
net=createNetz;
[Passanger]=inPass(amount_passanger,p0_schwarz,station_mean,station_sigma,change_probe,net);

Way_P=zeros(amount_passanger,5);

for p=1:amount_passanger
Way_P(p,1:3)=Passanger{p,4}(1,:);    % fill in first way of Passanger
Way_P(p,4:5)=[Passanger{p,3},1];    % fill in dogging and pendelschritt
end

Way_K=inWay_K(amount_inspector,net);  %fill in first way of Passanger
                                                                            
Statistic=zeros(itstep,3);




%{ 
Iteration
for i=1:itstep
  
  %update Passanger
  for p=1:amount_passanger
    [Way_P(p,:),Passanger, Statistic]= upPass(Way_P,Passanger,p,Statistic); 
  end
  
  %update ticket inspector
  
  %upadate statistic
  
end

%}

% detemination of output values


