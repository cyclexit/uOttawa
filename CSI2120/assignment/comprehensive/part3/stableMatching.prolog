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

% main function %
% stableMatching(L_employer_preference, L_student_preference, M).

findStableMatch(EmployerFile, StudentFile) :-
  read_file(EmployerFile, L_employer_preference),
  read_file(StudentFile, L_student_preference),
  get_employers(L_employer_preference, Employers),
  add_student(L_student_preference),
  gen_match(Employers, Match),
  writeln(Match). % test
  % add facts
  % generate match and then test.
  % stableMatching(L_employer_preference, L_student_preference, M).
  % writeln(L_employer_preference), % test
  % writeln(L_student_preference). % test