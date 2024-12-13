/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import app.classes.AdminCls;
import app.classes.DBConector;
import app.classes.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author lakru
 */
@WebServlet(name = "ChangePassword", urlPatterns = {"/ChangePassword"})
public class ChangePassword extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String ID;
        String table = null;
        String IDname = null;
        String sql = null;

        User ur = new User();
        ur.setPassword(request.getParameter("pWord"));
        ID = request.getParameter("id");
        String ID_ = ID.substring(0, 2);

        if (ID_.equals("su")) {
            table = "supplier";
            IDname = "SID";
        } else if (ID_.equals("SK")) {
            table = "stockkeeper";
            IDname = "SKID";
        } else if (ID_.equals("mk")) {
            table = "marketingteam";
            IDname = "MID";
        } else if (ID_.equals("Ad")) {
            table = "Admin";
            IDname = "Aid";
        }

        Connection con;
        try {
            con = DBConector.getConnection();
            sql = "UPDATE " + table + " SET password=? WHERE " + IDname + "='" + ID + "'";
            PreparedStatement pstmt = con.prepareStatement(sql);            
            pstmt.setString(1,ur.getPassword()); 
            if (pstmt.executeUpdate() > 0) {
                response.sendRedirect("logn.jsp?m=1");
            } else {
                response.sendRedirect("ChangePassword.jsp?m=1");
            }
        } catch (Exception ex) {

        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
