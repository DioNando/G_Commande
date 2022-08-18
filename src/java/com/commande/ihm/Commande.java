/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.commande.ihm;

import com.commande.dao.ClientDAO;
import com.commande.dao.CommandeDAO;
import com.commande.dao.DAOContext;
import com.commande.dao.ProduitDAO;
import com.commande.model.ClientModel;
import com.commande.model.ProduitModel;
import com.commande.model.CommandeModel;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.*;

/**
 *
 * @author mahef
 */
@WebServlet(name = "Commande", urlPatterns = {"/commande", "/liste-commande"})
public class Commande extends HttpServlet {

    @Override
    public void init() throws ServletException {
        DAOContext.init(this.getServletContext());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String URL = request.getRequestURI();
        try {
            switch (URL) {
                case "/G_Commande/commande":
                    newCommande(request, response);
                    break;
                case "/G_Commande/liste-commande":
                    if (request.getParameter("action") != null) {
                        String action = request.getParameter("action");
                        try {
                            switch (action) {
                                case "Selectionner":
                                    selectCommande(request, response);
                                    break;
                                default:
                                    listAllCommandes(request, response);
                                    break;
                            }
                        } catch (SQLException ex) {
                            throw new ServletException(ex);
                        }
                    } else {
                        try {
                            listAllCommandes(request, response);
                        } catch (SQLException ex) {
                            throw new ServletException(ex);
                        }
                    }
                    break;
                default:
                    newCommande(request, response);
                    break;

            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
        System.out.println(URL);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("submit");
        try {
            switch (action) {
                case "Ajouter":
                    addCommande(request, response);
                    break;
                case "Modifier":
                    // updateCommande(request, response);
                    break;
                case "Supprimer":
                    deleteCommande(request, response);
                    break;
                case "Chercher":
                    // searchCommande(request, response);
                    break;
                default:
                    // listAllCommande(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void listAllCommandes(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {

        int page = 1;
        int recordsPerPage = 10;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        CommandeDAO dao = new CommandeDAO();
        List< CommandeModel> listCommande = CommandeDAO.selectAllCommandes((page - 1) * recordsPerPage, recordsPerPage);
        int noOfRecords = dao.getNoOfRecords();
        int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);
        request.setAttribute("listCommande", listCommande);
        request.setAttribute("noOfPages", noOfPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("noOfRecords", noOfRecords);
        request.setAttribute("pageActive", "liste-commande");

        /* List< ClientModel> listClient = ClientDAO.selectAllClientsNoPagination();
        List< ProduitModel> listProduit = ProduitDAO.selectAllProduitsNoPagination();
        request.setAttribute("listClient", listClient);
        request.setAttribute("listProduit", listProduit); */
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pagers/commande-liste.jsp");
        dispatcher.forward(request, response);
    }
    
    private void selectCommande(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int idCommande = Integer.parseInt(request.getParameter("idCommande"));
        JSONObject selectedCommande = new JSONObject(CommandeDAO.selectCommande(idCommande));
        response.setContentType("application/json");
        response.getWriter().write(selectedCommande.toString());
    }

    private void newCommande(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {

        int page = 1;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        request.setAttribute("currentPage", page);
        request.setAttribute("pageActive", "client");

        List< ClientModel> listClient = ClientDAO.selectAllClientsNoPagination();
        List< ProduitModel> listProduit = ProduitDAO.selectAllProduitsNoPagination();
        request.setAttribute("listClient", listClient);
        request.setAttribute("listProduit", listProduit);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pagers/commande.jsp");
        dispatcher.forward(request, response);
    }

    private void addCommande(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int idClient = Integer.parseInt(request.getParameter("idClient"));
        int idProduit = Integer.parseInt(request.getParameter("idProduit"));
        int quantite = Integer.parseInt(request.getParameter("quantiteProduit"));
        String dateCommande = request.getParameter("dateCommande");
        CommandeModel newCommande = new CommandeModel(idClient, idProduit, quantite, dateCommande);
        CommandeDAO.addCommande(newCommande);
        response.sendRedirect("commande");
    }
    
    private void deleteCommande(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int idCommande = Integer.parseInt(request.getParameter("idCommande"));
        CommandeDAO.deleteCommande(idCommande);
        response.sendRedirect("liste-commande");
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
