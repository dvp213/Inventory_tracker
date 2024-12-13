package app.classes;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

/**
 *
 * @author lakru
 */
public class MKTCls {

    public static int sendReqToSK(String RmID, String skID, String mkt, String item, String qty, String date, String sts) {
        int a = 0;
        try {
            Connection con = DBConector.getConnection();
            String sql = "INSERT INTO requestitemm (RmID, SKID, MID, itemID, Quantity , Date, Status) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, RmID);
            pstmt.setString(2, skID);
            pstmt.setString(3, mkt);
            pstmt.setString(4, item);
            pstmt.setString(5, qty);
            pstmt.setString(6, date);
            pstmt.setString(7, sts);
            a = pstmt.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return a;
    }

    public static ResultSet requestByM() {
        ResultSet rs = null;
        try {
            Connection con = DBConector.getConnection();
            String sql = "SELECT * FROM requestitemm";
            PreparedStatement pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }

    public static ResultSet requestByML10() {
        ResultSet rs = null;
        try {
            Connection con = DBConector.getConnection();
            String sql = "SELECT * FROM requestitemm ORDER BY RmID DESC LIMIT 10";
            PreparedStatement pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }
    
    public static String date() {
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate nowDate = LocalDate.now();
        return nowDate.toString();
    }

    public static int checkAvailble(String itemID) {
        int emptyCapacity = 0;
        try {
            Connection con = DBConector.getConnection();
            String sql = "SELECT Quantity FROM addremove WHERE itemID = ? AND Status = 'add'";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, itemID);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                emptyCapacity += rs.getInt("Quantity");
            }
            pstmt.close();
            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return emptyCapacity;

    }

    public static String incrementReqmID() {
        String lastItemID = null;
        try {
            Connection con = DBConector.getConnection();
            String sql = "SELECT RmID FROM requestitemm ORDER BY RmID DESC LIMIT 1";
            PreparedStatement pstmt = con.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                lastItemID = rs.getString("RmID");
            } else {
                lastItemID = "rbm0000";
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

    public static ResultSet transferfromSK() {
        ResultSet rs = null;
        try {
            Connection con = DBConector.getConnection();
            String sql = "SELECT * FROM releaseitem";
            PreparedStatement pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }
    
    public static ResultSet transferfromSKL10() {
        ResultSet rs = null;
        try {
            Connection con = DBConector.getConnection();
            String sql = "SELECT * FROM releaseitem ORDER BY RLID DESC LIMIT 10";
            PreparedStatement pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }
    

}
