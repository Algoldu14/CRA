%------------------------------- G R A M A T I C A           E S P A Ñ O L

% Oraciones

oracion(s(S,V,O)) --> sint_n(S,G,N), sint_v(V,G,N), sint_n(O,_,_).
oracion(s(S,V,C)) --> sint_n(S,G,N), sint_v(V,G,N), sint_c(C,_,_).
%oracion(s()) -->
%Sintagmas Nominales
%falta gestión de nombres propios
sint_n(sn(M,S),G,N) --> articulo(M,G,N), nombre(S,G,N).
sint_n(sn(A,S,AD),G,N) --> articulo(A, G, N), nombre(S,G,N),adjetivo(AD,G,N).
sint_n(sn(A,AD,S),G,N) --> articulo(A, G, N), nombre(S,G,N),adjetivo(AD,G,N).
sint_n(sn(P,S),G,N) --> pronombre(P, G, N), nombre(S,G,N).

%Sintagmas Verbales

sint_v(sv(V),_,Num) --> verbo(V,Num). %Verbo a secas
sint_v(sv(V,AD),G,Num) -->verbo(V,Num),adjetivo(AD,G,Num). %verbo con adjetivo ie: "es grande"

%Sintagmas complemento
sint_c(sc(P,A,S),G,N) --> preposicion(P), articulo(A,G,N), nombre(S,G,N).
sint_c(sc(Adv1,Adv2),_,_) -->adverbio(Adv1),adverbio(Adv2).
sint_c(sc(Adv),_,_)-->adverbio(Adv).