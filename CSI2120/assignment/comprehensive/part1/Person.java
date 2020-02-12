/**
 * Person
 */
public class Person {
    // attribute
    private String name;
    protected String[] pref;
    protected int match; // the index of pref
    // constructor
    public Person(String name, int n) {
        this.name = name;
        this.pref = new String[n];
        this.match = -1;
    }
    public Person(String name, String[] pref) {
        this.name = name;
        this.pref = pref;
        this.match = -1;
    }
    // method
    public String getName() {
        return name;
    }
    /*
     * method for test purpose
     */
    public void printPref() {
        for (String str : pref) {
            System.out.print(str + " ");
        }
        System.out.println();
    }
    /*
     * return the name of the matched one
     * return null if this person is not matched
     */
    public String getMatch() {
        return (match == -1) ? null : pref[match];
    }
    /*
     * change the match to the person with the name
     * if name is null, just change this person to be unmacthed
     */
    public void changeMatch(String name) {
        if (name == null) {
            match = -1;
        } else {
            for (int i = 0; i < pref.length; ++i) {
                if (pref[i].equals(name)) {
                    match = i;
                    break;
                }
            }
        }
    }
}