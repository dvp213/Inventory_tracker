/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package app.classes;

import java.sql.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.LocalDateTime;
import javax.swing.text.DateFormatter;

public class SpplierCls {

    public static String incrementItemID() {
        String lastItemID = null;
        try {
            Connection con = DBConector.getConnection();
            String sql = "SELECT itemID FROM items ORDER BY itemID DESC LIMIT 1";
            PreparedStatement pstmt = con.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                lastItemID = rs.getString("itemID");
            } else {
                lastItemID = "item0000";
            }
            pstmt.close();
            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        String prefix = lastItemID.substring(0, 4);
        int numericPart = Integer.parseInt(lastItemID.substring(4));
        numericPart++;
        return prefix + String.format("%04d", numericPart);
    }

    public static int addItem(String newID, String itemName, String category, String unitCap, double unitPrice) {
        int a = 0;
        try {
            Connection con = DBConector.getConnection();
            String sql = "INSERT INTO items (itemID, Name, type, UnitCapacity, UnitPrice) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, newID);
            pstmt.setString(2, itemName);
            pstmt.setString(3, category);
            pstmt.setString(4, unitCap);
            pstmt.setDouble(5, unitPrice);
            a = pstmt.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return a;
    }

    public static int updateItem(String ID, double unitPrice) {
        int a = 0;
        try {
            Connection con = DBConector.getConnection();
            String sql = "UPDATE items SET UnitPrice=? WHERE itemID=?";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setDouble(1, unitPrice);
            pstmt.setString(2, ID);
            a = pstmt.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return a;
    }

    public static int deleteItem(String ID) {
        int a = 0;
        try {
            Connection con = DBConector.getConnection();
            String sql = "DELETE FROM items WHERE itemID=?";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, ID);
            a = pstmt.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return a;
    }

    public static ResultSet viewitems() {
        ResultSet rs = null;
        try {
            Connection con = DBConector.getConnection();
            String sql = "SELECT * FROM items";
            PreparedStatement pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }

    public static ResultSet selectSK() {
        ResultSet rs = null;
        try {
            Connection con = DBConector.getConnection();
            String sql = "SELECT SKID FROM stockkeeper";
            PreparedStatement pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }

    public static String incrementSupplyID() {
        String lastsupID = null;
        try {
            Connection con = DBConector.getConnection();
            String sql = "SELECT SupplyID FROM supply ORDER BY SupplyID DESC LIMIT 1";
            PreparedStatement pstmt = con.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                lastsupID = rs.getString("SupplyID");
            } else {
                lastsupID = "si0000";
            }
            pstmt.close();
            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        String prefix = lastsupID.substring(0, 2);
        int numericPart = Integer.parseInt(lastsupID.substring(2));
        numericPart++;
        return prefix + String.format("%04d", numericPart);
    }

    public static String date() {
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate nowDate = LocalDate.now();
        return nowDate.toString();
    }

    public static int checkEmptyS() {
        int emptyCapacity = 0;
        try {
            Connection con = DBConector.getConnection();
            String sql = "SELECT FullCapacity,StoredCapacity FROM stock";
            PreparedStatement pstmt = con.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                emptyCapacity += rs.getInt("FullCapacity") - rs.getInt("StoredCapacity");
            }

            pstmt.close();
            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return emptyCapacity;

    }

    public static int getUnitCap(String unitCap_) {
        int unitCap = 0;
        try {
            Connection con = DBConector.getConnection();
            String sql = "SELECT UnitCapacity FROM items WHERE itemID = ?";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, unitCap_);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                unitCap = rs.getInt("UnitCapacity");
            }

            pstmt.close();
            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return unitCap;

    }

    public static int sendItemToSK(String SupplyID, String supplier, String skeeper, String item, String qty, String date) {
        int a = 0;
        try {
            Connection con = DBConector.getConnection();
            String sql = "INSERT INTO supply (SupplyID, SID, SKID, itemID, Quantity ,date) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, SupplyID);
            pstmt.setString(2, supplier);
            pstmt.setString(3, skeeper);
            pstmt.setString(4, item);
            pstmt.setString(5, qty);
            pstmt.setString(6, date);
            a = pstmt.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return a;
    }

    public static ResultSet requestBySK() {
        ResultSet rs = null;
        try {
            Connection con = DBConector.getConnection();
            String sql = "SELECT * FROM requestitems";
            PreparedStatement pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }

    public static ResultSet transferToSK() {
        ResultSet rs = null;
        try {
            Connection con = DBConector.getConnection();
            String sql = "SELECT * FROM supply";
            PreparedStatement pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }

    public static ResultSet viewitemsl5() {
        ResultSet rs = null;
        try {
            Connection con = DBConector.getConnection();
            String sql = "SELECT * FROM items ORDER BY itemID DESC LIMIT 5";
            PreparedStatement pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }

    public static ResultSet transferToSKl5() {
        ResultSet rs = null;
        try {
            Connection con = DBConector.getConnection();
            String sql = "SELECT * FROM supply ORDER BY SupplyID DESC LIMIT 5";
            PreparedStatement pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }

    public static int updatereq(String sts, String ID) {
        int a = 0;
        try {
            Connection con = DBConector.getConnection();
            String sql = "UPDATE requestitems SET Status=? WHERE RID=?";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, sts);
            pstmt.setString(2, ID);
            a = pstmt.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return a;
    }

}
