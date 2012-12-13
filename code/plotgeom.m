function plotgeom()

figure;
n=20;
x=linspace(1,n,n);
k=1;
for i=0:0.1:0.99
    subplot(2,6,k);
    y=geoProb(i,n);
    plot(x,y);
    axis([1 n 0 1]);
    k=k+1;
end