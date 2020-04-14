%-------------------------------- D I C C I O N A R I O     E N G L I S H

article(m(art_1),_,_)  --> [the].
article(m(art_2),_,pl) --> [a].
article(m(art_2),_,sg) --> [an].
article(m(art_3),_,_)  -->[some].
article(m(art_4),_,_)  --> [a].


noun(n(n_1),m,sg)         --> [man].
noun(n(n_2),f,sg)         --> [woman].
noun(n(n_3),_,_)          --> [john].
noun(n(n_4),_,_)          --> [mery].
noun(n(n_5),f,sg)         --> [apple].
noun(n(n_6),f,pl)         --> [apples].
noun(n(n_7),m,sg)         --> [cat].
noun(n(n_8),m,sg)         --> [mouse].
noun(n(n_9),m,pl)         --> [mice].
noun(n(n_10),m,sg)        --> [student].
noun(n(n_11),f,sg)        --> [university].
noun(n(n_12),m,sg)        --> [dog].
noun(n(n_13),m,sg)        --> [garden].
noun(n(n_14),m,sg)        --> [neighbour].
noun(n(n_15),m,sg)        --> [canary].
noun(n(n_16),m,sg)        --> [coffee].
noun(n(n_17),m,sg)        --> [newspaper].
noun(n(n_18),_,_)         --> [oscar].
noun(n(n_19),_,_)         --> [wilde].
noun(n(n_20),m,sg)        --> [ghost].
noun(n(n_21),_,_)         --> [canterville].


verb(v(v_1),sg)   --> [cut].
verb(v(v_2),sg)   --> [wrap].
verb(v(v_3),sg)   --> [breaks].
verb(v(v_4),sg)   --> [eats].
verb(v(v_2),pl)   -->[eat],!.
verb(v(v_2),sg)   -->[eat],!.
verb(v(v_3),sg)   -->[loves].
verb(v(v_4),sg)   -->[studies].
verb(v(v_5),sg)   -->[chased].
verb(v(v_6),sg)   -->[is].
verb(v(v_7),pl)   -->[saw].
verb(v(v_8),sg)   -->[sings].
verb(v(v_9),sg)   -->[has].
verb(v(v_10),sg)  -->[reads].
verb(v(v_11),sg)  -->[wrote].


adjective(adj(adj_1),_)  -->[red].
adjective(adj(adj_2),m)  -->[big].
adjective(adj(adj_2),f)  -->[large].
adjective(adj(adj_3),_)  -->[grey].
adjective(adj(adj_4),_)  -->[black].
adjective(adj(adj_5),_)  -->[thin].
adjective(adj(adj_6),_)  -->[tall].
adjective(adj(adj_7),_)  -->[yellow].


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
preposition(p(p20))     --> [to].
preposition(p(p20))     --> [towards].
preposition(p(p21))     --> [so].
preposition(p(p22))     --> [opposite].
preposition(p(p23))     --> [via].
preposition(p(p24))     --> [above].
preposition(p(p25))     --> [in].
preposition(p(p25))     --> [on].
preposition(p(p25))     --> [inside].
preposition(p(p26))     --> [like].

conjuction(conj(conj_1))  -->[and].
conjuction(conj(conj_2)) -->[that].

pronoms(pron(pron_1))  -->[my].
pronoms(pron(pron_2))  -->[that].

adverb(adv(adv_1))  -->[very].
adverb(adv(adv_2))  -->[yesterday].
adverb(adv(adv_3))  -->[well].







