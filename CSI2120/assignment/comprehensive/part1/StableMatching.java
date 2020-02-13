import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Queue;
import java.util.Scanner;

/**
 * StableMatching
 * Hongyi Lin, 300053082
 */
public class StableMatching {
    public static void main(String[] args) {
        // size of the problem
        int n = -1;
        // Array to store employers
        ArrayList<Employer> employers = new ArrayList<>();
        // queue to hold unmatched employers
        Queue<Employer> unmatchedEmp = new LinkedList<>();
        // HashMap to hold employers
        HashMap<String, Employer> eHashMap = new HashMap<>();
        // HashMap to hold students
        HashMap<String, Student> sHashMap = new HashMap<>();
        // read files
        try {
            // read the employer preference list
            File employerPref = new File(args[0]);
            Scanner empScanner = new Scanner(employerPref);
            while (empScanner.hasNext()) {
                String[] info = empScanner.nextLine().split(",");
                // initialize the size n
                if (n == -1) {
                    n = info.length - 1;
                }
                Employer e = new Employer(info[0], Arrays.copyOfRange(info, 1, info.length));
                employers.add(e);
                unmatchedEmp.add(e);
                eHashMap.put(info[0], e);
            }
            empScanner.close();
            // read the student preference list
            File studentPref = new File(args[1]);
            Scanner studScanner = new Scanner(studentPref);
            while (studScanner.hasNext()) {
                String[] info = studScanner.nextLine().split(",");
                Student s = new Student(info[0], Arrays.copyOfRange(info, 1, info.length));
                sHashMap.put(info[0], s);
            }
            studScanner.close();
        } catch (FileNotFoundException e) {
            System.out.println("File Not Found.");
            e.printStackTrace();
        }
        // Gale-Shapley algorithm
        while (!unmatchedEmp.isEmpty()) {
            Employer curEmployer = unmatchedEmp.poll();
            Student curStudent = sHashMap.get(curEmployer.getCurrent()); // getCurrent has increased the index
            if (curStudent.getMatch() == null) {
                curStudent.changeMatch(curEmployer.getName());
                curEmployer.changeMatch(curStudent.getName());
            } else {
                if (curStudent.prefer(curEmployer.getName())) {
                    // set the current employer to be unmatched, and add to the queue
                    Employer prevEmployer = eHashMap.get(curStudent.getMatch());
                    prevEmployer.changeMatch(null);
                    unmatchedEmp.add(prevEmployer);
                    // change the matches
                    curStudent.changeMatch(curEmployer.getName());
                    curEmployer.changeMatch(curStudent.getName());
                } else {
                    unmatchedEmp.add(curEmployer);
                }
            }
        }
        // write results to .csv file
        String fileName = "matches_java_" + n + "x" + n + ".csv";
        try {
            BufferedWriter bWriter = new BufferedWriter(new FileWriter(fileName));
            for (int i = 0; i < employers.size(); ++i) {
                Employer e = employers.get(i);
                if (i > 0) {
                    bWriter.write("\n");
                }
                bWriter.write(e.getName() + "," + e.getMatch());
            }
            bWriter.close();
        } catch (IOException e) {
            System.out.println("Output Exception");
            e.printStackTrace();
        }
    }
}