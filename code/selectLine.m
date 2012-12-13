function newWay =selectLine(net,lastWay,stay_change)

%stay_change: 'stay' passenger stay on line, 
%             'change' passenger change line
%'stay':selects a a random new aim and line from a given position
%'stay' and 'change': if passenger is at death end(node with only one edge): x --> 0


%%check if passenger reaches death end
counter=0;

for k=1:size(net,1) %counts available directions
    %lastWay(2)
    if (net{k,lastWay(2)}~=0) %select available connections
        if(k~=lastWay(1)); %avoid last direction
        counter=counter+1;
        connection(counter)=k;
        end
    end
end   

if (counter==0) %if death end (node with only one edge) is reached
    newWay=[lastWay(2),lastWay(1),lastWay(3)];
    return;
end
%% Passanger stay
if (strcmp(stay_change,'stay')==1)
     %see where line goes next --cell n and cellelement m
    for n=1:size(net,1)                                                     
        for m=1:size(net{lastWay(2),n},2)
             %Passanger can continue on the line 
            if  (net{lastWay(2),n}(1,m)==lastWay(3)) && (n~=lastWay(1))         
              newWay(1)=lastWay(2);
              newWay(2)= n;   
              newWay(3)=lastWay(3);
            else
                  stay_change='change';
            end
            
        end
    end  
    
end

%% Passenger channge
if (strcmp(stay_change,'change')==1)
    %select aim
    aim=connection(randi([1,size(connection,2)])); 
    %select line
    line=net{aim,lastWay(2)}(1,randi(size(net{aim,lastWay(2)})));              
    newWay=[lastWay(2),aim,line];
end


