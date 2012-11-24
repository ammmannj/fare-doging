function [Way_P, Way_K, erwischt, poskont] = upKont(Way_P, Way_K, KontID, model)

    Way_K(KontID,1)=model(1,1);
    Way_K(KontID,2)=model(1,2);
    Way_K(KontID,3)=model(1,3);

    %KontID: unique passenger ID, index in matrix
    %Way_P[n x 5]: matrix with all passenger ways
    %Way_K[m x 4]: matrix with all controller ways
    %model: controlling model
    %Statistic: matrix with statistics about controls, fare-doging...
    
    orig=Way_K(KontID,1);
    dest=Way_K(KontID,2);
    line=Way_K(KontID,3);
    erwischt=0;
    poskont=0;
    
    %control the passengers
    [n,m]=size(Way_P);
    for i=1:n
       if Way_P(i,3)==line&&Way_P(i,1)==orig&&Way_P(i,2)==dest
           if ((Way_P(i,4)==1)&&Way_P(i,6)~=1)
               erwischt=erwischt+1;
               Way_P(i,6)=1;
           else
               poskont=poskont+1;
           end
       end
    end
    

end