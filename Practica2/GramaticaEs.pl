%------------------------------- G R A M A T I C A           E S P A Ñ O L

% Oraciones

oracion(s(S,V,O)) --> sint_n(S,G,N), sint_v(V,G,N), sint_n(O,_,_).
oracion(s(S,V,C)) --> sint_n(S,G,N), sint_v(V,G,N), sint_c(C,_,_).
oracion(s(S,V,O,C))-->sint_n(S,G,N),sint_v(V,G,N), sint_n(O,_,_),sint_c(C,_,_).
oracion(s(S,V1,O1,C,V2,O2))--> sint_n(S,G,N), sint_v(V,G,N), sint_n(O,_,_),conjuncion(C),sint_v(V2,G,N), sint_n(O2,_,_).
oracion(s(S1,V1,O1,C,S2,V2,O2))--> sint_n(S1,G1,N1), sint_v(V1,G1,N1), sint_n(O1,_,_),conjuncion(C),sint_n(S2,G2,N2),sint_v(V2,G2,N2), sint_n(O2,_,_).
oracion(s(N)) --> sint_n(N,G,N).

%Sintagmas Nominales
%falta gestión de nombres propios
sint_n(sn(M,S),G,N) --> articulo(M,G,N), nombre(S,G,N).
sint_n(sn(A,S,AD),G,N) --> articulo(A, G, N), nombre(S,G,N),adjetivo(AD,G,N).
sint_n(sn(A,AD,S),G,N) --> articulo(A, G, N), nombre(S,G,N),adjetivo(AD,G,N).
sint_n(sn(P,S),G,N) --> pronombre(P, G, N), nombre(S,G,N).
sint_n(sn(P),G,N)-->pronombre(P,G,N).
sint_n(sn(N),G,N)-->nombre(N,G,N).


%Sintagmas Verbales

sint_v(sv(V),_,Num) --> verbo(V,Num). %Verbo a secas
sint_v(sv(V,AD),G,Num) -->verbo(V,Num),adjetivo(AD,G,Num). %verbo con adjetivo ie: "es grande"

%Sintagmas complemento
sint_c(sc(P,A,S),G,N) --> preposicion(P), articulo(A,G,N), nombre(S,G,N).
sint_c(sc(Adv1,Adv2),_,_) -->adverbio(Adv1),adverbio(Adv2).
sint_c(sc(Adv),_,_)-->adverbio(Adv).
sint_c(sc(P,N))-->preposicion(P), nombre(N,_,_).