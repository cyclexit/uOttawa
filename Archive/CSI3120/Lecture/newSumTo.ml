let rec sumTo (n:int) : int = 
    match n with
        0 -> 0
        | n -> n + sumTo (n-1)

let _ = 
    let x = read_int ()
    in
        print_int (sumTo x);
        print_newline()