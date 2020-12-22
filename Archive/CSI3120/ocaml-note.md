# OCaml Note

## List
1. Type rules:
    * `[]` may have any list type `t list`
    * if `e1:t` and `e2:t` then `(e1::e2):t list`
2. `@` operator: connect two lists

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

## Execution Time
```ml
let time f =
  let t = Sys.time () in
  let res = f () in
  Printf.printf "Execution time: %f seconds\n"
                (Sys.time () -. t);
  res
;;
```

## Object-Oriented
1. `virtual`: used to declare the class and method
2. `mutable`: make the variable insdie the class mutable
3. `val`: used to declare a variable in a class
4. `method`: used to declare a method in a class
5. `<-`: used to assign the value to a mutable variable
6. `#`: used to call the class method on an instance
7. `:>`: type coercion operator, used as `:> type`.
8. `new`: used to create a new instance
9. declare a class:
    ```ml
    type radius = float
    type point = float * float
    type side = float

    class virtual shape = object
        val mutable location : point = (0.0, 0.0)
        method get_location = location
        method set_location (x:float) (y:float) : unit =
            location <- (x, y)
        method virtual area : float
    end

    class circle = object
        inherit shape as super (*inheritance*)
        val mutable rad = 1.0
        method get_radius = rad
        method set_radius (r:radius) : unit = rad <- r
        method area = pi *. rad *. rad
    end
    ```