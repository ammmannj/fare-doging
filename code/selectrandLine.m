function x=selectrandLine(net, Position)

%selects a a random aim and line from a given position
counter=0;
for i=1:size(net,1)
    if (net{i,Position} ~= 0)
        counter=counter+1;
        connection(counter)=i;
    end
end    
    %select aim
    aim=connection(randi([1,size(connection,2)])); 
    %select origin
    line=net{aim, Position}(1,randi(size(net{aim,Position})));              
    
    x=[Position,aim,line];