function [newWay]=selectKway(net,Inspector_ID,lastWay,model,modelproperty1)

%upgrates Inspector Way of the Inspector with respectiv ID
%newWay [3 x amount inspector]: new way of inspectors 
%Inspector_ID:
%lastWay: [3 x amount inspector]
%model: 'random' --> movement with change line probablitiy p=
%modelproperty1
%'line' --> inspectors do not change line 
%'station' --> inspectors shuttles between two stations

%%random
    if (strcmp(model,'random')==1)
        if (rand()<modelproperty1)
             newWay= selectLine(net,lastWay(Inspector_ID,:),'change');
        else
            %see where line goes next --cell n and cellelement m
              for n=1:size(net,1)                                                     
                    for m=1:size(net{lastWay(Inspector_ID,2),n},2)
                        %Passanger can continue on the line
                          if  (net{lastWay(Inspector_ID,2),n}(1,m)==lastWay(Inspector_ID,3)) && (n~=lastWay(Inspector_ID,1))          
                              newWay(Inspector_ID,1)=lastWay(Inspector_ID,2);
                              newWay(Inspector_ID,2)= n;   
                              newWay(Inspector_ID,3)=lastWay(Inspector_ID,3);
                          else
                              newWay(Inspector_ID,1)=lastWay(Inspector_ID,2);
                              newWay(Inspector_ID,2)=lastWay(Inspector_ID,1);   
                              newWay(Inspector_ID,3)=lastWay(Inspector_ID,3); %end of line
                          end
                    end
             end  
        end
    end

%%line
    if (strcmp(model,'line')==1)
             %see where line goes next --cell n and cellelement m
            for n=1:size(net,1)                                                     
                    for m=1:size(net{lastWay(Inspector_ID,2),n},2)
                        %Passanger can continue on the line 
                          if  (net{lastWay(Inspector_ID,2),n}(1,m)==lastWay(Inspector_ID,3)) && (n~=lastWay(Inspector_ID,1))         
                              newWay(Inspector_ID,1)=lastWay(Inspector_ID,2);
                              newWay(Inspector_ID,2)= n;   
                              newWay(Inspector_ID,3)=lastWay(Inspector_ID,3);
                          else
                              newWay(Inspector_ID,1)=lastWay(Inspector_ID,2);
                              newWay(Inspector_ID,2)=lastWay(Inspector_ID,1);   
                              newWay(Inspector_ID,3)=lastWay(Inspector_ID,3); %end of line
                          end
                    end
             end  

    end
    %%station
    if (strcmp(model,'station')==1)
        newWay(Inspector_ID,1)=lastWay(Inspector_ID,2);
        newWay(Inspector_ID,2)=lastWay(Inspector_ID,1);   
        newWay(Inspector_ID,3)=lastWay(Inspector_ID,3);
    end
end