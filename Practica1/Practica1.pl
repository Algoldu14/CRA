
bag(['N','N','N','N','N','N','N','N','N','N','A','A','A','A','A','A','A','A','A','A','B','B','B','B','B','B','B','B','B','B','R','R','R','R','R','R','R','R','R','R','V','V','V','V','V','V','V','V','V','V']).

random_bag(BagS):-bag(Bag),random_permutation(Bag,BagS).

fac1(['_','_','_','_',]).
fac2(['_','_','_','_',]).
fac3(['_','_','_','_',]).
fac4(['_','_','_','_',]).
fac5(['_','_','_','_',]).
fac7(['_','_','_','_',]).
fac8(['_','_','_','_',]).
fac9(['_','_','_','_',]).

factories([f1,f2,f3,f4,f5,f6,f7,f8,f9]).

fill_factory(BagIn,BagOut,FactoryIn,FactoryOut):-
    BagIn=[Ficha|BagAux],
    select('_',FactoryIn,Ficha,FactoryAux),
    fill_factory(BagAux,BagOut,FactoryAux,FactoryOut),!.
fill_factory(BagOut,BagOut,FactoryOut,FactoryOut).

fill_factories(BagOut,BagOut,0,FactoriesOut,FactoriesOut).
fill_factories(BagIn,BagOut,NFact,FactoriesAux,FactoriesOut):-
    f1(Fact),fill_factory(BagIn,BagAux,Fact,FactAux),
    append(FactoriesAux,[FactAux],FactoriesAux2),
    NFactAux is NFact - 1,
    fill_factories(BagAux,BagOut,NFactAux,FactoriesAux2,FactoriesOut).