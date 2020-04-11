%-------------------------------- D I C C I O N A R I O     E S P A Ñ O L 

articulo(m(art),f,sg)   --> [la].
articulo(m(art),m,sg)   --> [el].
articulo(m(art),f,pl)   --> [las].
articulo(m(art),m,pl)   --> [los].
articulo(m(art1),m,sg)  --> [un].
articulo(m(art1),f,sg)  --> [una].
articulo(m(art1),m,pl)  --> [unos].
articulo(m(art1),f,pl)  --> [unas].

%faltan los nombres propios
nombre(n(n_1),m,sg)     --> [hombre].
nombre(n(n_2),f,sg)     --> [mujer].
nombre(n(n_3),_,_)      --> [juan].
nombre(n(n_4),_,_)      --> [maria].
nombre(n(n_5),f,sg)     --> [manzana].
nombre(n(n_6),f, pl)    --> [manzanas].
nombre(n(n_7),m,sg)     --> [gato].
nombre(n(n_8),m,sg)     --> [raton].
nombre(n(n_9),m, pl)    --> [ratones].
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
verbo(v(v_17),sg)        --> [lee].
verbo(v(v_18),sg)        --> [escribio].

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





