# Scheme Note

## Index
* [Keyword](#Keyword)
* [Numerical](#Numerical)
* [Comparison](#Comparison)
* [Recursive Function](#Recursive-Function)

## Keyword
* `(load "file_name")`: load a file into scheme environment.
* `(values v1, v2, ...)`: used to return multiple values.
* `(define <name> <value>)`: used to define a global constant.
* `(let ((x1 1) (x2 2) ...) (<procedure>))`: define local variable.

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
* `sqrt x` </br>
* `sin x` </br>
  `asin x` </br>
  `cos x` </br>
  `acos x` </br>
  `tan x` </br>
  `atan x` 

## Comparison
* `= x1 x2`

## Recursive Function
```scheme
(define <Name>
 (lambda (<Params>)
  (if (<Base Predicate>)
    <Base Case Body>
    (<Operation> (<Name> <Modified Parameters>))))
```