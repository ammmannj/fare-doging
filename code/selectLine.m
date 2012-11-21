function [origin, aim, line]=selectLine(net, Position)

%selects a a random aim and line from a given position
counter=0;
for i=1:size(net,1)
    if (net{i,Position} ~= zeros(size(net{i,Position})))
    counter=counter+1;
    connection(counter)=i;
    
    end
end    
    aim=connection(randi([1,size(connection,2)]));                             %select aim
    line=net{aim, Position}(1,randi(size(net{aim,Position})));              %select origin
    origin=Position;
