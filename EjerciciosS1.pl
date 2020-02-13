% Autor: Alvaro Golbano
% Fecha: 30/01/2020

personas([adrian,manuel,alberto,pablo,enrique,yolanda,esther]). % Una lista de personas

padre(adrian,manuel). % Manuel es el padre de Adrian
padre(alberto,pablo).
padre(lucas,pablo).
padre(enrique,pablo).

madre(adrian,yolanda). % Yolanda es la madre de Adrian
madre(julio,yolanda).
madre(alberto,esther).

hermano(Herm1,Herm2):-padre(Herm1,Padre),padre(Herm2,Padre),\+(Herm1=Herm2). % Que los dos hermanos no sean la misma persona y que tengan el mismo padre
hermano(Herm1,Herm2):-madre(Herm1,Madre),madre(Herm2,Madre),\+(Herm1=Herm2). % Que los dos hermanos no sean la misma persona y que tengan la misma madre

imprimir_personas([Persona1|OtrasPersonas]):-writeln(Persona1),imprimir_personas(OtrasPersonas). % Imprime una lista de personas
imprimir_personas([]).

sumar_1(ListaNums,Resultados):-sumar_1_aux(ListaNums,[],Resultados).

sumar_1_aux(ListaNums,ResAux,Resultados):-
            ListaNums = [Num|MasNums],
            NuevoNum is (Num+1),
            append(ResAux,[NuevoNum],ResAux2), % Concatena A ResAux el NuevoNum y devuelve el resutado en ResAux2
            sumar_1_aux(MasNums,ResAux2,Resultados).
            
sumar_1_aux([],Resultados,Resultados).
sumar_1([]).

hermanos(Persona,ListaAux,ListaHermanos):- % Devuelve la lista de hermanos de Persona
         hermano(Persona,Hermano),
         \+ member(Hermano,ListaAux),!, % Para que el hermano no pertenezca a la lista, si ocurre hace backtraking  ,!, corta el backtraking
         append(ListaAux,[Hermano],ListaAux2),
         hermanos(Persona,ListaAux2,ListaHermanos).
         
hermanos(_,ListaHermanos,ListaHermanos). % Esto cierra la recursividad, el _ implica que nos da igual el valor de esa variable


%--------------------------- Sesion 3 --------------------------------------%

pedir_numero(Min,Max,Out):-
     repeat,   %Se repite hasta que se acierte
     write('Introduce un numero entre'),
     write(Min),write(' y '),write(Max),write(':'),
     read(Out),
     (Out >= Min, Out =< Max, !).
     
simbolos([a,b,c,b,a]).

% simbolos(X),select(b,X,Out). % Elimina un elelemto de la lista X
% simbolos(X),select(b,X,x,Out). % Sustituye b por x en la lista X
% simbolos(X),nth0(3,X,Out). % Retorna el tercer elemento de la lista X
% simbolos(X),nth0(3,X,Out,Res). % Retorna el tercer elemento de la lista X y el resto de la lista sin el parametro 3

listas_simbolos([[a,a,b,b],[c,c,d,c],[a,b,c,d]]).

reemplazar_simbolo_sublista(Lista,Nsubllista,ValorOri,ValorNue,ListaOut):-
           nth1(Nsublista,Lista,Sublista,Res),
           select(ValorOri, Sublista, ValorNue, SubListaOut),
           nth1(Nsublista, ListaOut, SubListaOut, Res).