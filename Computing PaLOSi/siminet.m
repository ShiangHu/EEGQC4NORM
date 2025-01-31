function [sim,distance]=siminet(matrice1, matrice2,substitution,rayon)
%%
% 
% Inputs:  matrice1: Adjacency matrix of the first graph
%          matrice2: Adjacency matrix of the second graph
%          substitution: matrix of distance between all the nodes (normalized between 0 and 1)
%          rayon: radius of the substitution zone
%
%
%
% Outputs:  - sim: similarity score between 0 et 1  
%           - distance: distance between graph1 and graph2  
%           
% Authors: Ahmad Mheich, Mahmoud Hassan, Fabrice Wendling
%
% contacts: LTSI-Université de Rennes 1 
%           mheich.ahmad@gmail.com
%           
%%
s_n=0;
number_nodes=size(matrice1,1);
node1_index=find(sum(matrice1));
node2_index=find(sum(matrice2));
size_node1=size(node1_index,2);
size_node2=size(node2_index,2);
%%
if (size_node2>size_node1)
    node1_index=find(sum(matrice2));
node2_index=find(sum(matrice1));
end
% The commons nodes between graph1 and graph2
node_intersection=intersect(node1_index,node2_index);
size(substitution);

% Distance between nodes
for i=1:number_nodes
    X{i,1}=i;
   X{i,2}=find(substitution(i,:)<=rayon);    
end

% Nodes belongs to graph 1 and do not belong to graph 2
node1_index_different=setdiff(node1_index,node_intersection);
% Nodes belongs to graph 2 and do not belong to graph 1
node2_index_different=setdiff(node2_index,node_intersection);


size_diff_node1=size(node1_index_different,2);
size_diff_node2=size(node2_index_different,2);

if(isempty(node1_index_different)&& isempty(node2_index_different))
    matrice1t=triu(matrice1);
matrice2t=triu(matrice2);
Etotal=or(matrice1t,matrice2t);

DE=sum(sum(abs(matrice1t-matrice2t)));
DE=DE/sum(sum(Etotal));
    distance=DE;
    sim=1/(1+distance);
    Substitution_node={};
    A={};
    return;
end
size_diff_node1;
size_diff_node2;


for i=1:size_diff_node1
    
  Voisin{i,1}=node1_index_different(i);
  
  Voisin{i,2}=intersect([X{node1_index_different(i),2}],node2_index_different);
    
end

L=unique(horzcat(Voisin{:,2})); 
A=substitution(node1_index_different,L); 

A=[L; A];
node1_index_different=[(rayon+1) node1_index_different];
A=[node1_index_different', A];
i=0;


while(min(min(A(2:end,2:end)))<rayon)
i=i+1;
s_n=1;
[l,c,r]=find(A(2:end,2:end)==min(min(A(2:end,2:end))));

Substitution_node(i,1)=A(l(1)+1,1);
Substitution_node(i,2)=A(1,c(1)+1);
Substitution_node(i,3)=min(min(A(2:end,2:end)));
A(l(1)+1,:)=[];
A(:,c(1)+1)=[];

end
%Substitution_node
if(s_n==0)
 distance=(size(A(2:end,1),1)*rayon + size(A(1,2:end),2)*rayon);
 matrice1t=triu(matrice1);
matrice2t=triu(matrice2);
Etotal=or(matrice1t,matrice2t);
DE=sum(sum(abs(matrice1t-matrice2t)));
DE=DE/sum(sum(Etotal));
 sim=1/(1+(distance+DE));
    return;
end
%%
distance=sum(Substitution_node(:,3))+ (size(A(2:end,1),1)*rayon + size(A(1,2:end),2)*rayon);
matrice1t=triu(matrice1);
matrice2t=triu(matrice2);
Etotal=or(matrice1t,matrice2t);
DE=sum(sum(abs(matrice1t-matrice2t)));
DE=DE/sum(sum(Etotal));
distance=distance+DE;
sim=1/(1+distance);

end
