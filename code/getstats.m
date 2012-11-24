function [counts,percentage] = getstats(Statistic)


controldoging = sum(Statistic(:,2));
controlnondoging = sum(Statistic(:,3));
totalcontrols = controlnondoging+controldoging;
totaldoging = sum(Statistic(:,1));
totaltours = sum(Statistic(:,4));

format shortg

percentage=[totalcontrols/totaltours,totaldoging/totaltours,controldoging/totalcontrols];
counts=[controldoging,controlnondoging,totalcontrols, totaldoging, totaltours-totaldoging, totaltours];