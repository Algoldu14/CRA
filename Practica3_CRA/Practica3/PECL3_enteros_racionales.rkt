#lang racket

; Booleanos. Son los únicos lambda términos no currificados.

(define true (lambda (x y) x))

(define false (lambda (x y) y))

(define neg (lambda (x) (x false true)))
                         
(define and (lambda (x y) (x y false)))

(define or (lambda (x y) (x true y)))

; Pares ordenados
              
(define par (lambda (x)
              (lambda (y)
                (lambda (f) (f x y)))))

(define primero (lambda (p)
                  (p true)))

(define segundo (lambda (p) (p false)))

;;;;; Combinador de punto fijo

(define Y
  (lambda (f)
    ((lambda (x) (f (lambda (v) ((x x) v))))
     (lambda (x) (f (lambda (v) ((x x) v)))))))

;;;;;; Orden en naturales y test de nulidad

(define esmenoroigualnat (lambda (n)
                             (lambda (m)
                                (escero ((restanat n) m)))))
                         
(define esmayoroigualnat (lambda (n)
                            (lambda (m)
                               (escero ((restanat m) n)))))
                         
(define esmenornat (lambda (n)
                     (lambda (m)
                       (and ((esmenoroigualnat n) m) (noescero ((restanat m) n))))))

(define esmayornat (lambda (n)
                     (lambda (m)
                       (and ((esmayoroigualnat n) m) (noescero ((restanat n) m))))))

(define esigualnat (lambda (n)
                     (lambda (m)
                       (and ((esmayoroigualnat n) m) ((esmenoroigualnat n) m)))))

(define escero (lambda (n)
                 ((n (lambda (x) false)) true)))

(define noescero (lambda (n)
                    (neg (escero n))))

; Aritmética natural. Se define también "comprobar" para poder hacer pruebas. Se definen algunos naturales para hacer comprobaciones. Se escriben en francés para distinguirlos de los enteros 
; que se escribirán en español.

(define zero (lambda (f)
               (lambda (x) x)))

(define sucesor (lambda (n)
                  (lambda (f)
                    (lambda (x)
                     (f((n f) x))))))

(define one (sucesor zero))

(define two (sucesor one))

(define three (sucesor two))

(define four (sucesor three))

(define five (sucesor four))

(define six (sucesor five))

(define seven (sucesor six))

(define eight (sucesor seven))

(define nine (sucesor eight))

(define ten (sucesor nine))

(define eleven (sucesor ten))

(define twelve (sucesor eleven))

(define thirteen (sucesor twelve))

(define fourteen (sucesor thirteen))

(define fifteen (sucesor fourteen))

(define sixteen (sucesor fifteen))

(define seventeen (sucesor sixteen))

(define eightteen (sucesor seventeen))

(define nineteen (sucesor eightteen))

(define twenty (sucesor nineteen))

;; Comprobar

(define comprobar (lambda (n)
                    ((n (lambda (x) (+ 1 x))) 0)))

;; Suma naturales

(define sumnat (lambda (n)
                 (lambda (m)
                   ((n (lambda (x) (sucesor x))) m))))

;; Producto naturales

(define prodnat (lambda (n)
                   (lambda (m)
                     (lambda (f)
                       (lambda (x) ((m (n f)) x))))))
                     
(define prefn (lambda (f)
                (lambda (p)
                  ((par (f (primero p))) (primero p)))))

;; Predecesor y resta 

(define predecesor (lambda (n)
                     (lambda (f)
                       (lambda (x)
                            (segundo ((n ((lambda (g)
                                             (lambda (p) ((prefn g) p))) f)) ((par x) x)))))))
                         
(define restanat (lambda (n)
                     (lambda (m)
                        ((m (lambda (x) (predecesor x))) n))))                                                 

;; Resto de la división euclídea. Si el divisor es cero, devuelve false.

(define restonataux
    (lambda (n)
        (lambda (m)
            ((Y (lambda (f)
                 (lambda (x)
                    ((((esmayoroigualnat x) m)  
                        (lambda (no_use)
                            (f ((restanat x) m))
                        )
                        (lambda (no_use)
                            x
                        )
                    )
                        zero)    ; Pasa zero como argumento de no_use
                )
            ))
                n)  ; Pasa n como el valor inicial de x.
        )
))

(define restonat (lambda (n)
                      (lambda (m)
                        (((escero m) (lambda (no_use) false) (lambda (no_use) ((restonataux n) m))) zero))))

;; Cociente de la división euclídea. Al igual que el resto, devuelve false si se divide por cero.

(define cocientenataux
    (lambda (n)
        (lambda (m)
            ((Y (lambda (f)
                (lambda (x)
                    ((((esmayoroigualnat x) m)  
                        (lambda (no_use)
                            (sucesor (f ((restanat x) m)))  
                        )
                        (lambda (no_use)
                            zero
                        )
                    )
                        zero)    ; Pasa zero como argumento de no_use
                )
            ))
                n)  ; Pasa n como el valor inicial de x.
        )
    )
)

(define cocientenat (lambda (n)
                      (lambda (m)
                        (((escero m) (lambda (no_use) false) (lambda (no_use) ((cocientenataux n) m))) zero))))

;; Máximo común denominador.

(define mcdnat
    (lambda (n)
        (lambda (m)
            (((Y (lambda (f)
                   (lambda (x)
                     (lambda(y)
                      (((escero y)  
                       (lambda (no_use)
                            x
                        ) 
                       (lambda (no_use)
                            ((f y)((restonat x) y)) 
                        )
                        
                    )
                        zero)    ; Pasa zero como argumento de no_use
                ))
            ))
                n) ; Pasa n como el valor inicial de x.
          m)       ; Pasa m como el valor inicial de y.
    )
))

;;;; Paridad

(define par? (lambda (n)
               (escero ((restonat n) two))))

(define cuadrado (lambda (n)
                   ((prodnat n) n)))


;;;;; Potencias de naturales usando algo binario.

(define potencianat
    (lambda (n)
        (lambda (m)
            ((Y (lambda (f)
                (lambda (y)
                    (((escero y)
                        (lambda (no_use)
                            one
                        )
                        (lambda (no_use)
                          (((par? y)
                           (lambda (no_use1)
                             (cuadrado (f ((cocientenat y) two))))
                           (lambda (no_use1)
                             ((prodnat n) (f (predecesor y))))) zero)
                        )
                    )
                        zero)    ; Pasa zero como argumento de no_use
                )
            ))
                m)  ; Pasa n como el valor inicial de x.
        )
    )
)

;;;;;; Definición de algunos enteros. Se codifican los enteros mediante pares de naturales: el par (m,n) es una representación de m-n. Es obvio que varios
;;;;;; pares codifican el mismo entero. Por ejemplo, (7,5)=(9,7). Por lo tanto, los enteros se definen como el conjunto cociente de NxN mediante la relación 
;;;;;; de equivalencia R dada por
;;;;;;
;;;;;;                     (m,n) R (m',n') si y solo si m-n=m'-n'

(define cero ((par zero) zero))

(define -uno ((par zero) one))

(define -dos ((par zero) two))

(define -tres ((par zero) three))

(define -cuatro ((par zero) four))

(define -cinco ((par zero) five))

(define -seis ((par zero) six))

(define -siete ((par zero) seven))

(define -ocho ((par zero) eight))

(define -nueve ((par zero) nine))

(define -diez ((par zero) ten))

(define -once ((par zero) eleven))

(define -doce ((par zero) twelve))

(define -trece ((par zero) thirteen))

(define -catorce ((par zero) fourteen))

(define -quince ((par zero) fifteen))

(define -dieciseis ((par zero) sixteen))

(define -diecisiete ((par zero) seventeen))

(define -dieciocho ((par zero) eightteen))

(define -diecinueve ((par zero) nineteen))

(define -veinte ((par zero) twenty))

(define uno ((par one) zero))

(define dos ((par two) zero))

(define tres ((par three) zero))

(define cuatro ((par four) zero))

(define cinco ((par five) zero))

(define seis ((par six) zero))

(define siete ((par seven) zero))

(define ocho ((par eight) zero))

(define nueve ((par nine) zero))

(define diez ((par ten) zero))

(define once ((par eleven) zero))

(define doce ((par twelve) zero))

(define trece ((par thirteen) zero))

(define catorce ((par fourteen) zero))

(define quince ((par fifteen) zero))

(define dieciseis ((par sixteen) zero))

(define diecisiete ((par seventeen) zero))

(define dieciocho ((par eightteen) zero))

(define diecinueve ((par nineteen) zero))

(define veinte ((par twenty) zero))

;;;;; Orden, valor absoluto y tests de nulidad, positividad y negatividad. 
;;;
;;; m-n > m'-n' si y solo si m+n' > m'+n e igual con el resto

(define esmayoroigualent (lambda (r)
                           (lambda (s)
                             ((esmayoroigualnat ((sumnat (primero r)) (segundo s))) ((sumnat (primero s)) (segundo r)))))) 

(define esmenoroigualent (lambda (r)
                           (lambda (s)
                             ((esmenoroigualnat ((sumnat (primero r)) (segundo s))) ((sumnat (primero s)) (segundo r))))))

(define esmayorent (lambda (r)
                           (lambda (s)
                             ((esmayornat ((sumnat (primero r)) (segundo s))) ((sumnat (primero s)) (segundo r))))))

(define esmenorent (lambda (r)
                           (lambda (s)
                             ((esmenornat ((sumnat (primero r)) (segundo s))) ((sumnat (primero s)) (segundo r))))))

(define esigualent (lambda (r)
                           (lambda (s)
                             ((esigualnat ((sumnat (primero r)) (segundo s))) ((sumnat (primero s)) (segundo r))))))

(define absoluto (lambda (r)
                    (((esmayoroigualnat (primero r)) (segundo r)) ((par ((restanat (primero r)) (segundo r))) zero) ((par ((restanat (segundo r)) (primero r))) zero))))

(define negativo (lambda (r)
                   ((esmenorent r) cero)))

(define positivo (lambda (r)
                   ((esmayorent r) cero)))

(define esceroent (lambda (r)
                     ((esigualnat (primero r)) (segundo r))))
                      
(define noesceroent (lambda (r)
                       (neg (esceroent r))))

;;;;; Reducción a representante canónico de la clase de equivalencia.

(define reducir (lambda (r)
                  (((esmayoroigualnat (primero r)) (segundo r)) 
                        ((par ((restanat (primero r)) (segundo r))) zero)
                        ((par zero) ((restanat (segundo r)) (primero r))))))

;;;;; Aritmética entera. La respuesta está siempre dada por el representante canónico de la clase de equivalencia. 

(define testenteros (lambda (r)
                      (- (comprobar (primero r)) (comprobar (segundo r)))))

(define sument (lambda (r)
                  (lambda (s)
                    (reducir ((par ((sumnat (primero r)) (primero s))) ((sumnat (segundo r)) (segundo s)))))))

(define prodent (lambda (r)
                  (lambda (s)
                    (reducir ((par ((sumnat ((prodnat (primero r)) (primero s))) ((prodnat (segundo r)) (segundo s))))
                          ((sumnat ((prodnat (primero r)) (segundo s))) ((prodnat (segundo r)) (primero s))))))))                       

(define restaent (lambda (r)
                   (lambda (s)
                     (reducir ((par ((sumnat (primero r)) (segundo s))) ((sumnat (segundo r)) (primero s)))))))

(define opuesto (lambda (r)
                  ((par (segundo r)) (primero r))))

;; Lo siguiente reduce la división de enteros a división de naturales. Si m mayor o igual que 0 y n > 0, y si q y r son cociente y resto de la división de m entre n, se tiene
;;  m  = q       * n        + r
;;  m  = (-q)    * (-n)     + r
;; -m  = (-(q+1))* n        + (n-r)
;; -m  = (q+1)   * (-n)     + (n-r),
;; siempre y cuando el resto no sea cero. Cuando el divisor es cero, la función cocienteent devuelve false.

(define cocienteent_aux (lambda (r)
                          (lambda (s)
                            ((cocientenat (primero (absoluto r))) (primero (absoluto s))))))

; Caso1: resto cero. Si m= q*n, entonces -m= (-q)*n, -m = q* (-n) y m= (-q)*(-n).

(define cocienteentaux-caso1 (lambda (r)
                               (lambda (s)
                                  ((or (and ((esmayoroigualent r) cero) (positivo s)) (and (negativo r) (negativo s))) ((par ((cocientenat (primero (absoluto r))) (primero (absoluto s)))) zero)
                                                                                                                       ((par zero) ((cocientenat (primero (absoluto r))) (primero (absoluto s))))))))
                              
; Caso 2: resto no nulo

(define cocienteentaux-caso2 (lambda (r)
                                (lambda (s)
                                    (((esmayoroigualent r) cero) ((positivo s) ((par ((cocienteent_aux r) s)) zero) ((par zero) ((cocienteent_aux r) s)))
                                                                 ((positivo s) ((par zero) (sucesor ((cocienteent_aux r) s))) ((par (sucesor ((cocienteent_aux r) s))) zero))))))
; Cociente cuando no hay división por cero

(define cocienteentaux (lambda (r)
                         (lambda (s)
                           ((escero ((restonat (primero (absoluto r))) (primero (absoluto s)))) ((cocienteentaux-caso1 r) s) ((cocienteentaux-caso2 r) s)))))

; Cociente considerando la división por cero

(define cocienteent (lambda (r)
                      (lambda (s)
                        (((esceroent s) (lambda (no_use) false) (lambda (no_use) ((cocienteentaux r) s))) zero))))

; Resto. Si se divide por cero, devuelve false

(define restoentaux1 (lambda (r)
                        (lambda (s)
                          ((or (and ((esmayoroigualent r) cero) (positivo s)) (and ((esmayoroigualent r) cero) (negativo s))) ((par ((restonat (primero (absoluto r))) (primero (absoluto s)))) zero)
                                                                                                           ((par ((restanat (primero (absoluto s)))((restonat (primero (absoluto r))) (primero (absoluto s))))) zero)))))

(define restoentaux (lambda (r)
                       (lambda (s)
                          ((escero ((restonat (primero (absoluto r))) (primero (absoluto s)))) cero ((restoentaux1 r) s)))))

(define restoent (lambda (r)
                      (lambda (s)
                        (((esceroent s) (lambda (no_use) false) (lambda (no_use) ((restoentaux r) s))) zero))))

;; Como mcd (r,s)=mcd(|r|,|s|), se tiene

(define mcdent (lambda (r)
                 (lambda (s)
                   ((par ((mcdnat (primero (absoluto r))) (primero (absoluto s)))) zero))))

;; Mínimo común múltiplo

(define mcment (lambda (r)
                 (lambda (s)
                   ((cocienteent ((prodent r) s)) ((mcdent r) s)))))


; %-----------------------------------------------------------------------------%
; %                                  Práctica 3                                 %
; %-----------------------------------------------------------------------------%

;                                     NÚMEROS 
;                                    RACIONALES

;------------ comprobar si es cero
(define escero_racional (lambda (r)
                          (or
                             (esceroent (primero r))
                             (esceroent (segundo r)))
                          ))

;------------- comprobar si son iguales
(define esigual_racional (lambda (r)
                           (lambda (s)
                             ((esigualent
                               ((prodent (primero r)) (segundo s)))
                               ((prodent (segundo r)) (primero s)))
                           )))

;------------- comprobar si el primer numero es mayor
(define mayor_racional (lambda (r)
                         (lambda (s)
                            (
                             ;si los denominadores son iguales
                                 ((esigualent
                                   (segundo r))
                                   (segundo s))
                             ;entonces será mayor si el numerados es mayor
                                 ((esmayorent
                                   (primero r))
                                   (primero s))
                                  ;sino miramos si tienen igual numerador
                                  (
                                      ((esigualent
                                         (primero r))
                                         (primero s))
                                   
                                   ; entonces será mayor si el denominador es menor
                                      ((esmenorent
                                         (segundo r))
                                         (segundo s))
                                   ;sino
                                      false
                                  )
                             ) )))

;------------- comprobar si el primer numero es menor
(define menor_racional (lambda (r)
                         (lambda (s)
                            (
                             ;si los denominadores son iguales
                                 ((esigualent
                                   (segundo r))
                                   (segundo s))
                             ;entonces será menor si el numerados es menor
                                 ((esmenorent
                                   (primero r))
                                   (primero s))
                                  ;sino miramos si tienen igual numerador
                                  (
                                      ((esigualent
                                         (primero r))
                                         (primero s))
                                   
                                   ; entonces será menor si el denominador es mayor
                                      ((esmayorent
                                         (segundo r))
                                         (segundo s))
                                   ;sino
                                      false
                                  )
                             ) )))
;------------- es mayor o igual
(define esigual_racional2 (lambda (r)
                           (lambda (s)
                             ((esigualent
                               ((prodent (primero r)) (segundo s)))
                               ((prodent (segundo r)) (primero s)))
                           )))

;------------- comprobar si el primer numero es mayor o igual
(define mayoroigual_racional (lambda (r)
                         (lambda (s)
                            (
                              ((esigual_racional r) s)
                              true
                              ((mayor_racional r)s)
                             ))))

;-------------- comprobar si el primer numero es menor o igual
(define menoroigual_racional (lambda (r)
                         (lambda (s)
                            (
                              ((esigual_racional r) s)
                              true
                              ((menor_racional r)s)
                             ))))

;------------- mostrar resultado numeros racionales
(define test_racionales (lambda (r)
                          (list
                             (testenteros (primero r))
                             (testenteros (segundo r))
                           )))

;------------- reducción a representante canónico
; Para obtener el representante canónico se debe dividir el
; numerador y denominador entre el m.c.d de ambos.
(define reducir_racional (lambda (r)
                           ((par
                          ((cocienteentaux
                                   (primero r))
                                   ((mcdent
                                            (primero r))
                                             (segundo r))))
                             ((cocienteentaux
                                   (segundo r))
                                   ((mcdent
                                            (primero r))
                                             (segundo r))))
                           
                          ))
                           
;------------- suma de racionales
; si tienen igual denominador --> se suman numeradores y se reduce
; sino, se calcula el mcm de los denominadores
;       se multiplica numerador y denominador por mcm
;       se suman numeradores y se reduce al representante canonico
                       
(define suma_racionales (lambda (r)
                          (lambda (s)
                            (
                             ; si tienen igual denominador
                               ((esigualent
                                (segundo r))
                                (segundo s))
                               ;entonces sumamos los numeradores
                               (reducir_racional
                                ((par 
                                 ((sument (primero r)) (primero s)))
                                 (segundo r)))
                               ;sino
                                (reducir_racional
                                ((par 
                                 ((sument (primero ((sumaaux_racionales r)s))) (primero ((sumaaux_racionales s)r))))
                                 ((mcment (segundo r)) (segundo s))))
                             ))))

(define sumaaux_racionales (lambda (r)
                             (lambda (s)
                               ; multiplicamos cada uno de los sumandos
                               ; para que tengan igual denominador
                               ; de la forma mcm(r,s)/denominador
                               ((par 
                               ((prodent
                                     ((cocienteent
                                           ((mcment (segundo r)) (segundo s)))
                                           (segundo r)))
                                     (primero r)))

                                ((prodent
                                     ((cocienteent
                                           ((mcment (segundo r)) (segundo s)))
                                           (segundo r)))
                                     (segundo r)))
                               )))


;------------- resta de racionales
; si tienen igual denominador --> se restan numeradores y se reduce
; sino, se calcula el mcm de los denominadores
;       se multiplica numerador y denominador por mcm
;       se restan numeradores y se reduce al representante canonico

(define resta_racionales (lambda (r)
                          (lambda (s)
                            (
                             ; si tienen igual denominador
                               ((esigualent
                                (segundo r))
                                (segundo s))
                               ;entonces sumamos los numeradores
                               (reducir_racional
                                ((par 
                                 ((restaent (primero r)) (primero s)))
                                 (segundo r)))
                               ;sino
                                (reducir_racional
                                ((par 
                                 ((restaent
                                      (primero ((restaaux_racionales r)s)))
                                      (primero ((restaaux_racionales s)r))))
                                 ((mcment (segundo r)) (segundo s))))
                             ))))

(define restaaux_racionales (lambda (r)
                             (lambda (s)
                               ; multiplicamos cada uno de los sumandos
                               ; para que tengan igual denominador
                               ; de la forma mcm(r,s)/denominador
                              
                                ((par 
                                  ((prodent
                                     ((cocienteent
                                           ((mcment (segundo r)) (segundo s)))
                                           (segundo r)))
                                     (primero r)))

                                 ((prodent
                                     ((cocienteent
                                           ((mcment (segundo r)) (segundo s)))
                                           (segundo r)))
                                     (segundo r))))
                               ))

;------------- producto de racionales
; únicamente hay que multiplicar los numeradores y denominadores
(define prod_racionales (lambda (r)
                          (lambda (s)
                            (reducir_racional
                              ((par
                                ((prodent (primero r)) (primero s)))
                                ((prodent (segundo r)) (segundo s)))))))

;------------- división de dos matrices
; la división consiste en realizar una multiplicación en cruz
(define div_racionales (lambda (r)
                         (lambda (s)
                           ((prod_racionales r) (inverso_racionales s)))))

;------------- inverso de racionales
;cambiar numerador por denominador
(define inverso_racionales (lambda (r)
                             (reducir_racional ((par (segundo r)) (primero r)))))

;------------- opuesto de racionales
(define opuesto_racionales (lambda (r)
                            (reducir_racional
                             ((par
                               (opuesto (primero r)))
                               (segundo r)))
                             ))


;------------------------------------------------------------------------------------
;                                      MATRICES
;                                    CON NUMEROS
;                                     RACIONALES
;------------------------------------------------------------------------------------

;------------- Matriz 2x2
(define definir_matriz (lambda (a)
                         (lambda (b)
                           (lambda (c)
                             (lambda (d)
                               ((par ((par a) b)) ((par c) d)))))))


;------------- Representación de matrices
(define test_matriz (lambda (m)
                        (list
                             (list
                                   (test_racionales (primero (primero m)))
                                   (test_racionales (segundo (primero m))))
                             (list
                                   (test_racionales (primero (segundo m)))
                                   (test_racionales (segundo (segundo m))))
                        )))

;------------- Matriz identidad
(define identidad
       ((((definir_matriz
            ((par uno) uno)) ((par cero) uno))
            ((par cero) uno)) ((par uno) uno)))

;------------- Matriz nula
(define matriz_nula
       ((((definir_matriz
            ((par cero) uno)) ((par cero) uno))
            ((par cero) uno)) ((par cero) uno)))

;------------- Matrices para las pruebas
(define matriz_prueba1
        ((((definir_matriz
             ((par dos) cuatro))  ((par cuatro) cuatro))
             ((par -uno) cuatro)) ((par cinco) cuatro)))

(define matriz_prueba2
        ((((definir_matriz
             ((par uno) cuatro))   ((par -cuatro) seis))
             ((par dos) ocho))     ((par -dos) tres)))

(define matriz_prueba3
        ((((definir_matriz
             ((par uno) dos))   ((par -cuatro) dos))
             ((par dos) dos))   ((par -tres) dos)))

(define matriz_fallo
        ((((definir_matriz
             ((par cero) cero))   ((par cero) cero))
             ((par cero) cero))   ((par cero) cero)))


;------------- Reducir una matriz
(define reducir_matrices (lambda (r)
                           ((((definir_matriz
                              (reducir_racional (primero (primero r))))
                              (reducir_racional (segundo (primero r))))
                              (reducir_racional (primero (segundo r))))
                              (reducir_racional (segundo (segundo r))))
                           ))

;------------- Suma de dos matrices
; (a b)    +   (e f) = (a+e b+f)
; (c d)        (g h)   (c+g d+h)
(define suma_matrices (lambda (r)
                       (lambda (s)
                         ((((definir_matriz
                               ((suma_racionales (primero ( primero r))) (primero (primero s))))
                               ((suma_racionales (segundo ( primero r))) (segundo (primero s))))
                               ((suma_racionales (primero ( segundo r))) (primero (segundo s))))                               
                               ((suma_racionales (segundo ( segundo r))) (segundo (segundo s))))
                          )))

;------------- Resta de dos matrices
; (a b)    _   (e f) = (a-e b-f)
; (c d)        (g h)   (c-g d-h)
(define resta_matrices (lambda (r)
                       (lambda (s)
                         ((((definir_matriz
                               ((resta_racionales (primero ( primero r))) (primero (primero s))))
                               ((resta_racionales (segundo ( primero r))) (segundo (primero s))))
                               ((resta_racionales (primero ( segundo r))) (primero (segundo s))))                               
                               ((resta_racionales (segundo ( segundo r))) (segundo (segundo s))))
                          )))

;------------- Multiplicación de dos matrices
; (a b)    x   (e f) = (ae+cf ag+ch)
; (c d)        (g h)   (be+df bg+dh)
(define prod_matrices (lambda (r)
                       (lambda (s)
                         ((((definir_matriz
                               ((suma_racionales
                                 ((prod_racionales
                                         (primero ( primero r)))
                                         (primero ( primero s))))
                                 ((prod_racionales
                                         (primero ( segundo r)))
                                         (segundo ( primero s)))))
                            
                              ((suma_racionales
                                 ((prod_racionales
                                         (segundo ( primero r)))
                                         (primero ( primero s))))
                                 ((prod_racionales
                                         (segundo ( segundo r)))
                                         (segundo ( primero s)))))

                           ((suma_racionales
                                 ((prod_racionales
                                         (primero ( primero r)))
                                         (primero ( segundo s))))
                                 ((prod_racionales
                                         (primero ( segundo r)))
                                         (segundo ( segundo s)))))
                              
                              ((suma_racionales
                                 ((prod_racionales
                                         (segundo ( primero r)))
                                         (primero ( segundo s))))
                                 ((prod_racionales
                                         (segundo ( segundo r)))
                                         (segundo ( segundo s)))))
        
                          )))

;------------- División matriz entre un número
(define div_matriz_num (lambda (r)
                         (lambda (s)
                           ((((definir_matriz
                                ((div_racionales (primero (primero r)))s))
                                ((div_racionales (segundo (primero r)))s))
                                ((div_racionales (primero (segundo r)))s))
                                ((div_racionales (segundo (segundo r)))s))
                           )))

;------------- Cuadrado de una matriz
(define cuadrado_matrices (lambda (r)
                            ((prod_matrices r)r)))

;------------ Potencia de matrices

;       |  x           si n = 1
; x^n = | (x^(n/2))^2  si n = par
;       |  x * x^(n-1) si n = impar

(define potencia_matrices (lambda (r)
                          ; Exponente
                            (lambda (e)
                               ; Llamada recursiva
                               ((Y (lambda (f)
                                   (lambda (n)
                                   (
                                    ((escero (predecesor n))
                                    ; Exponente == 1
                                         (lambda (no_use)
                                              ((escero n)
                                                identidad
                                                r))
                                    ; Exponente != 1 
                                         (lambda (no_use)
                                             (
                                              ((par? n)
                                             ; Exponente es PAR
                                             (lambda (no_use1)
                                                     (cuadrado_matrices
                                                          (f ((cocientenat n)
                                                           two))))
                                             ; Exponente es IMPAR
                                             (lambda (no_use1)
                                                    ((prod_matrices r)
                                                     (f (predecesor n))))
                                             ) zero))   
                                       ) zero))  ; El argumento no_use tiene como valor 0
                                   )) e) ; El valor inicial que toma n es e 
                                )))

;------------ Determinante de una matriz
             ; | a11    a12 |
             ; |            | = a11*a22 - a12*a21
             ; | a21    a22 |

(define determinante (lambda (r)
                              ((resta_racionales
                                  ((prod_racionales (primero (primero r))) (segundo (segundo r))))
                                  ((prod_racionales (primero (segundo r))) (segundo (primero r))))))

;------------ Rango de una matriz
; |M|  = 0 --> rango = 1
; |M| != 0 --> rango = 2

(define rango_matriz (lambda (r)
                       (((escero_racional (determinante r))
                         (lambda (no_use) uno)
                         (lambda (no_use) dos)
                        )true)
                     ))

;----------- Matriz adjunta
;;; (a b) = (d -c)
;;; (c d)   (-b a)

(define matriz_adjunta (lambda (r)
                         (reducir_matrices
                         ((((definir_matriz 
                             (segundo (segundo r)))
                              (opuesto_racionales (primero (segundo r))) )
                              (opuesto_racionales (segundo (primero r))))
                              (primero (primero r))))
                          ))

;----------- Matriz traspuesta
;;; (a  b)  =  (a  c)
;;; (c  d)     (b  d)

(define matriz_traspuesta (lambda (r)
                            (reducir_matrices
                            ((((definir_matriz
                                 (primero ( primero r)))
                                 (primero ( segundo r)))
                                 (segundo ( primero r)))
                                 (segundo ( segundo r))))
                            ))

;------------- Comprobar si la matriz admite inversa
(define inversa? (lambda (r)
                          (
                           (escero_racional (determinante r))
                           false
                           true)))

;-------------- Matriz inversa
; inversa =  (traspuesta(adjunta)) / determinante
(define inversa (lambda (r)
                        (
                          (inversa? r)
                            ; Admite inversa
                          ((div_matriz_num
                            (matriz_traspuesta (matriz_adjunta r)))
                            (determinante r))
                            ; No acepta inversión
                            matriz_fallo
                         )
                  ))
