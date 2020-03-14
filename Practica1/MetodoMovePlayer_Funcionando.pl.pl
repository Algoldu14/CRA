
% Te devuleve la lista de patrones de un jugador
getPatternPlay([_,_,Board], Result) :-
    nth0(1,Board,Result). 

% TEST CASE
/*
 * 

movePlayer([['R', 'V', 'N', 'N'], ['R','R', 'N','N'], ['A','V', 'V', 'R']],
             [], 
             ['Laura', '0',
                [ [['a','v','r','n','b'],['b','a','v','r','n'],['n','b','a','v','r'],['r','n','b','a','v'],['v','r','n','b','a']], 
                   [['_'], ['_','_'],['_','_','_'],['_','_','_','_'],['_','_','_','_','_']], 
                   ['_','_','_','_','_','_','_'] 
                ]
             ],
             PlayerOut, ListFactoriesOut, CenterBoardOut).
 */
enter([Color|List], PatterLine, FloorLine,PatterLineOut, FloorLineOut):-
    (member('_', PatterLine) ->
        nth0('_',[Color],PatterLine,PatterLineOut), 	enter([List],PatterLineOut,FloorLine,PatterLineOut,Floor);
    (member('_',FloorLine) ->
        nth0('_',[Color],FloorLine,FloorLineOut), enter([List],PatterLine,FloorLineOut,PatterLine, FloorLineOut);
        enter([List], PatterLine,FloorLine,PatternLine,FloorLine)
    )).

indices(List, E, Is) :- findall(N, nth1(N, List, E), Is).


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


movePlayer(ListFactories, CenterBoard, Player, PlayerOut, ListFactoriesOut, CenterBoardOut):- 
    write('Select a factory: '), read(NumFactory),
   nth0(NumFactory, ListFactories, FactoryOut),
   % write('Select a color; '), read(Color),
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


















