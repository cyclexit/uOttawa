let rec concatn (s : string) (n : int) : string = 
    if n <= 0 then
        ""
    else
        s ^ (concatn s (n - 1))

let _ = 
    let str = read_line ()
    in
        print_string (concatn str 3);
        print_newline ()