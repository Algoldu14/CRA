% Autor: Álvaro Golbano, Dave y las Lauras <3

bag(['N','N','N','N','N','N','N','N','N','N','A','A','A','A','A','A','A','A','A','A','B','B','B','B','B','B','B','B','B','B','R','R','R','R','R','R','R','R','R','R','V','V','V','V','V','V','V','V','V','V']).

fac1(['_','_','_','_']).
fac2(['_','_','_','_']).
fac3(['_','_','_','_']).
fac4(['_','_','_','_']).
fac5(['_','_','_','_']).
fac6(['_','_','_','_']).
fac7(['_','_','_','_']).
fac8(['_','_','_','_']).
fac9(['_','_','_','_']).

factories(FacOut):- fac1(F1),fac2(F2),fac3(F3),
                    fac4(F4),fac5(F5),fac6(F6),
                    fac7(F7),fac8(F8),fac9(F9), 
                    FacOut= [F1,F2,F3,F4,F5,F6,F7,F8,F9].

init_player(Name, Points, PlayerOut):- board(Board), PlayOut = [Name, Points, Board].

patterns(Patterns):-patt1(Pat1),patt2(Pat2),patt3(Pat3),patt4(Pat4),patt5(Pat5),Patterns = [Pat1,Pat2,Pat3,Pat4,Pat5].
patt1(['_']).
patt2(['_','_']).
patt3(['_','_','_']).
patt4(['_','_','_','_']).
patt5(['_','_','_','_','_']).

the_wall(Wall):-the_wall_lines(Lines),Wall=[Lines].

the_wall_lines([['a','v','r','n','b'],
                ['b','a','v','r','n'],
                ['n','b','a','v','r'],
                ['r','n','b','a','v'],
                ['v','r','n','b','a']]).

the_floor(['_','_','_','_','_','_','_']).

board(Board):-patterns(Patterns),the_wall(Wall),the_floor(Floor),Board=[Patterns,Wall,Floor].

/* ------------------------------------------- *
 * 				P R O G R A M				   *
 * ------------------------------------------- */

% INIT MENU
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
                        create_players(NPlayer, [], ListPlayers),
                        NumFact is NPlayer*2 +1,
    					shuffle(BagS), fill_factories(BagS,BagOut,NumFact,[], FactoryOut),
                        start_playing(ListPlayers, FactoryOut, ListPlayersOut, ListFactoriesOut, []),!.

%--------------------------- SHUFFLE BAG
%output: bag permutated
shuffle(BagS):- bag(Bag), random_permutation(Bag,BagS).

% --------------------------- CREATE PLAYERS
% input: number of players that will be created
% output: a list that contains all the players created
%create_players(0, PlayersOut, PlayersOut).


create_players(0,_,_).
create_players(0, PlayersOut, PlayersOut).
create_players(Nplayer,PlayersAux,PlayersOut):- 
       write('Name of the player: '),nl, read(NamePlayer),
       init_player(NamePlayer,0,JugadorOut),
       append(PlayersAux,[JugadorOut],PlayersAux2),
       NPlayersOut is Nplayer - 1,
       writeln(NPlayersOut),
       create_players(NPlayersOut,PlayersAux2,PlayersOut).
       
% -------------------------FILLING JUST ONE FACTORY
% inputs: BagIn & FactoryIn
% outputs: FactoryIn & FactoryOut
% HOW IT WORKS: It takes a file from the bag and introduce it inside a factor
fill_factory(BagIn,BagOut,FactoryIn,FactoryOut):-%Regla que nos permite llenar las casillas de una factoria con las fichas de la bolsa permitada aleatoriamente
    BagIn=[Ficha|BagAux],
    select('_',FactoryIn,Ficha,FactoryAux),
    fill_factory(BagAux,BagOut,FactoryAux,FactoryOut),!.

% The recursity ends when we have the bags and factories unified
fill_factory(BagOut,BagOut,FactoryOut,FactoryOut).

% --------------------------- FILLING MULTIPLE FACTORIES
%Condition for stopping the recursivity
%The first factoriesOut is an empty list where you saved the factories that have been filled
%The other factoriesOut is where the results will be saved
fill_factories(BagOut,BagOut,0,FactoriesOut,FactoriesOut):-!.
%Inputs: BagIn, NFact (number of factories that will be filled)
% Here, factoriesAux is the factory that have been recently filled
fill_factories(BagIn,BagOut,NFact,FactoriesAux,FactoriesOut):-
    %printMatrixRow(BagIn),
    fac1(Fact),fill_factory(BagIn,BagAux,Fact,FactAux),
     % Factories out is the result of appending the previous resut with the new factory filled
    append(FactoriesAux,[FactAux],FactoriesAux2),
    NFactAux is NFact - 1,
    fill_factories(BagAux,BagOut,NFactAux,FactoriesAux2,FactoriesOut).

%----------------------------- START PLAYING
% input: list with player and fill all the factories
% output: modify the board

%start_playing(ListPlayers, [], ListPlayersOut, [], [], Bag):- %pues ahora a alicatar o no xd

start_playing(ListPlayers, ListFactories, ListPlayersOut, ListFactoriesOut, CenterBoard):-
    % Print active board's player
    %printMatrix(ListFactories),
    getPlayer(ListPlayers),
    % Print center board and factories
    write('Centro de la mesa: '),nl,
    printMatrix(CenterBoard),nl,
    write('Factorias: '),nl,
    printMatrix(ListFactories),nl,
    % Ask color and factory
    write('Select a factory: '), read(NumFactory),
    write('Select a color; '), read(Color),
    % Remove the color inside the factory 
    nth0(NumFactory, ListFactories, Factory),
    getColorPos(Factory, Color, Result, ListAux, CenterBoard, CenterBoardOut),
    % Ask pattern line where chips will be introduced
    write('Pattern Line: '), read(PatternLine),
    % llamada a movePlayer
    
    %llamar a alicatado
    ((
    getFactory(ListFactories,1,facAux1), list_to_set(facAux1, []),
    getFactory(ListFactories,2,facAux2), list_to_set(facAux2, []),
    getFactory(ListFactories,3,facAux3), list_to_set(facAux3, []),
    getFactory(ListFactories,4,facAux4), list_to_set(facAux4, []),
    getFactory(ListFactories,5,facAux5), list_to_set(facAux5, []),
    getFactory(ListFactories,6,facAux6), list_to_set(facAux6, []),
    getFactory(ListFactories,7,facAux7), list_to_set(facAux7, []),
    getFactory(ListFactories,8,facAux8), list_to_set(facAux8, []),
    getFactory(ListFactories,9,facAux9), list_to_set(facAux9, []),
    list_to_set(CenterBoard, [])) ->
    	write('Toca alicatar')
        %(alicatado())
    ),
    shiftPlayers(ListPlayers, ListPlayersShifted),
    start_playing(ListPlayersShifted,ListFactoriesAux,ListPlayersOut,ListPlayersOut,CenterBoardAux).

% Rotar la lista de jugadores
shiftPlayers([Player|OtherPlayers], ShiftedList) :-
  append(OtherPlayers, [Player], ShiftedList).      
  
shiftPlayers([ ['Laura', 0,
                [ [['a','v','r','n','b'],['b','a','v','r','n'],['n','b','a','v','r'],['r','n','b','a','v'],['v','r','n','b','a']], 
                   [['_'], ['_','_'],['_','_','_'],['_','_','_','_'],['_','_','_','_','_']], 
                   ['_','_','_','_','_','_','_'] 
                ]
             ], ['Alvaro', 0,
                [ [['a','v','r','n','b'],['b','a','v','r','n'],['n','b','a','v','r'],['r','n','b','a','v'],['v','r','n','b','a']], 
                   [['_'], ['_','_'],['_','_','_'],['_','_','_','_'],['_','_','_','_','_']], 
                   ['_','_','_','_','_','_','_'] 
                ]
             ]], Resultado).
  
/* Jugador 1 =   ['Laura', '0',
                [ [['a','v','r','n','b'],['b','a','v','r','n'],['n','b','a','v','r'],['r','n','b','a','v'],['v','r','n','b','a']], 
                   [['_'], ['_','_'],['_','_','_'],['_','_','_','_'],['_','_','_','_','_']], 
                   ['_','_','_','_','_','_','_'] 
                ]
             ]
  Jugador 2 =  ['Alvaro', '0',
                [ [['a','v','r','n','b'],['b','a','v','r','n'],['n','b','a','v','r'],['r','n','b','a','v'],['v','r','n','b','a']], 
                   [['_'], ['_','_'],['_','_','_'],['_','_','_','_'],['_','_','_','_','_']], 
                   ['_','_','_','_','_','_','_'] 
                ]
             ]
ListaJugadores = [ ['Laura', '0',
                [ [['a','v','r','n','b'],['b','a','v','r','n'],['n','b','a','v','r'],['r','n','b','a','v'],['v','r','n','b','a']], 
                   [['_'], ['_','_'],['_','_','_'],['_','_','_','_'],['_','_','_','_','_']], 
                   ['_','_','_','_','_','_','_'] 
                ]
             ], ['Alvaro', '0',
                [ [['a','v','r','n','b'],['b','a','v','r','n'],['n','b','a','v','r'],['r','n','b','a','v'],['v','r','n','b','a']], 
                   [['_'], ['_','_'],['_','_','_'],['_','_','_','_'],['_','_','_','_','_']], 
                   ['_','_','_','_','_','_','_'] 
                ]
             ]
             ]
getPlayer([ ['Laura', '0',
                [ [['a','v','r','n','b'],['b','a','v','r','n'],['n','b','a','v','r'],['r','n','b','a','v'],['v','r','n','b','a']], 
                   [['_'], ['_','_'],['_','_','_'],['_','_','_','_'],['_','_','_','_','_']], 
                   ['_','_','_','_','_','_','_'] 
                ]
             ], ['Alvaro', '0',
                [ [['a','v','r','n','b'],['b','a','v','r','n'],['n','b','a','v','r'],['r','n','b','a','v'],['v','r','n','b','a']], 
                   [['_'], ['_','_'],['_','_','_'],['_','_','_','_'],['_','_','_','_','_']], 
                   ['_','_','_','_','_','_','_'] 
                ]
             ]
             ]).
*/
%----------------------------- GET PLAYER
% Input:  List with all the player
% Output: Information about the first player inside the list
getPlayer([Player|_]):- 
    getPlayerBoard(Player,BoardPlayer),
    printPlayerBoard(BoardPlayer).

%----------------------------- GET PLAYER BOARD
% Print player's board
printPlayerBoard([Pattern, Wall, Floor]):- 
    printMatrix(Pattern),
    printMatrix(Wall),
    printMatrix(Floor).
    
%----------------------------- GET PLAYER BOARD
getPlayerBoard([_, _, [Pattern, Wall, Floor]], BoardOut):- 
    append([], [Pattern], BoardAux),
    append(BoardAux , [Wall], BoardAux2),
    append(BoardAux2, [Floor], BoardOut).
    
%Board = [[[a, v, r, n, b], [b, a, v, r, n], [n, b, a, v, r], [r, n, b, a, v], [v, r, n, b, a]], [['_'], ['_', '_'], ['_', '_', '_'], ['_', '_', '_', '_'], ['_', '_', '_', '_', '_']], ['_', '_', '_', '_', '_', '_', '_']]
%----------------------------- GET PATTERN
getPattern([Player | _ ]):- getPatternPlay(Player).

getPatternPlay([_,_,Board], Result) :-
    nth0(1,Board,Result). 

%----------------------------- GET FLOOR
getFloorPlay([_,_,Board], Result) :-
    nth0(2,Board,Result). 

%----------------------------- GET Factory
getFactory(ListFactories, NumFactory, FactoryOut) :-
    nth0(NumFactory,ListFactories,FactoryOut).

%----------------------------- PRINT BOARD
printMatrix([]).
printMatrix([ H | T] ) :- printMatrixRow(H),nl, printMatrix(T).
printMatrix([ H | [] ]) :- printMatrixRow(H).

printMatrixRow([]).
printMatrixRow([ H | T ]) :- write(H), printMatrixRow(T).
printMatrixRow([ H | [] ]) :- write(H).
  
%----------------------------- INDEXES
% INPUTS: List, element to find
% OUTPUT: List with the indexes where the element was found
indexes(List, E, Is) :- findall(N, nth1(N, List, E), Is).

%----------------------------- GET COLOR POS
% inputs: Factory, Color, Result (List with the positions inside the factories where the color is)
% Output: ListAux, list with player's chips

getColorPos(Factory,Color,Result,ListAux,CenterBoard,CenterBoardOut):-
    indexes(Factory, Color, Result),
    % List's size 
    length(Result,Size),
    % Chips' player are saved inside an auxiliar list
    length(ListAux, Size),maplist(=(Color),ListAux),
    % Remove colored chips from the factory 
    pickUpColor(Color,Factory,FactoryOut),
    % Remaining chips are moved towards center board
    append(FactoryOut,CenterBoard,CenterBoardOut).

%----------------------------- PICK UP COLOR
% Remove a color from a factory
pickUpColor(_, [],[]).

pickUpColor(Color, [Color|Factory], FactoryOut):-
    pickUpColor(Color, Factory, FactoryOut).

pickUpColor(Color, [T|Factory], [T|FactoryOut]):-
    dif(Color, T),
    pickUpColor(Color, Factory, FactoryOut).


% Test case
%pickUpColor('R',['R','A','R','R'], Result).

%----------------------------- ENTER
% Introduce chips inside of a pattern line or inside the floor line
enter(_, PatternLineOut, FloorLineOut, PatternLineOut, FloorLineOut). 
enter([],_, _, _,_).

enter([Color|List], PatternLine, FloorLine, PatternLineOut, FloorLineOut):-
   (member('_', PatternLine) , ( (member(Color,PatternLine)) ; list_to_set(PatternLine, [_]) ) -> 
   		select('_',PatternLine,Color,PatternLineAux), enter(List, PatternLineAux, FloorLine, PatternLineOut, FloorLineOut);
   		(member('_',FloorLine) ->  
        		select('_',FloorLine,Color,FloorLineAux), enter(List, PatternLine, FloorLineAux, PatternLineOut, FloorLineOut);
           		 % Si el suelo está lleno, se vacía la lista de las fichas, y esas fichas se pierden
            	 enter(List, PatternLine,FloorLine,PatternLine,FloorLine)
         )
   ).
    
%TEST CASE: 
% enter(['R', 'R'], ['_','_'], ['_','_','_','_','_','_','_'], Pattern, Floor).
% enter(['R', 'R'], ['A','_','_'], ['_','_','_','_','_','_','_'], Pattern, Floor).
%NumLine = 2;
%ListIn = ['R','R']
%PatternList = [['_'],['_','_'],['_','_','_'],['_','_','_','_'],['_','_','_','_','_']]
%Floor = ['_','_','_','_','_','_','_']


%----------------------------- ENTER -> NOT USED,IT'S THERE JUST IN CASE
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
    





%-----------------------------MOVE PLAYER
% Funtion that makes all the move that a player must done in his turn
% INPUTS: List with all the factories, Center Board, Player (all the data related with the player that is playing)
% OUTPUTS: Player (his board will be modified during his turn), List Factories and Center Board
movePlayer(ListFactories, CenterBoard, Player, PlayerOut, ListFactoriesOut, CenterBoardOut):- 
    write('Select a factory: '), read(NumFactory),
    nth1(NumFactory, ListFactories, FactoryOut),
    write('Select a color; '), read(Color),
    write(Color),
    getColorPos(FactoryOut,Color, Result, ListAux, CenterBoard, CenterBoardOut),
    % Ask the patter line where the player wants to introduces the chips
    write('Pattern Line: '), read(NumPatternLine),
    % Get the List with all the player's pattern line
    getPatternPlay(Player,ListPattern),
    % Getting the choosen line from the list of patterns
    nth1(NumPatternLine, ListPattern, PatternLine),
    % Introducing the chips inside the pattern line
    enter(ListAux, PatternLine, FloorLine, PatternLineOut, FloorLineOut),
    % Update player's board
    sustitucionPatron(NumPatternLine, PatternLineOut, ListPattern, ListPatternOut),
    sustitucionElemTablero(getPlayerBoard(Player, Board), ListPatternOut ,2 ,BoardOut),
    sustitucionTablero(Player, BoardOut, PlayerOut),
    % Update ListFactories
    NumAux is NumFactory-1,
    sustitucionElemTablero(ListFactories, FactoryOut, NumAux, ListFactoriesOut).

  
%-------------------------TILING
tiling(4,[],_).
tiling(NumPatternLine, Player, PlayerOut):-
    getPlayerBoardL(Player,Board),
    %tiene que hacerse cosas
    
    nth0(1,Board, PatternLinesAux),
    nth0(NumPatternLine,PatternLinesAux, pat1),
    ((list_to_set(pat1, [_]),(not(member('_',pat1))))->
        metodoAux(Player) %hace: modificar la linea de pared para alicar como toque
    ),
    Num is NumPatternLine + 1,
    tiling(Num, ListPlayer, PlayerAux)
    .
    
/*
TEST CASE: tiling(0, ['Laura', 0, 
                [ [['a','v','r','n','b'],['b','a','v','r','n'],['n','b','a','v','r'],['r','n','b','a','v'],['v','r','n','b','a']], 
                   [['R'], ['A','A'],['V','V','V'],['N','N','N','N'],['B','B','B','B','B']], 
                   ['_','_','_','_','_','_','_']]] , R).
 PLAYER = ['Laura', '0',
                [ [['a','v','r','n','b'],['b','a','v','r','n'],['n','b','a','v','r'],['r','n','b','a','v'],['v','r','n','b','a']], 
                   [['R'], ['A','A'],['V','V','V'],['N','N','N','N'],['B','B','B','B','B']], 
                   ['_','_','_','_','_','_','_'] 
                ]
             ].
% PLAYER = [Name, Point, Board]
% Board = [Wall, Pattern, Floor]
% Pattern = L1, L2,L3,L4, L5
% Numero L -> NewPatternLine
 % Posicion == Numero L
 % concateno todo lo anterior con NewPatternLine y lo siguiente
 % Posion != Numero L
 % Lo que tengo en esa posicion en una lista
    
    % Numero L =2
    % LAux = L1
    % Laux :: NewPatternLine -> LAux
    % Laux:: L3
   
*/
changeBoard(ListPattern, NewPatterLine, NumLine, ListPatternsOut) :-
    write('hola')
    .
    

    

%Test case:
% Lista de factorias = [['R', 'V', 'N', 'N'], ['R','R', 'N','N'], ['A','V', 'V', 'R']]
% PLAYER: ['Laura', '0', [ [['a','v','r','n','b'],['b','a','v','r','n'],['n','b','a','v','r'],['r','n','b','a','v'],['v','r','n','b','a']], [['_'], ['_','_'],['_','_','_'],['_','_','_','_'],['_','_','_','_','_']], ['_','_','_','_','_','_','_'] ],



% Auxiliar Functiom that will be deleted when move player works properly
getChips(ListFactories, CenterBoard, Player, PlayerOut, ListFactoriesOut, CenterBoardOut):- 
   write('Select a factory: '), read(NumFactory),
   nth0(NumFactory, ListFactories, FactoryOut),
   write('Select a color; '), read(Color),
   write(Color),
   getColorPos(FactoryOut,Color, Result, ListAux, CenterBoard, CenterBoardOut).

insertChips(Player, ListAux, FloorLine, PatternLineOut, FloorLineOut):-
 % Ask the patter line where the player wants to introduces the chips
    write('Pattern Line: '), read(NumPatternLine),
    % Get the List with all the player's pattern line
    getPatternPlay(Player,ListPattern),
    % Getting the choosen line from the list of patterns
    nth1(NumPatternLine, ListPattern, PatternLine),
    % Introducing the chips inside the pattern line
    enter(ListAux, PatternLine, FloorLine, PatternLineOut, FloorLineOut).
    
    
%Sutituye el tablero de un jugador por uno nuevo (normalmente proporconada por sustitucionTablero)
%sustitucionPatron(Jugador, NuevoTablero, JugadorOut).
sustitucionTablero(PlayerIn, NewBoard, PlayerOut):-
    nth0(2, PlayerOut, NewBoard, PlayerIn).
    
%Sustituye un elemento del tablero.
sustitucionElemTablero(BoardIn, Element, Index, BoardOut):-
    nth0(Index, BoardOut ,Element, BoardIn).
    
%Cambia una linea de patron del tablero de patrones
sustitucionPatron(NumPatron, NewPattern, ListPattern, PatternChanged):-
    nth0(NumPatron, PatternChanged ,NewPattern, ListPattern).

sustitucionPatron([['_'],
                    ['_','_'],
                    ['_','_','_'],
                    ['_','_','_','_'],
                    ['_','_','_','_','_']],
                    ['R', 'R'], 1, Resultado).

%sustitucionPatronB(1, ['R', 'R'], [['_'], ['_','_'],['_','_','_'],['_','_','_','_'],['_','_','_','_','_']], Resultado).

/* insertChips(
 			 ['Laura',
             '0', 
             [
             	[['a','v','r','n','b'],
                ['b','a','v','r','n'],
                ['n','b','a','v','r'],
                ['r','n','b','a','v'],
                ['v','r','n','b','a']],
               [
               		['_'],
                    ['_','_'],
                    ['_','_','_'],
                    ['_','_','_','_'],
                    ['_','_','_','_','_']
                ],
                ['_','_','_','_','_','_','_']
                ]
              ],
 			 ['R', 'R'],
             ['_','_','_','_','_','_','_'],
             P,
             F).
*/

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