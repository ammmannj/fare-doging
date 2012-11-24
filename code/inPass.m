function [Passenger]= inPass(amount_passanger,p0_schwarz,station_mean,station_sigma,change_prob,net) 

%p0_schwarz: initual probability for fare evastion
%station mean: avrarage station traveld for the Pendelweg
%sigma: sigma of station traveld for the Pendelweg
%change_prop: passagiere können auch wieder auf selbe linie umsteigen !!
% initalisierung Matrix Passanger:colums 
%(initial probaility of taking a ticket, actual probaility of taking a ticket (inital 0), dogging (yes=1, no=0), pendelweg)

%% fill in P_initual_schwarz/ status schwarz
Passenger=zeros(amount_passanger,4);
Passenger=num2cell(Passenger);

for p=1:amount_passanger
    Passenger{p,1}= p0_schwarz;
%    Passenger{p,1}= randi([0,10])/10; %random probability for fare-doging %{p0_schwarz};                                            %fill in P_schwarz to matrix Passanger
%   not needed happens in Passenger update function   
%    if rand()<p0_schwarz                                                        % fill in column dogging
%        Passenger(p,3)={1};
%    else
%        Passenger(p,3)={0};  
%    end
end

%%fill in Pendelweg
Passchange(:,1)= round(randn(amount_passanger,1)*station_sigma+station_mean);%how many time changes passanger for their workingway
for p=1:amount_passanger
 clear way;
 
 way=zeros(1,3);
 
 way(1,1) = randi([ 1 , size(net,1)]);                                      %implement starting position and fist to way
 
 way(1,:) = selectLine(net,way(1,1));
 
 
for i=1:Passchange(p)-1                                                     %iteration über Pendelweg Hinausfahren
    
    if change_prob>rand()                                                   %Passanger change line
    
    way(1+i,:)=selectLine(net,way(i,2));   
    
    else                                                                    %Passanger doesn't change line
    sto=0;
        
    for n=1:size(net,1)                                                     %see where line goes next --cell n and cellelement m
        for m=1:size(net{way(i,2),n},2)
              if  (net{way(i,2),n}(1,m)==way(i,3)) && (n~=way(i,1))         %Passanger can continue on the line
                
              way(i+1,1)=way(i,2);
              way(i+1,2)= n;   
              way(i+1,3)=way(i,3);
              sto=1;
                
              end
            
        end
    end
    if sto==0;
              way(i+1,1)=way(i,2);                                          %reach edge pont, Passanger must go back with same line
              way(i+1,2)= way(i,1);   
              way(i+1,3)=way(i,3);
    end  
    
    
    
    end
    
end


for i=Passchange(p)+1:2*Passchange(p)                                       %iteration over way home
       
    way(i,1)=way(2*Passchange(p)-i+1,2);
    way(i,2)=way(2*Passchange(p)-i+1,1);   
    way(i,3)=way(2*Passchange(p)-i+1,3);
    
    
end    
Passenger(p,4)={way};                                                         %write way to passanger matrix


end

end