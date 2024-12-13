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
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author lakru
 */
public class ControlAdmin extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String action = request.getParameter("actionAd");

        User user = new User();
        AdminCls adcls = new AdminCls();

        String ID;
        String role;
        String uName;
        String pWord;
        String email;
        String pnum;
        String table = null;
        String IDname = null;

        if (action != null) {
            switch (action) {
                case "add":
                    user.setUsername(request.getParameter("uName"));
                    user.setPassword(request.getParameter("pWord"));
                    user.setEmail(request.getParameter("email"));
                    user.setPhonoNo(request.getParameter("pnum"));

                    uName = user.getUsername();
                    pWord = user.getPassword();
                    email = user.getEmail();
                    pnum = user.getPhonoNo();

                    role = (request.getParameter("role"));

                    if (role.equals("1")) {
                        ID = adcls.incrementSupID();
                        if (adcls.addSup(ID, uName, pnum, email, pWord) > 0) {
                            response.sendRedirect("DashAdmin.jsp?m=1");
                        } else {
                            response.sendRedirect("DashAdmin.jsp?m=2");
                        }
                    } else if (role.equals("2")) {
                        ID = adcls.incrementSKID();
                        if (adcls.addSk(ID, uName, pnum, email, pWord) > 0) {
                            response.sendRedirect("DashAdmin.jsp?m=1");
                        } else {
                            response.sendRedirect("DashAdmin.jsp?m=2");
                        }
                    } else if (role.equals("3")) {
                        ID = adcls.incrementMktID();
                        if (adcls.addMkt(ID, uName, pnum, email, pWord) > 0) {
                            response.sendRedirect("DashAdmin.jsp?m=1");
                        } else {
                            response.sendRedirect("DashAdmin.jsp?m=2");
                        }
                    } else if (role.equals("4")) {
                        ID = adcls.incrementAdminID();
                        if (adcls.addAdmin(ID, uName, pnum, email, pWord) > 0) {
                            response.sendRedirect("DashAdmin.jsp?m=1");
                        } else {
                            response.sendRedirect("DashAdmin.jsp?m=2");
                        }
                    }

                    break;

                case "delete":
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
                        String sql = "DELETE FROM " + table + " WHERE " + IDname + "='" + ID + "'";
                        PreparedStatement pstmt = con.prepareStatement(sql);
                        if (pstmt.executeUpdate() > 0) {
                            response.sendRedirect("DashAdmin.jsp?m=3");
                        } else {
                            response.sendRedirect("DashAdmin.jsp?m=4");
                        }
                    } catch (Exception ex) {

                    }

                    break;

                default:
                // Handle default case or show an error page
            }

        } else {

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
