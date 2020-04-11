% Autor:
% Fecha: 17/03/2020

% Autor: Álvaro Golbano, Dave y las Lauras <3

/* ------------------------------------------- *
 *                              D A T A                                        *
 * ------------------------------------------- */
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

init_player(Name, Points, PlayerOut):- board(Board), PlayerOut = [Name, Points, Board].

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
 *                              P R O G R A M                              *
 * ------------------------------------------- */

%--------------------------- SHUFFLE BAG
%output: bag permutated
shuffle(BagS):- bag(Bag), random_permutation(Bag,BagS).

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
                                        shuffle(BagS), fill_factories(BagS,_,NumFact,[], FactoryOut),
                        start_playing(ListPlayers, FactoryOut, [],ListPlayersOut, ListFactoriesOut, CenterBoardOut),!.



%----------------------------- START PLAYING
% input: list with player and fill all the factories
% output: modify the board

%start_playing(ListPlayers, [], ListPlayersOut, [], [], Bag):- %pues ahora a alicatar o no xd

start_playing(ListPlayers, ListFactories, CenterBoard, ListPlayersOut, ListFactoriesOut, CenterBoardOut):-
    % Print active board's player
    %printMatrix(ListFactories),
    returnPlayer(ListPlayers, Player),
    %writeln("-------------------"),
    % Print center board and factories
    writeln('Centro de la mesa: '),
    printMatrix(CenterBoard),nl,
    writeln('Factorias: '),nl,
    printMatrix(ListFactories),

    %llamada a movePlayer
    write('Select a factory: '), read(NumFactory),
    nth1(NumFactory, ListFactories, FactoryAux),
    write('Select a color; '), read(Color),
    %write(Color),
    getColorPos(FactoryAux,Color, ListAux, CenterBoard, CenterBoardOut,FactoryOut),
   % change(CenterBoard, CenterBoardAux, CenterBoard, CenterBoardOut),
    % Ask the patter line where the player wants to introduces the chips
    write('Pattern Line: '), read(NumPatternLine),
    % Get the List with all the player's pattern line
    getPatternPlay(Player,ListPattern),
    writeln('Patterns before move'),
    %printMatrix(ListPattern),
    % Getting the choosen line from the list of patterns
    nth1(NumPatternLine, ListPattern, PatternLine),
    getFloorPlay(Player, FloorLine),
    % Introducing the chips inside the pattern line
    enter(ListAux, PatternLine, FloorLine, PatternLineOut, FloorLineOut),
    %writeln('Player board before moving'),
    %printMatrix(PatternLineOut),
    %printMatrix(FloorLineOut),
    % Update player's board
    /*sustitucionPatron(NumPatternLine, PatternLineOut, ListPattern, ListPatternOut),
    getPlayerBoard(Player, Board),
    sustitucionElemTablero(Board, ListPatternOut ,2 ,BoardOut),
    sustitucionTablero(Player, BoardOut, PlayerOut),*/
    %
    getPatternPlay(Player, ListPatternX),
    change(PatternLine, PatternLineOut, ListPatternX, ListPatternY),
    getPlayerBoard(Player, Board),
    change(ListPatternX, ListPatternY, Board, BoardAux),
    change(Board, BoardAux, Player, PlayerAux),
    getPlayerBoard(PlayerAux,BoardAux2),
    change(FloorLine, FloorLineOut, BoardAux2, BoardAux3),
    change(BoardAux2,BoardAux3,PlayerAux,PlayerOut),
    % Update ListFactories
    %sustitucionElemTablero(ListFactories, FactoryOut, NumAux, ListFactoriesOut).
        nth1(NumFactory, ListFactories,FactoryOriginal),
        change(FactoryOriginal, FactoryOut, ListFactories,ListFactoriesOut),

  /*  %llamar a alicatado WIP
   (    endTurnPlayer(ListFactoriesOut, CenterBoardOut,PlayerOut,_),
    shiftPlayers(ListPlayers, ListPlayersShifted),
    start_playing(ListPlayersShifted,ListFactoriesOut, CenterBoardOut, ListPlayersOut,ListFactoriesOut,CenterBoardOut),!
   );*/

    shiftPlayers(ListPlayers, ListPlayersShifted),
    start_playing(ListPlayersShifted,ListFactoriesOut, CenterBoardOut, ListPlayersOut,ListFactoriesOut,CenterBoardOut),!.


placeToTiled([],6, ListTilledOut, ListColorOut,ListTilledOut,ListColorOut).

placeToTiled([Pattern|ListPattern], NumPattern, ListColor,ListTilled, ListTilledOut,ListColorOut):-
    member('_',Pattern),
    Number is NumPattern + 1,
    placeToTiled(ListPattern, Number, ListTilled, ListColor, ListTilledOut, ListColorOut),!.

placeToTiled([Pattern|ListPattern], NumPattern, ListColor, ListTilled, ListTilledOut, ListColorOut):-
     append([NumPattern], ListTilled, ListTilledAux),
     nth0(0,Pattern,ColorAux),
     append([ColorAux], ListColor, ListColorAux),
     Number is NumPattern + 1,
     placeToTiled(ListPattern, Number, ListColorAux, ListTilledAux, ListTilledOut, ListColorOut).


enterWall([],WallOut,[],WallOut).
enterWall([Index|Rest],Wall, [Color|Colores], WallOut):-
    %Ponerte el color en MAYUSCULA en minuscula
    string_lower(Color, ColorLow),
    atom_string(ColorString, ColorLow),
    % De la lista de indices donde alicatamos
    % Coger el indice de la linea que vayamos a alicatar
    nth1(Index, Wall, WallLine),
    % Cambiar la ficha de la pared
    select(ColorString,WallLine,Color,WallAux),
    change(WallLine, WallAux, Wall, WallResult),
    enterWall(Rest, WallResult,Colores, WallOut).

/*enterWall([1,2],
          [['a','v','r','n','b'], ['b','a','v','r','n'], ['n','b','a','v','r'], ['r','n','b','a','v'], ['v','r','n','b','a']],
['R','V'], WallOut). */

%----------------------------- PRINTS
printMatrix([]).
printMatrix([ H | T] ) :- printMatrixRow(H),nl, printMatrix(T).
printMatrix([ H | [] ]) :- printMatrixRow(H).

printMatrixRow([]).
printMatrixRow([ H | T ]) :- write(H), printMatrixRow(T),!.
printMatrixRow([ H | [] ]) :- write(H).

/* ------------------------------------------- *
 *              P L A Y E R  R E L A T E D                         *
 * ------------------------------------------- */

% --------------------------- CREATE PLAYERS
% input: number of players that will be created
% output: a list that contains all the players created
%create_players(0, PlayersOut, PlayersOut).
%create_players(0,_,_).
create_players(0, PlayersOut, PlayersOut).
create_players(Nplayer,PlayersAux,PlayersOut):-
       write('Name of the player: '),nl, read(NamePlayer),
       init_player([NamePlayer],[0],JugadorOut),
       addPlayer(JugadorOut,PlayersAux,PlayersAux2),
       NPlayersOut is Nplayer - 1,
       writeln(NPlayersOut),
       create_players(NPlayersOut,PlayersAux2,PlayersOut),!.

addPlayer(Player, [], [Player]).
addPlayer(Player, [HPlayer | TPlayer], [HPlayer | RestPlayer]) :- addPlayer(Player, TPlayer, RestPlayer).

%----------------------------- GET PLAYER
% Input:  List with all the player
% Output: Information about the first player inside the list
getPlayer([Player|_]):-
    getPlayerBoard(Player,BoardPlayer),
    printPlayerBoard(BoardPlayer).

returnPlayer([Player|_], Player).

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

% Rotar la lista de jugadores
shiftPlayers([Player|OtherPlayers], ShiftedList) :-
  append(OtherPlayers, [Player], ShiftedList).

%-----------------------------MOVE PLAYER
% Funtion that makes all the move that a player must done in his turn
% INPUTS: List with all the factories, Center Board, Player (all the data related with the player that is playing)
% OUTPUTS: Player (his board will be modified during his turn), List Factories and Center Board
movePlayer(ListFactories, CenterBoard, Player, PlayerOut, ListFactoriesOut, CenterBoardOut):-
    write('Select a factory: '), read(NumFactory),
    nth1(NumFactory, ListFactories, FactoryAux),
    write('Select a color; '), read(Color),
    %write(Color),
    getColorPos(FactoryAux,Color, ListAux, CenterBoard, CenterBoardAux, FactoryOut),
    change(CenterBoard, CenterBoardAux, CenterBoard, CenterBoardOut),
    % Ask the patter line where the player wants to introduces the chips
    write('Pattern Line: '), read(NumPatternLine),
    % Get the List with all the player's pattern line
    getPatternPlay(Player,ListPattern),
    writeln('Patterns before move'),
    %printMatrix(ListPattern),
    % Getting the choosen line from the list of patterns
    nth1(NumPatternLine, ListPattern, PatternLine),
    getFloorPlay(Player, FloorLine),
    % Introducing the chips inside the pattern line
    enter(ListAux, PatternLine, FloorLine, PatternLineOut, FloorLineOut),
    %writeln('Player board before moving'),
    %printMatrix(PatternLineOut),
    %printMatrix(FloorLineOut),
    % Update player's board
    /*sustitucionPatron(NumPatternLine, PatternLineOut, ListPattern, ListPatternOut),
    getPlayerBoard(Player, Board),
    sustitucionElemTablero(Board, ListPatternOut ,2 ,BoardOut),
    sustitucionTablero(Player, BoardOut, PlayerOut),*/
    %
    getPatternPlay(Player, ListPatternX),
    change(PatternLine, PatternLineOut, ListPatternX, ListPatternY),
    getPlayerBoard(Player, Board),
    change(ListPatternX, ListPatternY, Board, BoardAux),
    change(Board, BoardAux, Player, PlayerAux),
    getPlayerBoard(PlayerAux,BoardAux2),
    change(FloorLine, FloorLineOut, BoardAux2, BoardAux3),
    change(BoardAux2,BoardAux3,PlayerAux,PlayerOut),
    % Update ListFactories
    %sustitucionElemTablero(ListFactories, FactoryOut, NumAux, ListFactoriesOut).
        nth1(NumFactory, ListFactories,FactoryOriginal),
        change(FactoryOriginal, FactoryOut, ListFactories,ListFactoriesOut).

/* ------------------------------------------- *
 *              E N D  P L A Y E R  R E L A T E D          *
 * ------------------------------------------- */

%----------------------------------------------------------------------------------------------------------------------------------------%


/* ------------------------------------------- *
 *              F A C T O R Y  R E L A T E D               *
 * ------------------------------------------- */


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

%----------------------------- GET Factory
getFactory(ListFactories, NumFactory, FactoryOut):-
    nth1(NumFactory,ListFactories,FactoryOut).

%----------------------------- INDEXES
% INPUTS: List, element to find
% OUTPUT: List with the indexes where the element was found
indexes(List, E, Is) :- findall(N, nth1(N, List, E), Is).

turnFactories(ListFactories, CenterBoard, Player, PlayerOut, ListFactoriesOut, CenterBoardOut):-
    movePlayer(ListFactories, CenterBoard, Player, PlayerOut, ListFactoriesOut, CenterBoardOut),
    endTurnPlayer(...).

%endTurnPlayer(_,_,PlayerOut,PlayerOut).
endTurnPlayer(ListFactories, CenterBoard,Player,PlayerOut):-
    checkedTiled(CenterBoard,ListFactories),
    getPlayerBoard(Player,Board),
    getPattern(Player, PatternLines),
    placeToTiled(PatternLines,1,[],[],PatternToTiled,ColorList),
    getWall(Player,Wall),
    enterWall(PatternToTiled,Wall,ColorList,WallOut),
    % PatternToTiled=[1,2]
    % PatternLines = [['R'], ['V', 'V'], ['_', '_', '_'], ['_', '_', '_', '_'], ['_', '_', '_', '_', '_']]
    deletePatternLine(PatternLines,PatternToTiled,ColorList, PatternLinesOut),
    change(PatternLines,PatternLinesOut,Board,BoardAux),
    change(Wall,WallOut,BoardAux,BoardOut),
    change(Board, BoardOut, Player, PlayerOut),!.

deletePatternLine(PatternLinesOut, [],[],PatternLinesOut).
% input: list with all the patternLines, PatternLines tiled, list with color
% output: result
deletePatternLine(PatternLines,[Pattern|ListPatternToDelete],[Color|ListColor], PatternLinesOut):-
    nth1(Pattern,PatternLines,PatternToDelete),
    length(PatternToDelete,Size),
    clearLine(Size, Color, PatternToDelete, NewPatternListAux),
    change(PatternToDelete, NewPatternListAux, PatternLines, PatternLinesAux),
    deletePatternLine(PatternLinesAux, ListPatternToDelete, ListColor,PatternLinesOut),!.

%deletePatternLine([['R'], ['V','V'],['A','_','_'],['_','_','_','_'],['_','_','_','_','_']],[1,2],['R','V'], Out).
/*endTurnPlayer([['_','_','_','_']],[],[['Laura'], [0],
                [ [['a','v','r','n','b'],['b','a','v','r','n'],['n','b','a','v','r'],['r','n','b','a','v'],['v','r','n','b','a']],
                   [['R'], ['V','V'],['_','_','_'],['_','_','_','_'],['_','_','_','_','_']],
                   ['_','_','_','_','_','_','_']
                ]
             ], PlayerOut).*/
%endTurnPlayer(...):-shiftPlayer(...),emptyFactories(ListFactories).

clearLine(0,_, PatterLineOut, PatterLineOut).
clearLine(Num, Color, PatternLine, PatternLineOut):-
    select(Color, PatternLine, '_', PatternLineAux),
    Number is Num - 1,
    clearLine(Number, Color, PatternLineAux, PatternLineOut),!.


% TO DO: TRANSLATE THIS THING
%my_remove_element(Color, ListaPatron, Out).
my_remove_element(_, [], []).

my_remove_element(Y, [Y|Xs], Zs):-
          my_remove_element(Y, Xs, Zs), !.

my_remove_element(X, [Y|Xs], [Y|Zs]):-
          my_remove_element(X, Xs, Zs).


emptyFactories([Fact|ListFact]):-Fact=['_','_','_','_'],emptyFactories(ListFact).
emptyFactories([]).
%------------------------------------------------------------------------------------------------------------------------------------------%

/* --------------------------------------------------------------*
 *      P A T T E R N , C H I P S  & W A L L    R E L A T E D            *
 * --------------------------------------------------------------*/

%----------------------------- GET PATTERN
getPattern(Player,PatternLine):- getPatternPlay(Player,PatternLine).

getPatternPlay([_,_,Board], Result) :-
    nth1(1,Board,Result).

%----------------------------- GET FLOOR
getFloorPlay([_,_,Board], Result):-
    nth1(3,Board,Result).

%------------------------------ GET WALL
getWall([_,_,Board], Wall):-
    nth1(1,Board, Wall).

%----------------------------- CHECKS IF TILING IS AVALIABLE
checkedTiled(CenterBoard,Factories):-CenterBoard=[],emptyFactories(Factories).
%Sutituye el tablero de un jugador por uno nuevo (normalmente proporconada por sustitucionTablero)
%sustitucionPatron(Jugador, NuevoTablero, JugadorOut).


%----------------------------- GET COLOR POS
% inputs: Factory, Color, Result (List with the positions inside the factories where the color is)
% Output: ListAux, list with player's chips

getColorPos(Factory,Color,ListAux,CenterBoard,CenterBoardOut,FactoryOut):-
    indexes(Factory, Color, Result),
    % List's size
    length(Result,Size),
    % Chips' player are saved inside an auxiliar list
    length(ListAux, Size),maplist(=(Color),ListAux),
    % Remove colored chips from the factory
    pickUpColor(Color,Factory,FactoryAux),
    length(FactoryAux, Size),
    NumberIter is 4 - Size,
    removeColor(NumberIter, Color, Factory, FactoryOut),
    % Remaining chips are moved towards center board
    append(FactoryAux,CenterBoard,CenterBoardOut).

%----------------------------- PICK UP COLOR
% Remove a color from a factory
pickUpColor(_, [],[]).

pickUpColor(Color, [Color|Factory], FactoryOut):-
    pickUpColor(Color, Factory, FactoryOut).

pickUpColor(Color, [T|Factory], [T|FactoryOut]):-
    dif(Color, T),
    pickUpColor(Color, Factory, FactoryOut).

removeColor(0,_,FactoryOut,FactoryOut).
removeColor(Num, Color, FactoryIn, FactoryOut):-
    select(Color, FactoryIn, '_', FactoryAux),
    Number is Num - 1,
    removeColor(Number, Color, FactoryAux, FactoryOut).




% Test case
%pickUpColor('R',['R','A','R','R'], Result).

%----------------------------- ENTER
% Introduce chips inside of a pattern line or inside the floor line
enter([Color|List], PatternLine, FloorLine, PatternLineOut, FloorLineOut):-
    select('_',PatternLine,Color,PatternLineAux),
    enter(List, PatternLineAux, FloorLine, PatternLineOut, FloorLineOut).

enter([Color|List], PatternLine, FloorLine, PatternLineOut, FloorLineOut):-
    select('_',FloorLine,Color,FloorLineAux),
    enter(List, PatternLine, FloorLineAux, PatternLineOut, FloorLineOut).

enter(_, PatternLineOut, FloorLineOut, PatternLineOut, FloorLineOut).
%TEST CASE:
% enter(['R', 'R'], ['_','_'], ['_','_','_','_','_','_','_'], Pattern, Floor).
% enter(['R', 'R'], ['A','_','_'], ['_','_','_','_','_','_','_'], Pattern, Floor).
%NumLine = 2;
%ListIn = ['R','R']
%PatternList = [['_'],['_','_'],['_','_','_'],['_','_','_','_'],['_','_','_','_','_']]
%Floor = ['_','_','_','_','_','_','_']



% Auxiliar Function that will be deleted when move player works properly
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




/*(PlayerIn, NewBoard, PlayerOut):-
    %nth0(2, PlayerOut, NewBoard, PlayerIn).
    select(2, PlayerIn, NewBoard, PlayerOut).*/

%TEST CASE:
/* sustitucionTablero(['Laura', 0,
                [ [['a','v','r','n','b'],['b','a','v','r','n'],['n','b','a','v','r'],['r','n','b','a','v'],['v','r','n','b','a']],
                   [['_'], ['_','_'],['_','_','_'],['_','_','_','_'],['_','_','_','_','_']],
                   ['_','_','_','_','_','_','_']
                ]
             ], [['a','v','r','n','b'],['b','a','v','r','n'],['n','b','a','v','r'],['r','n','b','a','v'],['v','r','n','b','a']],
                   [['R'], ['V','V'],['_','_','_'],['_','_','_','_'],['_','_','_','_','_']],
                PlayerOut).
*/

%Cambia una linea de patron del tablero de patrones
sustitucionPatron(NumPatron, NewPattern, ListPattern, PatternChanged):-
    nth0(NumPatron, PatternChanged ,NewPattern, ListPattern).

%Sustituye un elemento del tablero.
sustitucionElemTablero(BoardIn, Element, Index, BoardOut):-
    nth0(Index, BoardOut ,Element, BoardIn).

% Cambiar la linea de patron
%change(['_'],['R'],[['_'], ['_','_'],['_','_','_'],['_','_','_','_'],['_','_','_','_','_']], PatternOut).

% Cambiar el tablero del jugador

change(_,_,[],[]).
change(ElemO,ElemChange,[L1Head|L1Tail],[L1Head|ListOutT]):-is_list(L1Head),
                                                           dif(L1Head,ElemO),
                                                           change(ElemO,ElemChange,L1Tail,ListOutT).
change(ElemO,ElemChange,[ElemO|L1Tail],[ElemChange|ListOutT]):- change(ElemO,ElemChange,L1Tail,ListOutT).
change(ElemO,ElemChange,[L1Head|L1Tail],[LHeadOut|ListOutT]):- is_list(L1Head),
                                                               change(ElemO,ElemChange,L1Head,LHeadOut),
                                                               change(ElemO,ElemChange,L1Tail,ListOutT).
/*--------------------------TEST CASE sustitucionPatron
sustitucionPatron([['_'],
                    ['_','_'],
                    ['_','_','_'],
                    ['_','_','_','_'],
                    ['_','_','_','_','_']],
                    ['R', 'R'], 1, Resultado).
*/

/* ----------------------------- TEST CASE shiftPlayers
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
             ]], Resultado).*/

%---------------------------------TEST CASE DE LA LISTA DE FACTORIAS O DE ALGUN PLAYER:
% Lista de factorias = [['R', 'V', 'N', 'N'], ['R','R', 'N','N'], ['A','V', 'V', 'R']]
% PLAYER: ['Laura', '0', [ [['a','v','r','n','b'],['b','a','v','r','n'],['n','b','a','v','r'],['r','n','b','a','v'],['v','r','n','b','a']], [['_'], ['_','_'],['_','_','_'],['_','_','_','_'],['_','_','_','_','_']], ['_','_','_','_','_','_','_'] ].


/*------------------------------TEST CASE PARA insertChips
insertChips(
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


/*------------------------------TEST CASE movePlayerA
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

/* -------------------------------TEST CASE PARA TILLING
tiling(0, ['Laura', 0,
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

/* -----------------------------------DDEE PARA JUGADORES
Jugador 1 =   ['Laura', '0',
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