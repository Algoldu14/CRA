
%------------------------------- ANALIZADOR -----------------------------------------------------
% Autor:
% Fecha: 14/03/2019

:-consult('./Diccionario.pl').
:-consult('./Gramatica.pl').
:-consult('./draw.pl').

%-------------------------------------------------------------------------------
es_test1:-  oracion(X,[el, hombre, come, una, manzana],[]), draw(X).
es_test2:-  oracion(X,[ellos, comen, manzanas],[]),draw(X).
es_test3:-  oracion(X,[tu, comes, una, manzana, roja],[]),draw(X).
es_test4:-  oracion(X,[juan, ama, a, maria],[]),draw(X).
es_test5:-  oracion(X,[el, gato, grande, come, un, raton, gris]), draw(X).
es_test6:-  oracion(X,[juan, estudia, en, la, universidad],[]),draw(X).
es_test7:-  oracion(X,[el, alumno, ama, la, universidad],[]),draw(X).
es_test8:-  oracion(X,[el, gato, come, ratones],[]),draw(X).
es_test9:-  oracion(X,[el, raton, que, cazo, el, gato, era, gris],[]),draw(X).
es_test10:- oracion(X,[la, universidad, es, grande],[]),draw(X).
es_test11:- oracion(X,[el, perro, persiguio, un, gato, negro, en, el, jardin],[]),draw(X).
es_test12:- oracion(X,[el, hombre, que, vimos, ayer, es, mi, vecino],[]),draw(X).
es_test13:- oracion(X,[el, canario, amarillo, canta, muy, bien],[]),draw(X).
es_test14:- oracion(X,[juan, toma, un, cafe, y, lee, el, periodico],[]),draw(X).
es_test15:- oracion(X,[juan, es, delgado, y, maria, es, alta],[]),draw(X).
es_test16:- oracion(X,[oscar, wilde, escribio, el, fantasma, de, canterville],[]),draw(X).
% Otra forma de escribir una oración sería usando phrase, que es una opción
% interna de PROLOG para las oraciones.

en_test1:-  oracion(X,[the, man, eats, an, apple],[]), draw(X).
en_test2:-  oracion(X,[they, eat, apples],[]),draw(X).
en_test3:-  oracion(X,[you, eat, a, red, apple],[]),draw(X).
en_test4:-  oracion(X,[john, loves, mary],[]),draw(X).
en_test5:-  oracion(X,[the, big, cat, eats, a, grey, mouse]), draw(X).
en_test6:-  oracion(X,[john, studies, at, the, university],[]),draw(X).
en_test7:-  oracion(X,[the, student, loves, the, university],[]),draw(X).
en_test8:-  oracion(X,[the, cat, eats, mice],[]),draw(X).
en_test9:-  oracion(X,[the, mouse, that, the, cat, caught, was, grey],[]),draw(X).
en_test10:- oracion(X,[the, university, is, big],[]),draw(X).
en_test11:- oracion(X,[the, dog, chased, a, black, cat, in, the, garden],[]),draw(X).
en_test12:- oracion(X,[the, man, that, we, saw, yesterday, is, my, neighbor],[]),draw(X).
en_test13:- oracion(X,[the, yellow, canary, sings, very, well],[]),draw(X).
en_test14:- oracion(X,[john, drinks, a, coffee, and, reads, the, newspaper],[]),draw(X).
en_test15:- oracion(X,[john, is, skinny, and, mary, is, tall],[]),draw(X).
en_test16:- oracion(X,[oscar, wilde, wrote, the, phantom, of, canterville],[]),draw(X).

%------------------------------- G R A M A T I C A           E S P A Ñ O L

% Reglas gramaticales

oracion(s(S,V,O)) --> sint_n(S,N), verbo(V,N), sint_n(O,_).

sint_n(np(M,S),N) --> articulo(M,G,N), nombre(S,G,N).



%------------------------------- G R A M A T I C A           I N G L E S

sentence(s(S,V,O)) --> nom_p(S,N), verb(V,N), nom_p(O,_).

nom_p(np(M,S),N) --> modifier(M), noun(S,N).


%-------------------------------- D I C C I O N A R I O     E S P A Ñ O L 

articulo(m(art),f,sg)   --> [la].
articulo(m(art),m,sg)   --> [el].
articulo(m(art),f,pl)   --> [las].
articulo(m(art),m,pl)   --> [los].
articulo(m(art1),m,sg)  --> [un].
articulo(m(art1),f,sg)  --> [una].
articulo(m(art1),m,pl)  --> [unos].
articulo(m(art1),f,pl)  --> [unas].

nombre(n(n_1),m,sg)     --> [hombre].
nombre(n(n_2),f,sg)     --> [mujer].
nombre(n(n_3),_,_)      --> [juan].
nombre(n(n_4),_,_)      --> [maria].
nombre(n(n_5),f,sg)     --> [manzana].
nombre(n(n_6),f, pl)    --> [manzanas].
nombre(n(n_7),m,sg)     --> [gato].
nombre(n(n_8),m,sg)     --> [raton].
nombre(n(n_9),m. pl)    --> [ratones].
nombre(n(n_10),m,sg)    --> [alumno].
nombre(n(n_11),f,sg)    --> [universidad].
nombre(n(n_12),m,sg)    --> [perro].
nombre(n(n_13),m,sg)    --> [jardin].
nombre(n(n_14),m,sg)    --> [vecino].
nombre(n(n_15),m,sg)    --> [canario].
nombre(n(n_16),m,sg)    --> [cafe].
nombre(n(n_17),m,sg)    --> [periodico].
nombre(n(n_18),_,_)     --> [oscar].
nombre(n(n_19),_,_)     --> [wilde].
nombre(n(n_20),m,sg)    --> [fantasma].
nombre(n(n_21),_,_)     --> [canterville].
nombre(n(n_22),f,sg)    --> [piedra].
nombre(n(n_23),m,sg)    --> [papel].
nombre(n(n_24),f,pl)    --> [tijeras].


pronombre(pn(p_1),m,sg) --> [el].
pronombre(pn(p_2),m,pl) --> [ellos].
pronombre(pn(p_3),f,sg) --> [ella].
pronombre(pn(p_3),_,sg) --> [ello].
pronombre(pn(p_2),f,pl) --> [ellas].
pronombre(pn(p_4),_,sg) --> [tu].
pronombre(pn(p_5),_,sg) --> [yo].
pronombre(pn(p_6),m,pl) --> [nosotros].
pronombre(pn(p_6),f,pl) --> [nosotras].
pronombre(pn(p_7),m,pl) --> [vosotros].
pronombre(pn(p_7),f,pl) --> [vosotras].

adjetivo(a(a1),_,sg)    --> [grande].
adjetivo(a(a1),_,pl)    --> [grandes].
adjetivo(a(a2),m,sg)    --> [rojo].
adjetivo(a(a2),f,sg)    --> [roja].
adjetivo(a(a2),m,pl)    --> [rojos].
adjetivo(a(a2),f,pl)    --> [rojas].
adjetivo(a(a3),_,sg)    --> [gris].
adjetivo(a(a3),_,pl)    --> [grises].
adjetivo(a(a4),m,sg)    --> [negro].
adjetivo(a(a4),f,sg)    --> [negra].
adjetivo(a(a4),m,pl)    --> [negros].
adjetivo(a(a4),f,pl)    --> [negras].
adjetivo(a(a5),m,sg)    --> [amarillo].
adjetivo(a(a5),f,sg)    --> [amarilla].
adjetivo(a(a5),m,pl)    --> [amarillos].
adjetivo(a(a5),f,pl)    --> [amarillas].
adjetivo(a(a6),m,sg)    --> [delgado].
adjetivo(a(a6),f,sg)    --> [delgada].
adjetivo(a(a6),m,pl)    --> [delgados].
adjetivo(a(a6),f,pl)    --> [delgadas].
adjetivo(a(a7),m,sg)    --> [alto].
adjetivo(a(a7),f,sg)    --> [alta].
adjetivo(a(a7),m,pl)    --> [altos].
adjetivo(a(a7),f,pl)    --> [altas].

verbo(v(v_1),sg)        --> [cortas].
verbo(v(v_2),sg)        --> [envuelve].
verbo(v(v_3),sg)        --> [rompe].
verbo(v(v_1),pl)        --> [cortan].
verbo(v(v_2),pl)        --> [envuelven].
verbo(v(v_3),pl)        --> [rompen].
verbo(v(v_7),sg)        --> [come].
verbo(v(v_8),pl)        --> [ama].
verbo(v(v_9),pl)        --> [estudia].
verbo(v(v_10),pl)       --> [cazo].
verbo(v(v_11),pl)       --> [era].
verbo(v(v_12),pl)       --> [es].
verbo(v(v_7),pl)        --> [comen].
verbo(v(v_7),sg)        --> [comes].
verbo(v(v_13),sg)       --> [persiguio].
verbo(v(v_14),pl)       --> [vimos].              
verbo(v(v_15),sg)       --> [canta].
verbo(v(v_16),sg)       --> [toma].
verbo(v(v_17,sg)        --> [lee].
verbo(v(v_18,sg)        --> [escribio].

preposicion(p(p1))      --> [a].
preposicion(p(p2))      --> [ante].
preposicion(p(p3))      --> [bajo].
preposicion(p(p4))      --> [cabe].
preposicion(p(p5))      --> [con].
preposicion(p(p6))      --> [contra].
preposicion(p(p7))      --> [de].
preposicion(p(p8))      --> [desde].
preposicion(p(p9))      --> [hasta].
preposicion(p(p10))     --> [para].
preposicion(p(p11))     --> [por].
preposicion(p(p12))     --> [segun].
preposicion(p(p13))     --> [sin].
preposicion(p(p14))     --> [sobre].
preposicion(p(p15))     --> [tras].
preposicion(p(p16))     --> [mediante].
preposicion(p(p17))     --> [durante].
preposicion(p(p18))     --> [en].
preposicion(p(p19))     --> [entre].
preposicion(p(p20))     --> [hacia].
preposicion(p(p21))     --> [so].
preposicion(p(p22))     --> [versus].
preposicion(p(p23))     --> [via].
preposicion(p(p24))     --> [sobre].
preposicion(p(p25))     --> [en].
preposicion(p(p26))     --> [como].

conjuncion(c(c1))       --> [que].
conjuncion(c(c2))       --> [y].
conjuncion(c(c2))       --> [e].
conjuncion(c(c3))       --> [ni].
conjuncion(c(c4))       --> [o].
conjuncion(c(c5))       --> [pero].


determinante(d(d1), 1,sg)  --> [mi].
determinante(d(d2), 2,sg)  --> [tu].
determinante(d(d1), 3,sg)  --> [su].
determinante(d(d1), 1,pl)  --> [mis].
determinante(d(d1), 2,pl)  --> [tus].
determinante(d(d1), 3,pl)  --> [sus].


adverbio(a(a1))     --> [ayer].
adverbio(a(a2))     --> [muy].
adverbio(a(a3))     --> [bien].

%-------------------------------- D I C C I O N A R I O     E N G L I S H
modifier(m(art))      --> [the].
modifier(m(art1))     --> [a].
modifier(m(art2))     --> [an].

noun(n(n_1),m,sg)     --> [man].
noun(n(n_2),f,sg)	  --> [woman].
noun(n(n_3),_,_)	  --> [john].
noun(n(n_4),_,_)	  --> [mery].
noun(n(n_5),f,sg)     --> [apple].
noun(n(n_6),f,pl)	  --> [apples].
noun(n(n_7),m,sg)     --> [cat].
noun(n(n_8),m,sg)	  --> [mouse].
noun(n(n_9),m,pl)	  --> [miece].
noun(n(n_10),m,sg)	  --> [student].
noun(n(n_11),f,sg)	  --> [university].
noun(n(n_12),m,sg)    --> [dog].
noun(n(n_13),m,sg)    --> [garden].
noun(n(n_14),m,sg)	  --> [neighbour].
noun(n(n_15),m,sg)	  --> [canary].
noun(n(n_16),m,sg)	  --> [coffee].
noun(n(n_17),m,sg)	  --> [newspaper].
noun(n(n_18),_,_)	  --> [oscar].
noun(n(n_19),_,_)	  --> [wilde].
noun(n(n_20),m,sg)    --> [ghost].
noun(n(n_21),_,_)	  --> [canterville].

verb(v(v_1),sg)       --> [cut].
verb(v(v_2),sg)       --> [wrap].
verb(v(v_3),sg)       --> [breaks].
verb(v(v_4),sg)

adjective             --> [red].  %%Falta por completar
adjective             --> [big].
adjective             --> [grey].
adjective             --> [small].


preposition(p(p1))      --> [to].
preposition(p(p1))      --> [towards].
preposition(p(p2))      --> [before].
preposition(p(p3))      --> [below].
preposition(p(p4))      --> [near].
preposition(p(p5))      --> [with].
preposition(p(p6))      --> [against].
preposition(p(p7))      --> [of].
preposition(p(p8))      --> [from].
preposition(p(p8))      --> [since].
preposition(p(p9))      --> [until].
preposition(p(p10))     --> [for].
preposition(p(p11))     --> [by].
preposition(p(p12))     --> [by].
preposition(p(p13))     --> [without].
preposition(p(p14))     --> [about].
preposition(p(p15))     --> [after].
preposition(p(p15))     --> [behind].
preposition(p(p15))     --> [beyond].
preposition(p(p16))     --> [through].
preposition(p(p17))     --> [during].
preposition(p(p18))     --> [at].
preposition(p(p19))     --> [among].
preposition(p(p19))     --> [between].
preposition(p(p20))     --> [to].
preposition(p(p20))     --> [towards].
preposition(p(p21))     --> [so].
preposition(p(p22))     --> [opposite].
preposition(p(p23))     --> [via].
preposition(p(p24))     --> [above].
preposition(p(p25))     --> [in].
preposition(p(p25))     --> [on].
preposition(p(p25))     --> [inside].
preposicion(p(p26))     --> [like].




%------------------- COSA ANTIGUA

oracion(X,[las, tijeras, cortan, el, papel],[]),sentence(X,Ingles,[]).


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












