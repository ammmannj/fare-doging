function A = statup(Way,arg,A)
    %arg:
    %0:doging
    %1:ride
    %2:erwischt
    %3:poskont
    %
    if(arg==0)
        A{Way(1,1),Way(1,2)}=A{Way(1,1),Way(1,2)}+[1,0,0,0];
    end
    if(arg==1)
        A{Way(1,1),Way(1,2)}=A{Way(1,1),Way(1,2)}+[0,1,0,0];
    end
    if(arg==2)
        A{Way(1,1),Way(1,2)}=A{Way(1,1),Way(1,2)}+[0,0,1,0];
    end
    if(arg==3)
        A{Way(1,1),Way(1,2)}=A{Way(1,1),Way(1,2)}+[0,0,0,1];
    end
end