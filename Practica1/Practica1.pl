% Autor: �lvaro Golbano y Laura Ramos

random_bag(BagS):-bag(Bag),random_permutation(Bag,BagS).

:-consult('./data.pl').

play:-
    write('Hello my friend, let`s play a game.'), nl,
    write('********* Welcome to Azul game ********'), nl,
    write(' '), nl,
    write('Enter "exit" to exit the game.'), nl,
    write('If you do not want to exit the game, please enter "start"'), nl,
    read(X),
    check_start(X),
    X == exit,
    % Prevents backtracking so that it won't backtrack beyond the cut
    !, nl, nl,
    write('Come back any time you like!'), nl.


check_start(exit):-!.
check_start(start):-    write('Number of player: '), nl,
                        read(NPlayer),
                        %initFactory(NPlayer,_),
                        %start(),
                        !.
%-----------------------------------Ini Game-------------------------------------------------%
create_players(Nplayer,PlayersAux,PlayersOut):- % Genera los jugadores necesarios para la partida
       write('Name of the player: '),nl, read(NamePlayer),
       ini_player(NamePlayer,0,JugadorOut),
       append(PlayersAux,[JugadorOut],PlayersAux2),
       NPlayersOut is Nplayer - 1,
       create_players(NPlayersOut,PlayersAux2,PlayersOut).
create_players(0,PlayersOut,PlayersOut).
       
fill_factory(BagIn,BagOut,FactoryIn,FactoryOut):-%Regla que nos permite llenar las casillas de una factoria con las fichas de la bolsa permitada aleatoriamente
    BagIn=[Ficha|BagAux],
    select('_',FactoryIn,Ficha,FactoryAux),
    fill_factory(BagAux,BagOut,FactoryAux,FactoryOut),!.
fill_factory(BagOut,BagOut,FactoryOut,FactoryOut).


fill_factories(BagOut,BagOut,0,FactoriesOut,FactoriesOut).%hace lo que la anterior pero con N factorias
%              BagS, bagOut,Numero,[]         ,factoriesOut
fill_factories(BagIn,BagOut,NFact,FactoriesAux,FactoriesOut):-
    f1(Fact),fill_factory(BagIn,BagAux,Fact,FactAux),
    append(FactoriesAux,[FactAux],FactoriesAux2),
    NFactAux is NFact - 1,
    fill_factories(BagAux,BagOut,NFactAux,FactoriesAux2,FactoriesOut).

%----------------------------------Start Game-------------------------------------------------%
    
% Print elements
printMatrix([]).
printMatrix([ H | T] ) :- printMatrixRow(H), printMatrix(T).
printMatrix([ H | [] ]) :- printMatrixRow(H).

printMatrixRow([]).
printMatrixRow([ H | T ]) :- write(H), printMatrixRow(T).
printMatrixRow([ H | [] ]) :- write(H).
    
start_playing(ListPlayers, [],ListPlayersOut, [],[], Bag). %Y despues a alicatar
start_playing(ListPlayers, ListFactories, ListPlayersOut , ListFactoriesOut, CenterBoard, Bag):-
	%imprimir centro y fatorias
	%imprimir tablero del jugador activo
	%pedir color y factoria
	%quitar los azulejos del color apropiado de la factoria, tirando todo lo demás al centro
	%preguntar la linea de patron donde meter los azulejos	
	%Modificar el tablero del jugador activo 
	%repetir lo anterior con el siguiente jugador 








