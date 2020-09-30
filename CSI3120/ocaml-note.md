# OCaml Note

## List
1. Type rules:
    * `[]` may have any list type `t list`
    * if `e1:t` and `e2:t` then `(e1::e2):t list`

## Type Cast
function form: A_of_B </br>
Example: string_of_int, float_of_int

## Optional value
```ml
(*When the input has type t option*)
match ... with
| None -> ...
| Some s -> ...
(*When the output has type t option*)
if ... then
    None
else
    Some (...)
```

## Pattern
`_`: This matches anything. This is the "don't care" pattern.

## I/O functions
* input: `read_int`
    ```ml
    (*Take read_int as an example*)
    let x = read_int ()
    in
        ...
    ```
* output: `print_int`, `print_string`, `print_newline`

## String
concat: `^` operator

# Arithemetic
`+`, `-`, `*`, `/`: integer operator
`+.`, `-.`, `*.`, `/.`: float operator

## Comparison
`=` is structural equality and `==` is physical equality. Beware: `<>` is structural not-equals while `!=` is physical not-equals.