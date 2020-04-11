
%------------------------------- ANALIZADOR -----------------------------------------------------
% Autor:
% Fecha: 14/03/2019

:-consult('./DiccionarioEs.pl').
:-consult('./DiccionarioEn.pl').
:-consult('./GramaticaEn.pl').
:-consult('./GramaticaEs.pl').
:-consult('./draw.pl').
:-consult('./Tests.pl').









%------------------- COSA ANTIGUA

%(X,[las, tijeras, cortan, el, papel],[]),sentence(X,Ingles,[]).


% Determinantes de la lengua española.
% 
% Det -> Determinante mismo.
% Gen -> Género del determinante {Masculino, Femenino, Neutral}
% Num -> Número del determinante  {Singular, Plural}
determinante(det(Det), Gen, Num)    --> [Det], {det(Det, Gen, Num)}.
    
    % Masculino Singular.
    det(      el, m, s).
    det(      un, m, s).
    det( nuestro, m, s).
    det( vuestro, m, s).



% DET. NÚCLEO ADJ.
g_nominal(g_nom(D, N,  GA), PER, GEN, NUM)      -->      determinante(D, GEN1, NUM1),  nombre(N, PER, GEN, NUM), g_adjetival(GA, GEN, NUM), {comprobarGen(GEN1, GEN)}, {comprobarNum(NUM1, NUM)}.


comprobarGen(G1, G2) :-
    G1 \= G2 ->
       (
        G1 = 'n' -> (write(''))
        ;
           (
            G2 = 'n' -> (write(''))
            ;
            (writeln('El genero de los argumentos recibidos no coincide.'))
           )
       )
    ;
    (write('')).

comprobarNum(N1, N2) :-
    N1 \= N2 ->
    (writeln('El numero de los argumentos recibidos no coincide.'))
    ;
    (write('')).
        
comprobarPer(P1, P2) :-
        P1 \= P2 -> 
        (
         P1 = 0 ->
                (write(''))
                ;
                (
                 P2 = 0 -> (write(''))
                 ;
                (writeln('El número de persona del sujeto no coincide con el del verbo'))
                )
        )
        ;
        (write('')).












