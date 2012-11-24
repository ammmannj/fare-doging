function [Way_P, Passenger, schwarz, tours] = upPass(Way, Passenger, PassID)

    %% 
    %PassID: unique passenger ID, index in matrix 
    %Way[n x 6]: matrix with all passenger ways; 
    %            start, dest, line, doging, pendelschritt, already
    %            controlled (erwischt)
    %Passenger[n x 4]: cell-matrix with properties of passengers;
    %                  initial probaility of taking a ticket, # of tours without control, dogging (yes=1,no=0), Passenger{PassID,4}
    %%%%%%%%%%%%%Passenger{PassID,4}[ x 3]: matrix with Passenger{PassID,4}
    %Statistic 
    
    lambda = 0.5;
    tours=0;
    
    %%
   
    schwarz=0; %number of 'fare-dogers'

    [maxschr]=size(Passenger{PassID,4},1);

    %update pendelschritt
    if Way(PassID,5)>=maxschr
        Way(PassID,5)=1;
    else
        Way(PassID,5)=Way(PassID,5)+1;
    end

    %% calculate fare-doging probability
    if Way(PassID,5)==1 %first station
        tours=tours+1;
        if Way(PassID,6)==1 %passenger just got controlled and was caught
            Passenger{PassID,2}=0;
            if rand(1,1)<=Passenger{PassID,1}
                    Way(PassID,4)=1;
                    Passenger{PassID,3}=1;
                    schwarz=schwarz+1;
            else
                Passenger{PassID,3}=0;
                Way(PassID,4)=0;
            end
        else %passenger didn't get caught ??
            Passenger{PassID,2}=Passenger{PassID,2}+1;
            if Passenger{PassID,3}==1 %passenger is doging
                Way(PassID,4)=1; % because he was doging last time he continues
                schwarz=schwarz+1;
            else
                %probability that passenger takes a ticket
                %Passenger{PassID,2}=(1-(1-Passenger{PassID,2})*(1-Passenger{PassID,1})); %geometic probability with p=starting probability (set at initialisation)
                actprob = Passenger{PassID,1}-Passenger{PassID,2}*((1-Passenger{PassID,1})/10); 
                actprob2 = Passenger{PassID,1}-Passenger{PassID,2}*Passenger{PassID,2}*((1-Passenger{PassID,1})/10); 
                if rand(1,1)<=actprob
                    Way(PassID,4)=1;
                    Passenger{PassID,3}=1;
                    schwarz=schwarz+1;
                end
            end 
        end  
    end
    
   
    
    %% update Way matrix
    Way(PassID,1)=Passenger{PassID,4}(Way(PassID,5),1);
    Way(PassID,2)=Passenger{PassID,4}(Way(PassID,5),2);
    Way(PassID,3)=Passenger{PassID,4}(Way(PassID,5),3);
    
    Way_P=Way;
    
    
end