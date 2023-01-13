let rec for_down (n:int) (f:int->unit) : unit =
    if n >= 0 then
        (f n; for_down (n-1) f)
    else
        ()

let count_down (n:int) =
    for_down n (fun i -> 
        print_int i;
        print_newline()
    )