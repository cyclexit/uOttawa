let rec sumTo (n:int) : int = 
    if n <= 0 then
        0
    else
        n + sumTo (n-1)

let _ = 
    print_int (sumTo 10);
    print_newline()