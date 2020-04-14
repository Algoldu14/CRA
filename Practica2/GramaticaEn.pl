%------------------------------- G R A M A T I C A           I N G L E S

sentence(s(GN,GV,GN2)) --> g_noun(GN,_,Num),g_verb(GV,_,Num),g_noun(GN2,_,_).
sentence(s(GN,GV,GC)) --> g_noun(GN,_,Num),g_verb(GV,_,Num),g_circus(GC,_,_).
sentence(s(GN,GV,GN2,GC)) --> g_noun(GN,_,Num),g_verb(GV,_,Num),g_noun(GN2,_,Num),g_circus(GC,_,_).
sentence(s(GN,GV)) --> g_noun(GN,G,Num),g_verb(GV,G,Num).
sentence(s(GV,GN)) --> g_verb(GV,_,Num),g_noun(GN,_,Num).
sentence(s(GN,C,Claus,V))-->g_noun(GN,G,Num),conjuction(C),gramatic_clause(Claus),g_verb(V,G,Num).
sentence(s(GN,C,Claus,V,O))-->g_noun(GN,G,N), conjuction(C), gramatic_clause(Claus),g_verb(V,G,N),g_noun(O,_,_).
sentence(s(C1,C,C2))-->gramatic_clause(C1),conjuction(C),gramatic_clause(C2).


gramatic_clause(sub(GN,V,A))-->g_noun(GN,G,N),g_verb(V,G,N),g_circus(A,_,_).
gramatic_clause(sub(GN,V,O))--> g_noun(GN,G,N),g_verb(V,G,N),g_noun(O,_,_) .
gramatic_clause(sub(V,O))--> g_verb(V,G,N),g_noun(O,_,_).
gramatic_clause(sub(S,V))--> g_noun(S,G,N),g_verb(V,G,N).


g_noun(sn(A,N),G,Num) --> article(A,G,Num),noun(N,G,Num).
g_noun(sn(NP,NP2),_,Num) --> noun(NP,_,Num),noun(NP2,_,Num).
g_noun(sn(NP),_,Num) --> noun(NP,_,Num).
g_noun(sn(A,N,AD),G,Num) --> article(A,G,Num),adjective(AD,_),noun(N,G,Num).
g_noun(sn(A,AD,N),G,Num) --> article(A,G,Num),adjective(AD,_),noun(N,G,Num).
g_noun(sn(PR,N),G,Num) --> pronoms(PR),noun(N,G,Num).
g_noun(sn(A,NP,P,N),G,Num) --> article(A,G,Num),noun(NP,Num,_), preposition(P),noun(N,G,Num).
g_noun(sn(A,N,P,NP),G,Num) --> article(A,G,Num),noun(NP,Num,_), preposition(P),noun(N,G,Num).
g_noun(sn(P),_,_)-->pronoms(P).
g_noun(sn(A,NP,P,N),G,Num) --> article(A,G,Num),noun(NP,Num,_), preposition(P),noun(N,G,Num).
g_noun(sn(A,N,P,NP),G,Num) --> article(A,G,Num),noun(NP,Num,_), preposition(P),noun(N,G,Num).
g_noun(sn(P),G,N)--> pronoms(P).
g_noun(sn(N1,N2),_,_) --> proper_name(N1,_,_),proper_name(N2,_,_).
g_noun(sn(N1),_,_) --> proper_name(N1,_,_).
g_noun(sn(A,S,P,C),G,N)-->article(A,_,_),noun(S,G,N),preposition(P),proper_name(C,_,_).
g_noun(sn(D,S),_,N) --> deter(D,_,N),noun(S,_,N).

g_verb(sv(V),_,Num) --> verb(V,Num).
g_verb(sv(V,AD),G,Num) --> verb(V,Num),adjective(AD,G).

g_circus(sc(ADV,ADV2),_,_) --> adverb(ADV),adverb(ADV2).
g_circus(sc(P,A,N),G,Num) --> preposition(P),article(A,G,Num),noun(N,G,Num).
g_circus(sc(ADV),_,_) --> adverb(ADV).