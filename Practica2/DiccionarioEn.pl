%-------------------------------- D I C C I O N A R I O     E N G L I S H

article(m(art),_,_) --> [the].
article(m(art1),_,_) --> [a].
article(m(art1),_,_) --> [an].

noun(n(n_1),m,sg)         --> [man].
noun(n(n_2),f,sg)         --> [woman].
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
noun(n(n_20),m,sg)        --> [ghost].


proper_name(np(np_1),_,_) --> [john].
proper_name(np(np_2),_,_) --> [mary].
proper_name(np(np_3),_,_) --> [oscar].
proper_name(np(np_4),_,_) --> [wilde].
proper_name(np(np_5),_,_) --> [canterville].


verb(v(v_1),sg)   --> [eats].
verb(v(v_1),pl)   --> [eat],!.
verb(v(v_1),sg)   --> [eat],!.
verb(v(v_2),sg)   -->[loves].
verb(v(v_3),sg)   -->[studies].
verb(v(v_6),sg)   -->[chased].
verb(v(v_4),sg)   -->[caught].
verb(v(v_5),sg)   -->[is].
verb(v(v_7),pl)   -->[saw].
verb(v(v_8),sg)   -->[sings].
verb(v(v_9),sg)   -->[drinks].
verb(v(v_10),sg)  -->[reads].
verb(v(v_11),sg)  -->[wrote].



adjective(a(a2),_)  -->[red].
adjective(a(a1),_)  -->[big].
adjective(a(a3),_)  -->[grey].
adjective(a(a4),_)  -->[black].
adjective(a(a6),_)  -->[thin].
adjective(a(a7),_)  -->[tall].
adjective(a(a5),_)  -->[yellow].


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

conjuction(c(c2))  -->[and].
conjuction(c(c1))  -->[that].

pronoms(pron(p_2))  -->[they].
pronoms(pron(p_4))  -->[you].

adverb(a(a2))  -->[very].
adverb(a(a1))  -->[yesterday].
adverb(a(a3))  -->[well].

deter(d(d1),1,sg) -->[my].





