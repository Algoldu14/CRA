% Autor: Álvaro Golbano, Dave y las Lauras <3

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
    

    
start_playing(ListPlayers, [],ListPlayersOut, [],[], Bag). %Y despues a alicatar
start_playing(ListPlayers, ListFactories, ListPlayersOut , ListFactoriesOut, CenterBoard, Bag):-
        %imprimir centro y fatorias
        %imprimir tablero del jugador activo
        %pedir color y factoria
        %quitar los azulejos del color apropiado de la factoria, tirando todo lo demás al centro
        %preguntar la linea de patron donde meter los azulejos  
        %Modificar el tablero del jugador activo 
        %repetir lo anterior con el siguiente jugador 

% Print elements
printMatrix([]).
printMatrix([ H | T] ) :- printMatrixRow(H), printMatrix(T).
printMatrix([ H | [] ]) :- printMatrixRow(H).

printMatrixRow([]).
printMatrixRow([ H | T ]) :- write(H), printMatrixRow(T).
printMatrixRow([ H | [] ]) :- write(H).
  
indices(List, E, Is) :- findall(N, nth1(N, List, E), Is).

    

% Tras elegir un color, se quita de las factorias, el jugador se lo guarda y se mueve las fichas al centro
% inputs: Factory, Color, Result Lista con las posiciones dentro de la factoria donde esta el color (viene de indices)
% Output: ListAux, que es la lista que tiene el jugador con las fichas

getColorPos(Factory,Color,Result,ListAux,CenterBoard,CenterBoardOut):-
    % Lista con las posiciones en las que se encuentra el color
    indices(Factory, Color, Result),
    % Tamaño de la lista con las posiciones del color
    length(Result,Size),
    %Añadimos las fichas del color en una lista auxiliar que son las fichas que tiene el jugador
    length(ListAux, Size),maplist(=(Color),ListAux),
    % Quitamos de la factoria las fichas del color
    pickUpColor(Color,Factory,FactoryOut),
    %Añadimos las fichas restantes de la factoria al centro de la mesa
    append(FactoryOut,CenterBoard,CenterBoardOut).


% Quitar un color de la factoria    
pickUpColor(_, [],[]).
pickUpColor(Color, [Color|Factory], FactoryOut):-
    pickUpColor(Color, Factory, FactoryOut).
pickUpColor(Color, [T|Factory], [T|FactoryOut]):-
    dif(Color, T),
    pickUpColor(Color, Factory, FactoryOut).


% Test case
%pickUpColor('R',['R','A','R','R'], Result).


% INTRODUCE LAS FICHAS EN UNA LINEA DE PATRON, SI CABEN, SINO SE CAEN AL SUELO
% Y SI EL SUELO ESTÁ LLENO, LAS FICHAS DESAPARECEN
enter(_, PatternLineOut, FloorLineOut, PatternLineOut, FloorLineOut).    
enter([],_, _, _,_).
enter([Color|List], PatternLine, FloorLine, PatternLineOut, FloorLineOut):-
    %Miramos si podemos introducir las fichas en la linea de patron
    (member('_',PatternLine) ->
        select('_', PatternLine, Color, PatternLineAux), enter(List, PatternLineAux, FloorLine, PatternLineOut, FloorLineOut);
        %Si no podemos, entonces introduciriamos las fichas en la linea de suelo
        (member('_',FloorLine) ->
            select('_',FloorLine,Color,FloorLineAux), enter(List, PatternLine, FloorLineAux, PatternLineOut, FloorLineOut);
        	enter(List, PatternLine,FloorLine,PatternLine,FloorLine) 
    )).
   
%NumLine = 2;
%ListIn = ['R','R']
%PatternList = [['_'],['_','_'],['_','_','_'],['_','_','_','_'],['_','_','_','_','_']]
%Floor = ['_','_','_','_','_','_','_']
%INTRODUCE LAS FICHAS EN LA LINEA DE PATRON SIN TENER EN CUENTA LAS FICHAS QUE SE CAERÍAN AL SUELO.
enterL([],_,_).
enterL(_,PatterLineOut,PatterLineOut).
enterL([Color|List], PatterLine,PatterLineOut):-
    (member('_', PatterLine) ->
        select('_',PatterLine,[Color],PatterLineAux), 	enterL([List],PatterLineAux,PatterLineOut);
     enterL([List], PatternLine,PatternLineOut)
    ).

prueba([Color|List], PatternLine,PatterLineOut):-
    member('_', PatternLine) -> select('_',PatternLine,[Color],PatterLineOut) ; writeln("**").
    



/*

    sort(list, [_]). -> sabemos si es vacía o no
                        si está vacia, pasamos a meter las fichas
                        
                        si no está vacia, hacemos el member
    member(R, List) -> si o no
    El member el problema que tiene es que no diferencia entre '_' '_' '_' '_' y '_' '_' '_' 'R'
    
    
    
   ( condition -> then_clause ; else_clause )
   
   (
     sort(list, ['_']) -> meterlo;
    (
     member(nth0(1,ListIn,Color),PatternLine) -> meterlo ; writeln("No puedes meter las fichas de ese color en este patrón")
		)
)

 Meterlo -> coger el primer elemento ListIn y sustituir la primera '_' del PatternLine, borras la primera posicion de ListIn y repites hasta recorrer toda la PatterLine

*/

movePlayer(ListFactories, CenterBoard, Player, PlayerOut, ListFactoriesOut, CenterBoardOut):- 
    write('Select a factory: '), read(NumFactory),
    nth0(NumFactory, ListFactories, FactoryOut),
    %write('Select a color; '), read(Color),
    %write(Color),
    getColorPos(FactoryOut, 'V' , Result, ListAux, CenterBoard, CenterBoardOut),
    write('Pattern Line: '), read(NumPatternLine),
    getPatternPlay(Player,ListPattern),
    nth0(NumPatternLine, ListPattern, PatternLine),
    enter(ListAux, PatternLine, FloorLine, PatternLineOut, FloorLineOut).

%Test case:
% Lista de factorias = [['R', 'V', 'N', 'N'], ['R','R', 'N','N'], ['A','V', 'V', 'R']]
% PLAYER: ['Laura', '0', [ [['a','v','r','n','b'],['b','a','v','r','n'],['n','b','a','v','r'],['r','n','b','a','v'],['v','r','n','b','a']], [['_'], ['_','_'],['_','_','_'],['_','_','_','_'],['_','_','_','_','_']], ['_','_','_','_','_','_','_'] ],

movePlayerA(ListFactories, CenterBoard, Player, PlayerOut, ListFactoriesOut, CenterBoardOut):- 
   write('Select a factory: '), read(NumFactory),
   nth0(NumFactory, ListFactories, FactoryOut),
   write('Select a color; '), read(Color),
   write(Color),
   getColorPos(FactoryOut,Color, Result, ListAux, CenterBoard, CenterBoardOut).

% getColorPos( ['A','V', 'V', 'R'], 'V', Result, ListAux, [], CenterBoardOut).
/*
 * 

movePlayerA([['R', 'V', 'N', 'N'], ['R','R', 'N','N'], ['A','V', 'V', 'R']],
             [], 
             ['Laura', '0',
                [ [['a','v','r','n','b'],['b','a','v','r','n'],['n','b','a','v','r'],['r','n','b','a','v'],['v','r','n','b','a']], 
                   [['_'], ['_','_'],['_','_','_'],['_','_','_','_'],['_','_','_','_','_']], 
                   ['_','_','_','_','_','_','_'] 
                ]
             ],
             PlayerOut, ListFactoriesOut, CenterBoardOut).
 */
