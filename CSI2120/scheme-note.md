# Scheme Note

## Index
* [Keyword](#Keyword)
* [Numerical](#Numerical)
* [List](#List)
* [Recursive Function](#Recursive-Function)

## Keyword
* `(load "file_name")`: load a file into scheme environment.
* `(values v1, v2, ...)`: used to return multiple values.
* `(define <name> <value>)`: used to define a global constant.
* `(let ((x1 1) (x2 2) ...) (<procedure>))`: define local variable.
* `quote` or `'`: ensure the expression is not evaluated by the scheme.
* `?`: indicate a boolean function returning `#t` or `#f`.
    * `(eq? x y)`: return true if *x* and *y* have the same address. </br>
      `(eqv? x y)`: ONLY used for characters and numbers.
      `(equal? x y)`: return true if *x* and *y* have the same structure and content. </br>
      e.g. `(equal? '(1 1) '(1 1))` is `#t`, `(eq? '(1 1) '(1 1))` is `#f`.
    * `(null? x)`: return true if *x* is an empty list.
    * `(pair? x)`: return true if *x* is a list of pair.
    * `(procedure? x)`: return true if *x* is a function.
    * `(list? x)`: return true uf *x* is a list.
* `cond`: this keyword is similar to `if` but more than two branches can be specified. </br>
  `(else (...))` or `(#t (...))`: can be used in the `cond` branch.
  If there are no branches evaluated to be `#t`, then `nil` is returned.

## Numerical
* `(odd x)` </br>
  `(even x)`
* `(abs x)` 
* `(max x1 x2)` </br>
  `(min x1 x2)`
* `(+ x1 x2)` </br>
  `(- x1 x2)` </br>
  `(* x1 x2)` </br>
  `(/ x1 x2)` </br>
  `(quotient x1 x2)` </br>
  `(modulo x1 x2)`
* `(sqrt x)` </br>
* `(sin x)` </br>
  `(asin x)` </br>
  `(cos x)` </br>
  `(acos x)` </br>
  `(tan x)` </br>
  `(atan x)`
* `<= x1 y x2`: this is evaluated to `x1 <= y <= x2`.

## List
* `(cons 'x1 'x2)`: connect *x1* and *x2* into a list.
* `(car 'x)`: ONLY return the first element in *x*. </br>
  `(cdr 'x)`: return everything in *x* EXCEPT FOR the first element. </br>
  `car` and `cdr` can be combined to use, e.g., `cdadr`.
* append-list function
  ```scheme
  (define (append-list l1 l2)
    (if (null? l1) 
        l2
        (cons (car l1) (append-list (cdr l1) l2))
    )
  )
  ```
* invert-list function
  ```scheme
  (define (invert-list l)
    (if (null? l)
      '()
      (append-list (invert-list (cdr l)) (list (car l)))
    )
  )
  ```
* member-list function
  ```scheme
  (define (member-list a L)
    (cond 
      ((null? L) `())
      ((equal? a (car L)) L)
      (else (member-list a (cdr L)))
    )
  )
  ```
* sum-list function
  ```scheme
  (define (sum-list l)
    (if (null? l)
      0
      (+ (car l) (sum-list (cdr l)))
    )
  )
  ```
* len-list function
  ```scheme
  (define (len-list l)
    (if (null? l)
      0
      (+ 1 (len-list (cdr l)))
    )
  )
  ```

## Recursive Function
```scheme
(define <Name>
 (lambda (<Params>)
  (if (<Base Predicate>)
    <Base Case Body>
    (<Operation> (<Name> <Modified Parameters>))))
```