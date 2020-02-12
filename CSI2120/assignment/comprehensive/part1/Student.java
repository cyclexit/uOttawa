import java.util.ArrayList;

/**
 * Student
 */
public class Student extends Person {
    // constructor
    public Student() {
        super();
    }
    public Student(String name, ArrayList<String> pref) {
        super(name, pref);
    }
    // method
    /*
     * return true if this student prefer employer1 to employer2
     */
    public boolean prefer(String employer1, String employer2) {
        // TODO: implement this function
        return true;        
    }
}