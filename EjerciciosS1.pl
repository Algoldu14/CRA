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