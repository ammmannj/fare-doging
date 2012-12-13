function [Way_P, Way_K, erwischt, poskont,A] = upKont(Way_P, Way_K, KontID,A)

    %KontID: unique passenger ID, index in matrix
    %Way_P[n x 6]: matrix with all passenger ways
    %Way_K[m x 4]: matrix with all controller ways
    %model: controlling model
    %A: matrix with statistics about controls, fare-doging...
    
    orig=Way_K(KontID,1);
    dest=Way_K(KontID,2);
    line=Way_K(KontID,3);
    erwischt=0;
    poskont=0;
    
    %control the passengers
    [n,m]=size(Way_P);
    for i=1:n
        %see if control and passenger is on same wagon(tram)
       if Way_P(i,3)==line&&Way_P(i,1)==orig&&Way_P(i,2)==dest
           if ((Way_P(i,4)==1)&&Way_P(i,6)==0)
               erwischt=erwischt+1;
               A=statup(Way_P(i,1:3),2,A);
               Way_P(i,6)=1;
           elseif ((Way_P(i,6)~=1)&&Way_P(i,6)~=2)
                poskont=poskont+1;
                A=statup(Way_P(i,1:3),3,A);
                Way_P(i,6)=2;
           end
       end
    end
end