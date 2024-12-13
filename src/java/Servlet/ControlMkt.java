/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import app.classes.MKTCls;
import app.classes.SpplierCls;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author lakru
 */
public class ControlMkt extends HttpServlet {

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

        String action = request.getParameter("actionMkt");

        MKTCls mkt = new MKTCls();
        ResultSet data;
        HttpSession session;
        if (action != null) {
            switch (action) {
                case "sendReqtoSk":
                    data = mkt.requestByM();
                    session = request.getSession();
                    session.setAttribute("Data", data);
                    session.setAttribute("title", "Item Requests by Marketing Team");
                    response.sendRedirect("ShowTables.jsp");
                    break;
                case "TransferToSK":
                    data = mkt.transferfromSK();
                    session = request.getSession();
                    session.setAttribute("Data", data);
                    session.setAttribute("title", "Transfer History");
                    response.sendRedirect("ShowTables.jsp");
                    break;
                case "req":
                    String RmID = mkt.incrementReqmID();
                    String skID = request.getParameter("SID");
                    String mktid = request.getParameter("MID");
                    String item = request.getParameter("itemID");
                    String sts = null;
                    String qty = request.getParameter("qty");
                    String date = mkt.date();

                    if (mkt.checkAvailble(item) > Integer.parseInt(qty)) {
                        sts = "Pending";
                        if (mkt.sendReqToSK(RmID, skID, mktid, item, qty, date, sts) > 0) {
                            response.sendRedirect("DashMkt.jsp?m=1");
                        }
                    } else {
                        sts = "Not Available";
                        if (mkt.sendReqToSK(RmID, skID, mktid, item, qty, date, sts) > 0) {
                            response.sendRedirect("DashMkt.jsp?m=2");
                        }
                    }

                default:
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
