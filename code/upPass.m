function [Way_P,Passenger, Statistic] = upPass(Way,Passenger,PassID, Statistic)

    %PassID: unique passenger ID, index in matrix
    %Way[n x 5]: matrix with all passenger ways
    %Passenger[n x 3]: cell-matrix with properties of passengers
    %pendelweg[ x 3]: matrix with pendelweg

    pendelweg = Passenger{PassID,3};
    schwarz=0; %number of 'fare-dogers'

    [maxschr,k]=size(pendelweg);

    %update pendelschritt
    if Way(PassID,5)>=maxschr
        Way(PassID,5)=1;
    else
        Way(PassID,5)=Way(PassID,5)+1;
    end

    %calculate fare-doging probability
    if Way(PassID,6)==1
        Passenger{PassID,1}=0;
        Passenger{PassID,2}=0;
        Way(PassID,4)=0;
    else
        if Passenger{PassID,2}==1
            Way(PassID,4)=1;
            schwarz=schwarz+1;
        else
            Passenger{PassID,1}=Passenger{PassID,1}+0.05; %probability
            if rand(1,1) <=Passenger{PassID,1}
                Way(PassID,4)=1;
                Passenger{PassID,2}=1;
                schwarz=schwarz+1;
            end
        end
    end
    
    %update Way matrix
    Way(PassID,1)=pendelweg(Way(PassID,5),1);
    Way(PassID,2)=pendelweg(Way(PassID,5),2);
    Way(PassID,3)=pendelweg(Way(PassID,5),3);
    
    
    %update statistics
    [n,m]=size(Statistic);
    Statistic=zeros(n+1,m)+[Statistic(1:n-1,:);[schwarz,0,0];zeros(1,m)];
    
    Way_P=Way;
    
end