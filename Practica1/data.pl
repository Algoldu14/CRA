% Autor: �lvaro Golbano y Laura Ramos
% Fecha: 27/02/2020

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

ini_player(Name,Points,PlayerOut):-board(Board),PlayerOut=[Name,Points,Board].

patterns(Patterns):-patt1(Pat1),patt2(Pat2),patt3(Pat3),patt4(Pat4),patt5(Pat5),Patterns = [Pat1,Pat2,Pat3,Pat4,Pat5].
patt1(['_']).
patt2(['_','_']).
patt3(['_','_','_']).
patt4(['_','_','_','_']).
patt5(['_','_','_','_','_']).

the_wall(Wall):-the_wall_lines(Lines),Wall = Lines.
the_wall_lines([['a','v','r','n','b'],['b','a','v','r','n'],['n','b','a','v','r'],['r','n','b','a','v'],['v','r','n','b','a']]).
the_floor(['_','_','_','_','_','_','_']).

board(Board):-patterns(Patterns),the_wall(Wall),the_floor(Floor),Board = [Patterns,Wall,Floor].