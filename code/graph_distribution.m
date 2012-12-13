function graph_distribution(A,model,insp,pass,name)

%precondition
%A= graph matrix A with amount of trips 

net=createNetz;

%create csv file for edges
r='Source,Target,Type,Id,Label,Weight\r\n';
id=1;
%creats edges with statistics
for m=1:size(A,1)
   for n=m:size(A,1) 
       if (A(m,n)~=0)
            r=strcat(r,num2str(m),'.0,');
            r=strcat(r,num2str(n),'.0,');
            r=strcat(r,'Undirected,');
            r=strcat(r,num2str(id),','); 
			r=strcat(r,num2str(net{m,n}),','); 
            r=strcat(r,num2str(A(m,n)),','); 
			r=strcat(r,num2str(n),'\r\n'); 
			id=id+1;
       end  
   end
end


% write string to file
name=['csv\' model 'p' num2str(pass) 'i' num2str(insp) '_' name '.csv'];
fid = fopen(name,'w');     
fprintf(fid,r);
fclose(fid);
