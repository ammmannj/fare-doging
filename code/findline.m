function line = findline(net,s,d,l)

lines = net{s,d};
li = length(lines);
line = 0;

%if line continues, take this one
for i=1:li
   if(lines(i)==l)
       line = l;
   end
end

%need to change the line (take random)
if(line==0)
    line=lines(randi(li,1));
end