import java.util.ArrayList;

/**
 * Employee
 */
public class Employee {
    // attribute
    private int current; // current choice of the pref array
    // constructor
    public Employee() {
        super();
        current = 0;
    }
    public Employee(String name, ArrayList<String> pref) {
        super(name, pref);
        current = 0;
    }
    // method
    /*
     * return the name of the current choice of the student and increment the current
     */
    public String findCurrent() {
        return pref[current++];
    }
}