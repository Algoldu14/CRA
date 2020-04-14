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

en_test1:-  sentence(X,[the, man, eats, an, apple],[]), draw(X).
en_test2:-  sentence(X,[they, eat, apples],[]),draw(X).
en_test3:-  sentence(X,[you, eat, a, red, apple],[]),draw(X).
en_test4:-  sentence(X,[john, loves, mary],[]),draw(X).
en_test5:-  sentence(X,[the, big, cat, eats, a, grey, mouse],[]), draw(X).
en_test6:-  sentence(X,[john, studies, at, the, university],[]),draw(X).
en_test7:-  sentence(X,[the, student, loves, the, university],[]),draw(X).
en_test8:-  sentence(X,[the, cat, eats, mice],[]),draw(X).
en_test9:-  sentence(X,[the, mouse, that, the, cat, caught, was, grey],[]),draw(X).
en_test10:- sentence(X,[the, university, is, big],[]),draw(X).
en_test11:- sentence(X,[the, dog, chased, a, black, cat, in, the, garden],[]),draw(X).
en_test12:- sentence(X,[the, man, that, we, saw, yesterday, is, my, neighbour],[]),draw(X).
en_test13:- sentence(X,[the, yellow, canary, sings, very, well],[]),draw(X).
en_test14:- sentence(X,[john, drinks, a, coffee, and, reads, the, newspaper],[]),draw(X).
en_test15:- sentence(X,[john, is, skinny, and, mary, is, tall],[]),draw(X).
en_test16:- sentence(X,[oscar, wilde, wrote, the, phantom, of, canterville],[]),draw(X).

traduccion1:-oracion(X,[el,hombre,come,una,manzana],[]),sentence(X,Traducida,[]),write(Traducida).
traduccion2:-oracion(X,[ellos, comen, manzanas],[]),sentence(X,Traducida,[]),write(Traducida).
traduccion3:-oracion(X,[tu, comes, una, manzana, roja],[]),sentence(X,Traducida,[]),write(Traducida).
traduccion4:-oracion(X,[juan, ama, a, maria],[]),sentence(X,Traducida,[]),write(Traducida).
traduccion5:-oracion(X,[el, gato, grande, come, un, raton, gris],[]),sentence(X,Traducida,[]),write(Traducida).
traduccion6:-oracion(X,[juan, estudia, en, la, universidad],[]),sentence(X,Traducida,[]),write(Traducida).
traduccion7:-oracion(X,[el, alumno, ama, la, universidad],[]),sentence(X,Traducida,[]),write(Traducida).
traduccion8:-oracion(X,[el, gato, come, ratones],[]),sentence(X,Traducida,[]),write(Traducida).
traduccion9:-oracion(X,[el, raton, que, cazo, el, gato, era, gris],[]),sentence(X,Traducida,[]),write(Traducida).
traduccion10:-oracion(X,[la, universidad, es, grande],[]),sentence(X,Traducida,[]),write(Traducida).
traduccion11:-oracion(X,[el, perro, persiguio, un, gato, negro, en, el, jardin],[]),sentence(X,Traducida,[]),write(Traducida).
traduccion12:-oracion(X,[el, hombre, que, vimos, ayer, es, mi, vecino],[]),sentence(X,Traducida,[]),write(Traducida).
traduccion13:-oracion(X,[el, canario, amarillo, canta, muy, bien],[]),sentence(X,Traducida,[]),write(Traducida).
traduccion14:-oracion(X,[juan, toma, un, cafe, y, lee, el, periodico],[]),sentence(X,Traducida,[]),write(Traducida).
