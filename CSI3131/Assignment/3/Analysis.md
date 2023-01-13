## TA States
1. helping some students
2. sleeping

State Transition:
* If hallway is not empty, state 1.
* If hallway is empty, state 2.
* Notified by a student, from state 2 to state 1.

## Student States
1. programming
2. got help from TA
3. waiting in the hallway

State Transition:
* If TA is busy
    * If hallway has chairs, state 3.
    * If hallway is full, state 1.
* If TA is not busy, state 2 (Probably need to wake up TA first).

## Design
1. `hallway`: an array (queue form)? or just a counter? or a semaphore?
    * The size or the maximum value should be less than **n**!
2. Need a semaphore to notify the TA.
3. Randomize the number of times the student need to get help from TA.
