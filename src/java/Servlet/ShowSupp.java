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
public class ShowSupp extends HttpServlet {

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
        String action = request.getParameter("actionSup");

        SpplierCls sup = new SpplierCls();
        ResultSet data;
        HttpSession session;
        if (action != null) {
            switch (action) {
                case "viewitems":
                    data = sup.viewitems();
                    session = request.getSession();
                    session.setAttribute("Data", data);
                    session.setAttribute("title", "Product list");
                    response.sendRedirect("ShowTables.jsp");
                    break;
                case "RequestBySK":
                    data = sup.requestBySK();
                    session = request.getSession();
                    session.setAttribute("Data", data);
                    session.setAttribute("title", "Item Requests by Stock Keepers");
                    response.sendRedirect("SupplierShowTables2.jsp");
                    break;
                case "TransferToSK":
                    data = sup.transferToSK();
                    session = request.getSession();
                    session.setAttribute("Data", data);
                    session.setAttribute("title", "Transfer History");
                    response.sendRedirect("ShowTables.jsp");
                    break;
                case "reqbtn":
                    String SupplyID = sup.incrementSupplyID();
                    String RID = request.getParameter("RID");
                    String SID = request.getParameter("SID");
                    String SKID = request.getParameter("SKID");
                    String itemID = request.getParameter("itemID");
                    String Quantity = request.getParameter("Quantity");
                    String date = sup.date();

                    if (sup.checkEmptyS() - Integer.parseInt(Quantity) > 1) {
                        if (sup.sendItemToSK(SupplyID, SID, SKID, itemID, Quantity, date) > 0) {
                            sup.updatereq("Sent", RID);
                        } else {
                            sup.updatereq("Cancelled", RID);
                        }
                    } else {
                        sup.updatereq("Cancelled",RID);
                    }
                    data = sup.requestBySK();
                    session = request.getSession();
                    session.setAttribute("Data", data);
                    response.sendRedirect("SupplierShowTables2.jsp");

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
