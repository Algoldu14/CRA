%------------------------------- G R A M A T I C A           I N G L E S

sentence(o(GN,GV,GN2)) --> g_noun(GN,_,Num),g_verb(GV,_,Num),g_noun(GN2,_,_).
sentence(o(GN,GV,GC)) --> g_noun(GN,_,Num),g_verb(GV,_,Num),g_circus(GC,_,_).
sentence(o(GN,GV,GN2,GC)) --> g_noun(GN,_,Num),g_verb(GV,_,Num),g_noun(GN2,_,Num),g_circus(GC,_,_).
sentence(o(GN,GV)) --> g_noun(GN,G,Num),g_verb(GV,G,Num).
sentence(o(GV,GN)) --> g_verb(GV,_,Num),g_noun(GN,_,Num).
sentence(o(GN,PR,O1,GV,GN2)) --> g_noun(GN,_,Num),pronoms(PR),sentence(O1),g_verb(GV,_,Num),g_noun(GN2,_,_).
sentence(o(O1,C,O2)) --> sentence(O1),conjuction(C),sentence(O2).


%Grupo g_nominal

g_noun(gn(A,N),G,Num) --> article(A,G,Num),noun(N,G,Num).
g_noun(gn(NP,NP2),_,Num) --> noun(NP,Num,_),noun(NP2,Num,_).
g_noun(gn(NP),_,Num) --> noun(NP,Num,_).
g_noun(gn(A,N,AD),G,Num) --> article(A,G,Num),adjective(AD,_),noun(N,G,Num).
g_noun(gn(A,AD,N),G,Num) --> article(A,G,Num),adjective(AD,_),noun(N,G,Num).
g_noun(gn(PR,N),G,Num) --> pronoms(PR),noun(N,G,Num).
g_noun(gn(A,NP,P,N),G,Num) --> article(A,G,Num),noun(NP,Num,_), preposition(P,G),noun(N,G,Num).
g_noun(gn(A,N,P,NP),G,Num) --> article(A,G,Num),noun(NP,Num,_), preposition(P,G),noun(N,G,Num).

g_verb(gv(V),_,Num) --> verb(V,Num).
g_verb(gv(V,AD),G,Num) --> verb(V,Num),adjective(AD,G).



g_circus(gc(ADV,ADV2),_,_) --> adverb(ADV),adverb(ADV2).
g_circus(gc(P,A,N),G,Num) --> preposition(P,G), article(A,G,Num),noun(N,G,Num).
g_circus(gc(ADV),_,_) --> adverb(ADV).