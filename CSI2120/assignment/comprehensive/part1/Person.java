import java.util.ArrayList;

/**
 * Person
 */
public class Person {
    // attribute
    private String name;
    private ArrayList<String> pref;
    // constructor
    public Person() {
        name = "";
        pref = new ArrayList<String>();
    }
    public Person(String name, ArrayList<String> pref) {
        this.name = name;
        this.pref = pref;
    }
}