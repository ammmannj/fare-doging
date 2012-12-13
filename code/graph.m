function graph(A,model,insp,pass)

net=createNetz;
%create header
r='graph\r\n[\r\n';

stations=cell({'Werdhölzli','Altstetten Nord','Farbhof','Albisrieden','Triemli','Albisriederplatz','Escher-Wyss-Platz','Stauffacher','Laubegg','Wollishofen','Enge','Bellevue','Paradeplatz','Bahnhofquai','Bahnhofplatz','Bahnhofstrasse','Central','Haldenegg','ETH/Unispital','Kantonsschule','Platte','Kirche Fluntern','Zoo','Römerhof','Kreuzplatz','Klusplatz','Hegibachplatz','Tiefenbrunnen','Rehalp','Kunsthaus','Schaffhauserplatz','Milchbuck','Bucheggplatz','Schwamendingerplatz','Stettbach','Hirzenbach','Sternen Oerlikon','Oerlikon Ost','Auzelg','Seebach','Flughafen','Bürkliplatz'});

%creats nodes
for l=1:size(net,1)
    p=num2str(l);
    r=strcat(r,'node\r\n');
    r=strcat(r,'[\r\n');
    r=strcat(r,{'id '}, p,'\r\n');
    r=strcat(r,{'label "'},stations(l),'"\r\n');
    r=strcat(r,']\r\n');
end

%create csv file for edges

r='Source,Target,Type,Id,Label,Weight\r\n';
id=0;
%creats edges with statistics
for m=1:size(A,1)
   for n=m:size(A,1) 
       if (size(A{m,n})==[1 4])
            r=strcat(r,num2str(m),'.0,');
            r=strcat(r,num2str(n),'.0,');
            r=strcat(r,'Undirected,');
            r=strcat(r,num2str(id),','); 
			r=strcat(r,num2str(A{m,n}),','); 
			r=strcat(r,'1.0\r\n'); 
			id=id+1;
       end  
   end
end

% write string to file
name=['csv\' model 'p' num2str(pass) 'i' num2str(insp) '.csv'];
fid = fopen(name,'w');     
fprintf(fid,r);
fclose(fid);