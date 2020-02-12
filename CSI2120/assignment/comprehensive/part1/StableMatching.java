import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

/**
 * StableMatching
 */
public class StableMatching {
    public static void main(String[] args) {
        // get the n from the file name
        int n;
        for (int i = 0; i < args[0].length(); ++i) {
            if (Character.isDigit(args[0].charAt(i))) {
                n = args[0].charAt(i) - '0';
                break;
            }
        }
        // read files
        try {
            // read the employer preference list
            File employerPref = new File(args[0]);
            Scanner empScanner = new Scanner(employerPref);
            // read the student preference list
            File studentPref = new File(args[1]);
            Scanner studScanner = new Scanner(studentPref);
        } catch (FileNotFoundException e) {
            System.out.println("File not found.");
            e.printStackTrace();
        }
    }
}