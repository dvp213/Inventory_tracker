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
public class ShowUsers {
    
    public static ResultSet AllSup() {
        ResultSet rs = null;
        try {
            Connection con = DBConector.getConnection();
            String sql = "SELECT SID,username,phoneNo,email FROM supplier";
            PreparedStatement pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }
    
    public static ResultSet AllSk() {
        ResultSet rs = null;
        try {
            Connection con = DBConector.getConnection();
            String sql = "SELECT SKID,username,phoneNo,email FROM stockkeeper";
            PreparedStatement pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }
    
    public static ResultSet AllMkt() {
        ResultSet rs = null;
        try {
            Connection con = DBConector.getConnection();
            String sql = "SELECT MID,username,phoneNo,email FROM marketingteam";
            PreparedStatement pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }
    
    public static ResultSet AllAdmin() {
        ResultSet rs = null;
        try {
            Connection con = DBConector.getConnection();
            String sql = "SELECT Aid,username,phoneNo,email FROM admin";
            PreparedStatement pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }
}
