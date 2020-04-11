%-------------------------------------------------------------------------------
es_test1:-  oracion(X,[el, hombre, come, una, manzana],[]), draw(X).
es_test2:-  oracion(X,[ellos, comen, manzanas],[]),draw(X).
es_test3:-  oracion(X,[tu, comes, una, manzana, roja],[]),draw(X).
es_test4:-  oracion(X,[juan, ama, a, maria],[]),draw(X).
es_test5:-  oracion(X,[el, gato, grande, come, un, raton, gris],[]),draw(X).
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
