/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import app.classes.ItemData;
import app.classes.SpplierCls;
import app.classes.StockKData;
import app.classes.SupplierData;
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
public class ControlSupp extends HttpServlet {

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

        ItemData item = new ItemData();
        StockKData stockK = new StockKData();
        SupplierData supplierD = new SupplierData();
        SpplierCls supcls = new SpplierCls();

        ResultSet data;
        String itemName;
        String category;
        String unitCap;
        Double unitPrice;
        String ID;
        String SupID;
        String SkID;
        String qty;
        String date;

        if (action != null) {
            switch (action) {

                case "add":
                    item.setItemName(request.getParameter("itemName"));
                    item.setCategory(request.getParameter("category"));
                    item.setCapacity(request.getParameter("unitCap"));
                    item.setUnitPrice(Double.parseDouble(request.getParameter("unitPrice")));

                    String newID = supcls.incrementItemID();

                    itemName = item.getItemName();
                    category = item.getCategory();
                    unitCap = item.getCapacity();
                    unitPrice = item.getUnitPrice();

                    if (supcls.addItem(newID, itemName, category, unitCap, unitPrice) > 0) {
                        response.sendRedirect("DashSupplier.jsp?m=1");
                    } else {
                        response.sendRedirect("DashSupplier.jsp?m=2");
                    }
                    break;

                case "edit":
                    item.setID(request.getParameter("id"));
                    item.setUnitPrice(Double.parseDouble(request.getParameter("unitPrice")));

                    ID = item.getID();
                    unitPrice = item.getUnitPrice();

                    if (supcls.updateItem(ID, unitPrice) > 0) {
                        response.sendRedirect("DashSupplier.jsp?m=3");
                    } else {
                        response.sendRedirect("DashSupplier.jsp?m=4");
                    }
                    break;

                case "delete":
                    ID = request.getParameter("id");
                    if (supcls.deleteItem(ID) > 0) {
                        response.sendRedirect("DashSupplier.jsp?m=5");
                    } else {
                        response.sendRedirect("DashSupplier.jsp?m=6");
                    }
                    break;

                case "send":
                    supplierD.setSID(request.getParameter("sid"));
                    stockK.setSKID(request.getParameter("skid"));
                    item.setQty(request.getParameter("qty"));
                    item.setID(request.getParameter("iid"));

                    String newid = supcls.incrementSupplyID();
                    date = supcls.date();

                    SupID = supplierD.getSID();
                    SkID = stockK.getSKID();
                    qty = item.getQty();
                    ID = item.getID();
                    
                    int FullCap = supcls.getUnitCap(ID) * Integer.parseInt(qty);                  

                    if (supcls.checkEmptyS() - FullCap > 0) {
                        if (supcls.sendItemToSK(newid, SupID, SkID, ID, qty, date) > 0) {
                            response.sendRedirect("DashSupplier.jsp?m=7");
                        } else {
                            response.sendRedirect("DashSupplier.jsp?m=8");
                        }
                    }else {
                        response.sendRedirect("DashSupplier.jsp?m=9");
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
