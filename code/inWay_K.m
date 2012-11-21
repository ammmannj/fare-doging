function [Way_K]=inWay_K(amount_inspector,net)

Position=randi([1,41],amount_inspector,1);

for p=1:amount_inspector
   Way_K(p,1:3)= selectLine(net,Position(p));
end

end