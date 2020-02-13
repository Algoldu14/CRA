% Autor: Alvaro Golbano Duran
% Fecha: 13/02/2020

soldado(['John',15,1]).
soldado(['Peter',15,2]).
soldado(['Ryan',15,3]).

atacar(ListaSoldados,ListaOut,Ata,Def):-
       soldado(Ata),nth0(2,X,OutA),
       soldado(Def),nth0(1,X,OutD),
       X is OutD - OutA,
       reemplazar(ListaSoldados,Def,X,ListaOut).


reemplazar(Lista,Nsublista,ValorNue,ListaOut):-
           nth0(Nsublista,Lista,Sublista,Res),
           nth0(1,Sublista,_,ResSublista),
           nth0(1,SubListaOut,ValorNue,ResSublista),
           nth0(Nsublista, ListaOut, SubListaOut, Res).