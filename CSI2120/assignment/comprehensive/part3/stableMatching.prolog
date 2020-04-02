% input handler %
read_file(File, Res) :-
  open(File, read, InStream),
  read_stream(InStream, Res).

read_stream(InStream, []) :-
  at_end_of_stream(InStream), !.
read_stream(InStream, [List|L]) :-
  \+at_end_of_stream(InStream),
  read_line_to_string(InStream, Str),
  split_string(Str, ",", "", List),
  read_stream(InStream, L).

% output handler %
output_file_name(Len, FileName) :-
  number_string(Len, LenStr),
  string_concat("matches_prolog_", LenStr, Str1),
  string_concat(Str1, "x", Str2),
  string_concat(Str2, LenStr, Str3),
  string_concat(Str3, ".csv", FileName).

write_match([], _).
write_match([M|Match], Out) :-
  write(Out, M),
  write(Out, "\n"),
  write_match(Match, Out).

write_csv(Match) :-
  length(Match, Len),
  output_file_name(Len, FileName),
  open(FileName, write, Out),
  write_match(Match, Out),
  close(Out).

% assistant function %
get_employers([], []).
get_employers([[E|_]|L_employer_preference], [E|Employers]) :-
  get_employers(L_employer_preference, Employers).

add_student([]).
add_student([[S|_]|L_student_preference]) :-
  assert(student(S)),
  add_student(L_student_preference).

gen_match([], []).
gen_match([E|Employers], [E-S|Match]) :-
  student(S),
  gen_match(Employers, Match).

remove_duplicate([]).
remove_duplicate([_-S|Match]) :-
  pairs_values(Match, Values),
  \+member(S, Values),
  remove_duplicate(Match).

% main function %
% stableMatching(L_employer_preference, L_student_preference, Match).


findStableMatch(EmployerFile, StudentFile) :-
  read_file(EmployerFile, L_employer_preference), 
  read_file(StudentFile, L_student_preference),
  get_employers(L_employer_preference, Employers),
  add_student(L_student_preference),
  gen_match(Employers, Match),
  remove_duplicate(Match),
  writeln(Match). % test 