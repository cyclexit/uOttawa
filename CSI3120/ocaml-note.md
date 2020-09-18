# OCaml Note

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

## Type Cast
function form: A_of_B </br>
Example: string_of_int, float_of_int

# Arithemetic
`+`, `-`, `*`, `/`: integer operator
`+.`, `-.`, `*.`, `/.`: float operator

## Comparison
`=` is structural equality and `==` is physical equality. Beware: `<>` is structural not-equals while `!=` is physical not-equals.