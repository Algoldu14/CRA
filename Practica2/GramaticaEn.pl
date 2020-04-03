%------------------------------- G R A M A T I C A           I N G L E S

sentence(s(S,V,O)) --> nom_p(S,N), verb(V,N), nom_p(O,_).

nom_p(np(M,S),N) --> modifier(M), noun(S,N).
