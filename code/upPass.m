function [Way_P, Passenger, schwarz, tours,A] = upPass(Way, Passenger, PassID,A,lambda)

    %% 
    %PassID: unique passenger ID, index in matrix 
    %Way[n x 6]: matrix with all passenger ways; 
    %            start, dest, line, doging, pendelschritt, already
    %            controlled (erwischt) =1 odr =2 for controlled with a
    %            ticket
    %Passenger[n x 4]: cell-matrix with properties of passengers;
    %                  initial probaility of taking a ticket, # of tours without control, dogging (yes=1,no=0), Passenger{PassID,4}
    %%%%%%%%%%%%%Passenger{PassID,4}[ x 3]: matrix with Passenger{PassID,4}
    %Statistic 
    
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
    
    
    %first station
    if Way(PassID,5)==1 
        %passenger just got controlled and was caught
        if Way(PassID,6)==1 
            Passenger{PassID,2}=0;
            Passenger{PassID,3}=0;
            Way(PassID,4)=0;
            Way(PassID,6)=0;
        %passenger just got controlled and had a ticket
        elseif (Way(PassID,6)==2)
            Passenger{PassID,2}=0;
            Passenger{PassID,3}=0;
            Way(PassID,4)=0;
            Way(PassID,6)=0;
        else
            Way(PassID,6)=0;
            %passenger is doging
            if Passenger{PassID,3}==1 
                % because he was doging last time he continues
                Way(PassID,4)=1; 
                Way(PassID,6)=0;
            else
                %probability that passenger takes a ticket
                %Passenger{PassID,2}=(1-(1-Passenger{PassID,2})*(1-Passenger{PassID,1})); %geometic probability with p=starting probability (set at initialisation)
                %actprob =  1-Passenger{PassID,1}-Passenger{PassID,2}*((1-Passenger{PassID,1})/10);
                %actprob2 = 1-Passenger{PassID,1}-Passenger{PassID,2}*Passenger{PassID,2}*((1-Passenger{PassID,1})/10)
                actprob3 = exp(-lambda*Passenger{PassID,2});
                ran = rand(1,1);
                if ran>actprob3
                    Way(PassID,4)=1;
                    Passenger{PassID,3}=1;
                    %ran
                    %actprob3
                else
                    %disp('ran<');
                end
            end 
            Passenger{PassID,2}=Passenger{PassID,2}+1;
        end  
    else
        if Way(PassID,6)==1
            Passenger{PassID,2}=0;
            Passenger{PassID,3}=0;
            Way(PassID,4)=0;
            Way(PassID,6)=0;
        elseif Way(PassID,6)==2
            Way(PassID,4)=0;
            Way(PassID,6)=0;
            Passenger{PassID,2}=0;
            Passenger{PassID,3}=0;
        elseif Way(PassID,6)==0
            
        end
    end
    
    %if passenger is doging between actual stations update statistics
    if Way(PassID,4)==1
        schwarz=schwarz+1;
        A=statup(Way(PassID,1:3),0,A);
    end
    
    %update statistics
    tours=tours+1;
    A=statup(Way(PassID,1:3),1,A);
    
    %% update Way matrix
    Way(PassID,1)=Passenger{PassID,4}(Way(PassID,5),1);
    Way(PassID,2)=Passenger{PassID,4}(Way(PassID,5),2);
    Way(PassID,3)=Passenger{PassID,4}(Way(PassID,5),3);
    
    Way_P=Way;
    
    
end