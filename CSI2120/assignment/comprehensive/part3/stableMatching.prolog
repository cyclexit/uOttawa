generateMatch(Employers, Students, M).

stableMatching(L_employer_preference, L_student_preference, M).

findStableMatch(EmployerFile, StudentFile) :-
  csv_read_file(EmployerFile, Employers), % this function is just like a shit
  csv_read_file(StudentFile, Students), % this function is just like a shit
  length(Employers, N), % get the number of employers and students
  generateMatch(Employers, Students, M),
  stableMatching(Employers, Students, M).