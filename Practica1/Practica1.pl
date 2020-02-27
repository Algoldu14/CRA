% Autor: Álvaro Golbano y Laura Ramos

random_bag(BagS):-bag(Bag),random_permutation(Bag,BagS).

:-consult('./data.pl').

fill_factory(BagIn,BagOut,FactoryIn,FactoryOut):-%Regla que nos permite llenar las casillas de una factoria con las fichas de la bolsa permitada aleatoriamente
    BagIn=[Ficha|BagAux],
    select('_',FactoryIn,Ficha,FactoryAux),
    fill_factory(BagAux,BagOut,FactoryAux,FactoryOut),!.
fill_factory(BagOut,BagOut,FactoryOut,FactoryOut).


fill_factories(BagOut,BagOut,0,FactoriesOut,FactoriesOut).%hace lo que la anterior pero con N factorias
%              BagS, bagOut,Numero,[],         factoriesOut
fill_factories(BagIn,BagOut,NFact,FactoriesAux,FactoriesOut):-
    f1(Fact),fill_factory(BagIn,BagAux,Fact,FactAux),
    append(FactoriesAux,[FactAux],FactoriesAux2),
    NFactAux is NFact - 1,
    fill_factories(BagAux,BagOut,NFactAux,FactoriesAux2,FactoriesOut).
    
    

