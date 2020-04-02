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
add_employer([]).
add_employer([[E|_]|Employers]) :-
  assert(employer(E)),
  add_employer(Employers).

add_student([]).
add_student([[S|_]|Students]) :-
  assert(student(S)),
  add_student(Students).

% main function %
% stableMatching(L_employer_preference, L_student_preference, M).

findStableMatch(EmployerFile, StudentFile) :-
  read_file(EmployerFile, L_employer_preference),
  read_file(StudentFile, L_student_preference),
  add_employer(L_employer_preference),
  add_student(L_student_preference).
  % add facts
  % generate match and then test.
  % stableMatching(L_employer_preference, L_student_preference, M).
  % writeln(L_employer_preference), % test
  % writeln(L_student_preference). % test