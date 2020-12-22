/**
 * Student 
 * Hongyi Lin, 300053082
 */
public class Student extends Person {
    // constructor
    public Student(String name, int n) {
        super(name, n);
    }
    public Student(String name, String[] pref) {
        super(name, pref);
    }
    // method
    /*
     * return true if this student prefer the new employer with the name other than the current
     */
    public boolean prefer(String other) {
        int index = -1;
        for (int i = 0; i < pref.length; ++i) {
            if (pref[i].equals(other)) {
                index = i;
            }
        }
        return index < match;
    }
}