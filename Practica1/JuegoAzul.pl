% Autor: Álvaro Golbano, Dave y las Lauras <3

/* -------------------------------------------  *
 * 			 		D A T A						*
 * -------------------------------------------  */

random_bag(BagS):-bag(Bag),random_permutation(Bag,BagS).

bag(['N','N','N','N','N','N','N','N','N','N','A','A','A','A','A','A','A','A','A','A','B','B','B','B','B','B','B','B','B','B','R','R','R','R','R','R','R','R','R','R','V','V','V','V','V','V','V','V','V','V']).

fac1(['_','_','_','_']).
fac2(['_','_','_','_']).
fac3(['_','_','_','_']).
fac4(['_','_','_','_']).
fac5(['_','_','_','_']).
fac7(['_','_','_','_']).
fac8(['_','_','_','_']).
fac9(['_','_','_','_']).

factories([f1,f2,f3,f4,f5,f6,f7,f8,f9]).

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
                        %initFactory(NPlayer,_),
                        %start(),
  
    !.

% --------------------------- CREATE PLAYERS
% input: number of players that will be created
% output: a list that contains all the players created
%create_players(0, PlayersOut, PlayersOut).

create_players(0,_,_).

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
fill_factories(BagOut,BagOut,0,FactoriesOut,FactoriesOut).

%Inputs: BagIn, NFact (number of factories that will be filled)
% Here, factoriesAux is the factory that have been recently filled
fill_factories(BagIn,BagOut,NFact,FactoriesAux,FactoriesOut):-
    f1(Fact),fill_factory(BagIn,BagAux,Fact,FactAux),
     % Factories out is the result of appending the previous resut with the new factory filled
    append(FactoriesAux,[FactAux],FactoriesAux2),
    NFactAux is NFact - 1,
    fill_factories(BagAux,BagOut,NFactAux,FactoriesAux2,FactoriesOut).

%----------------------------- START PLAYING
% input: list with player and fill all the factories
% output: modify the board

%start_playing(ListPlayers, [], ListPlayersOut, [], [], Bag):- %pues ahora a alicatar

start_playing(ListPlayers, ListFactories, ListPlayersOut, ListFactoriesOut, CenterBoard, Bag):-
    % Print active board's player
    getPlayer(ListPlayers),
    % Print center board and factories
    printMatrix(CenterBoard),
    printMatrix(ListFactories),
    % Ask color and factory
    write('Select a factory: '), read(NumFactory),
    write('Select a color; '), read(Color),
    % Remove the color inside the factory 
    Factory is nth0(NumFactory, ListFactories, FactoryOut),
    getColorPos(Factory, Color, Result, ListAux, CenterBoard, CenterBoardOut),
    % Ask pattern line where chips will be introduced
    write('Pattern Line: '), read(PatternLine).
    % modificar el tablero
  
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
getPlayer([ H | _ ]):- getPlayerBoard(H).

%----------------------------- GET PLAYER BOARD
% Print player's board
getPlayerBoard([_, _, [Pattern, Wall, Floor]]):- 
    printMatrix(Pattern),
    printMatrix(Wall),
    printMatrix(Floor).



%----------------------------- PRINT BOARD
printMatrix([]).
printMatrix([ H | T] ) :- printMatrixRow(H), printMatrix(T).
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
    % Look up if there's enougth space inside the pattern line
    (member('_',PatternLine) ->
    	% Replace the free space with the chip
        select('_', PatternLine, Color, PatternLineAux), enter(List, PatternLineAux, FloorLine, PatternLineOut, FloorLineOut);
        % If there isn't enougth space inside the patter line, chip must go to the floor line
        (member('_',FloorLine) ->
            select('_',FloorLine,Color,FloorLineAux), enter(List, PatternLine, FloorLineAux, PatternLineOut, FloorLineOut);
        	enter(List, PatternLine,FloorLine,PatternLine,FloorLine) 
    )).
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

%-----------------------------MOVE PLAYER
% Funtion that makes all the move that a player must done in his turn
% INPUTS: List with all the factories, Center Board, Player (all the data related with the player that is playing)
% OUTPUTS: Player (his board will be modified during his turn), List Factories and Center Board
movePlayer(ListFactories, CenterBoard, Player, PlayerOut, ListFactoriesOut, CenterBoardOut):- 
    % Ask factory and color
    write('Select a factory: '), read(NumFactory),
    write('Select a color; '), read(Color),
    % Select tha factory from the list of factories
    nth0(NumFactory, ListFactories, FactoryOut),
    % Getting the chips from the factory and moving the remaining to the center board
    getColorPos(FactoryOut, Color , Result, ListAux, CenterBoard, CenterBoardOut),
    % Ask the patter line where the player wants to introduces the chips
    write('Pattern Line: '), read(NumPatternLine),
    % Get the List with all the player's pattern line
    getPatternPlay(Player,ListPattern),
    % Getting the choosen line from the list of patterns
    nth0(NumPatternLine, ListPattern, PatternLine),
    % Introducing the chips inside the pattern line
    enter(ListAux, PatternLine, FloorLine, PatternLineOut, FloorLineOut).

%Test case:
% Lista de factorias = [['R', 'V', 'N', 'N'], ['R','R', 'N','N'], ['A','V', 'V', 'R']]
% PLAYER: ['Laura', '0', [ [['a','v','r','n','b'],['b','a','v','r','n'],['n','b','a','v','r'],['r','n','b','a','v'],['v','r','n','b','a']], [['_'], ['_','_'],['_','_','_'],['_','_','_','_'],['_','_','_','_','_']], ['_','_','_','_','_','_','_'] ],


% Auxiliar Functiom that will be deleted when move player works properly
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
