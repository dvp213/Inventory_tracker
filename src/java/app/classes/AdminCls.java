/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package app.classes;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author lakru
 */
public class AdminCls {

    public static int addAdmin(String newID, String uName, String pnum, String email, String pword) {
        int a = 0;
        try {
            Connection con = DBConector.getConnection();
            String sql = " INSERT INTO admin (Aid, username, phoneNo, email, password) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, newID);
            pstmt.setString(2, uName);
            pstmt.setString(3, pnum);
            pstmt.setString(4, email);
            pstmt.setString(5, pword);
            a = pstmt.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return a;
    }

    public static int addSup(String newID, String uName, String pnum, String email, String pword) {
        int a = 0;
        try {
            Connection con = DBConector.getConnection();
            String sql = " INSERT INTO supplier (SID, username, phoneNo, email, password) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, newID);
            pstmt.setString(2, uName);
            pstmt.setString(3, pnum);
            pstmt.setString(4, email);
            pstmt.setString(5, pword);
            pstmt.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return a;
    }

    public static int addSk(String newID, String uName, String pnum, String email, String pword) {
        int a = 0;
        try {
            Connection con = DBConector.getConnection();
            String sql = " INSERT INTO stockkeeper (SKID, username, phoneNo, email, password) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, newID);
            pstmt.setString(2, uName);
            pstmt.setString(3, pnum);
            pstmt.setString(4, email);
            pstmt.setString(5, pword);
            a = pstmt.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return a;
    }

    public static int addMkt(String newID, String uName, String pnum, String email, String pword) {
        int a = 0;
        try {
            Connection con = DBConector.getConnection();
            String sql = " INSERT INTO marketingteam (MID, username, phoneNo, email, password) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, newID);
            pstmt.setString(2, uName);
            pstmt.setString(3, pnum);
            pstmt.setString(4, email);
            pstmt.setString(5, pword);
            a = pstmt.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return a;
    }

    public static String incrementAdminID() {
        String lastItemID = null;
        try {
            Connection con = DBConector.getConnection();
            String sql = "SELECT Aid FROM admin ORDER BY Aid DESC LIMIT 1";
            PreparedStatement pstmt = con.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                lastItemID = rs.getString("Aid");
            } else {
                lastItemID = "Ad0000";
            }
            pstmt.close();
            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        String prefix = lastItemID.substring(0, 2);
        int numericPart = Integer.parseInt(lastItemID.substring(2));
        numericPart++;
        return prefix + String.format("%04d", numericPart);
    }

    public static String incrementSupID() {
        String lastItemID = null;
        try {
            Connection con = DBConector.getConnection();
            String sql = "SELECT SID FROM supplier ORDER BY SID DESC LIMIT 1";
            PreparedStatement pstmt = con.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                lastItemID = rs.getString("SID");
            } else {
                lastItemID = "sup0000";
            }
            pstmt.close();
            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        String prefix = lastItemID.substring(0, 3);
        int numericPart = Integer.parseInt(lastItemID.substring(3));
        numericPart++;
        return prefix + String.format("%04d", numericPart);
    }

    public static String incrementSKID() {
        String lastItemID = null;
        try {
            Connection con = DBConector.getConnection();
            String sql = "SELECT SKID FROM stockkeeper ORDER BY SKID DESC LIMIT 1";
            PreparedStatement pstmt = con.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                lastItemID = rs.getString("SKID");
            } else {
                lastItemID = "sk0000";
            }
            pstmt.close();
            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        String prefix = lastItemID.substring(0, 2);
        int numericPart = Integer.parseInt(lastItemID.substring(2));
        numericPart++;
        return prefix + String.format("%04d", numericPart);
    }

    public static String incrementMktID() {
        String lastItemID = null;
        try {
            Connection con = DBConector.getConnection();
            String sql = "SELECT MID FROM marketingteam ORDER BY MID DESC LIMIT 1";
            PreparedStatement pstmt = con.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                lastItemID = rs.getString("MID");
            } else {
                lastItemID = "mkt0000";
            }
            pstmt.close();
            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        String prefix = lastItemID.substring(0, 3);
        int numericPart = Integer.parseInt(lastItemID.substring(3));
        numericPart++;
        return prefix + String.format("%04d", numericPart);
    }

    public static ResultSet viewAd() {
        ResultSet rs = null;
        try {
            Connection con = DBConector.getConnection();
            String sql = "SELECT * FROM admin";
            PreparedStatement pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }
    
    public static ResultSet viewsup() {
        ResultSet rs = null;
        try {
            Connection con = DBConector.getConnection();
            String sql = "SELECT * FROM supplier";
            PreparedStatement pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }
    
    public static ResultSet viewSk() {
        ResultSet rs = null;
        try {
            Connection con = DBConector.getConnection();
            String sql = "SELECT * FROM stockkeeper";
            PreparedStatement pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }
    
    public static ResultSet viewMk() {
        ResultSet rs = null;
        try {
            Connection con = DBConector.getConnection();
            String sql = "SELECT * FROM marketingteam";
            PreparedStatement pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }

}
