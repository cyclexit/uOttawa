:- set_prolog_stack(global, limit(1 000 000 000)).

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
write_match([E-S|Match], Out) :-
  write(Out, E),
  write(Out, ","),
  write(Out, S),
  write(Out, "\n"),
  write_match(Match, Out).

write_csv(Match) :-
  length(Match, Len),
  output_file_name(Len, FileName),
  open(FileName, append, Out),
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

gen_match([], Temp, Temp).
gen_match([E|Employers], Temp, Match) :-
  student(S),
  pairs_values(Temp, Values),
  \+member(S, Values),
  gen_match(Employers, [E-S|Temp], Match).

find_pref([[O|P]|_], Obj, P) :-
  O = Obj.
find_pref([[O|_]|L], Obj, Pref) :-
  O \= Obj,
  find_pref(L, Obj, Pref). 

find_matched_emp(S, [E-S|_], E).
find_matched_emp(S, [_|Match], EM) :-
  find_matched_emp(S, Match, EM).

% calculation function %
s_pref_cur(_, 0, _, _, _).
s_pref_cur([S|EPref], Cnt, E, L_student_preference ,Match) :-
  find_pref(L_student_preference, S, SPref),
  find_matched_emp(S, Match, EM),
  nth0(EIndex, SPref, E),
  nth0(EMIndex, SPref, EM),
  EMIndex < EIndex,
  Cnt1 is Cnt - 1,
  s_pref_cur(EPref, Cnt1, E, L_student_preference, Match).

solve(_, _, _, []).
solve(L_employer_preference, L_student_preference, Match, [E-S|MatchList]) :-
  find_pref(L_employer_preference, E, EPref),
  nth0(Cnt, EPref, S),
  s_pref_cur(EPref, Cnt, E, L_student_preference, Match),
  solve(L_employer_preference, L_student_preference, Match, MatchList).

% main function %
stableMatching(L_employer_preference, L_student_preference, Match) :-
  solve(L_employer_preference, L_student_preference, Match, Match).

findStableMatch(EmployerFile, StudentFile) :-
  read_file(EmployerFile, L_employer_preference), 
  read_file(StudentFile, L_student_preference),
  get_employers(L_employer_preference, Employers),
  add_student(L_student_preference),
  gen_match(Employers, [], Match),
  stableMatching(L_employer_preference, L_student_preference, Match),
  write_csv(Match).
  % writeln(Match). % test 