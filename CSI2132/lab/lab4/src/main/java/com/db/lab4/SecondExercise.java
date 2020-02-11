package com.db.lab4;

import java.sql.*;

/**
 * SecondExercise
 */
public class SecondExercise {
    public static void main(String[] args) throws SQLException {
        Connection db = DriverManager.getConnection("jdbc:postgresql://web0.site.uottawa.ca:15432/hlin087", "hlin087",
                "@Lhy19990301");
        String[] fields = { "artistname", "birthplace", "artstyle", "birthday", "country" };
        Statement st = db.createStatement();
        ResultSet res = st.executeQuery("SELECT * FROM lab2.artist WHERE artstyle IN ('Modern', 'Baroque');");
        while (res.next()) {
            for (String s : fields) {
                System.out.print(res.getString(s) + " ");
            }
            System.out.println();
        }
    }
}