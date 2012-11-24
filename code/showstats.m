function [counts,percentage] = showstats(Statistic)


controldoging = sum(Statistic(:,2));
controlnondoging = sum(Statistic(:,3));
totalcontrols = controlnondoging+controldoging;
totaldoging = sum(Statistic(:,1));
totaltours = sum(Statistic(:,4));

format shortg

counts=[controldoging,controlnondoging,totalcontrols; totaldoging, totaltours-totaldoging, totaltours];
percentage=[totalcontrols/totaltours,totaldoging/totaltours,controldoging/totalcontrols];

printmat(counts,'#','controls tours','doging nondoging total');
printmat(percentage,'%','','%controlled %doging %caught(doging_and_controlled)');
