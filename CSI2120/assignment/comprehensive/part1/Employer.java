/**
 * Employer 
 * Hongyi Lin, 300053082
 */
public class Employer extends Person {
    // attribute
    private int current; // current index of the pref array
    // constructor
    public Employer(String name, int n) {
        super(name, n);
        current = 0;
    }
    public Employer(String name, String[] pref) {
        super(name, pref);
        current = 0;
    }
    // method
    /*
     * return the name of the current choice of the student and increment the current
     */
    public String getCurrent() {
        return pref[current++];
    }
}