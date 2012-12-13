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
    M=zeros(42,42);
    for m=1:42
       for n=1:42 
           if (net{m,n}~=0)
                M(m,n)=1;
           end  
       end
    end
    M=sparse(M);

    for p=1:amount_passanger
        Passenger{p,1}= p0_schwarz;                                   
    %fill in P_schwarz to matrix Passanger
    end

    for p=1:amount_passanger
         clear way;

         source=randi(42,1);
         dest=source;
         while(dest==source)
             dest=randi(42,1);
         end
        
         %compute shortest path
         [dist,path,pred]=graphshortestpath(M,source,dest,'DIRECTED',false);
         way=zeros(1,3);
         line=0;
         for i=1:dist
             way(i,1)=path(i);
             way(i,2)=path(i+1);
             way(i,3)=findline(net,path(i),path(i+1),line);
             line=way(i,3);
         end     
        
        %compute way home
        tmpway=way(:,1);
        tway=way;
        tway(:,1)=tway(:,2);
        tway(:,2)=tmpway;
        
        way=[way;flipud(tway)];
        
        Passenger(p,4)={way};                                                         %write way to passanger matrix


    end
end