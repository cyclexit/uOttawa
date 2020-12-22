package com.db.lab4;

import java.sql.*;

public class App {
    public static void main(String[] args) throws SQLException {
        Connection db = DriverManager.getConnection("jdbc:postgresql://web0.site.uottawa.ca:15432/hlin087", "hlin087",
                "@Lhy19990301");
        // query 1
        System.out.println("query 1");
        Statement st = db.createStatement();
        ResultSet res = st.executeQuery("SELECT * FROM lab2.artist;");
        while (res.next()) {
            System.out.println("Column 1 returned: " + res.getString(1));
        }
        // query 2
        System.out.println("query 2");
        String table = "lab2.artist";
        String field = "(artistname, artstyle)";
        String condition = "artistname";
        String value = "'Caravaggio'";
        st = db.createStatement();
        res = st.executeQuery("SELECT " + field + " FROM " + table + " WHERE " + condition + " = " + value + ";");
        while (res.next()) {
            System.out.println(res.getString(1));
        }
        st.close();
        res.close();
    }
}
