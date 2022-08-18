/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.commande.ihm;

import com.commande.dao.DAOContext;
import com.commande.dao.ProduitDAO;
import com.commande.model.ProduitModel;
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
@WebServlet(name = "Produit", urlPatterns = {"/produit"})
public class Produit extends HttpServlet {

    @Override
    public void init() throws ServletException {
        DAOContext.init(this.getServletContext());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getParameter("action") != null) {
            String action = request.getParameter("action");
            try {
                switch (action) {
                    case "Selectionner":
                        selectProduit(request, response);
                        break;
                    default:
                        listAllProduits(request, response);
                        break;
                }
            } catch (SQLException ex) {
                throw new ServletException(ex);
            }
        } else {
            try {
                listAllProduits(request, response);
            } catch (SQLException ex) {
                throw new ServletException(ex);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("submit");
        try {
            switch (action) {
                case "Ajouter":
                    addProduit(request, response);
                    break;
                case "Modifier":
                    updateProduit(request, response);
                    break;
                case "Supprimer":
                    deleteProduit(request, response);
                    break;
                case "Chercher":
                    searchProduit(request, response);
                    break;
                default:
                    listAllProduits(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void listAllProduits(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {

        int page = 1;
        int recordsPerPage = 10;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        ProduitDAO dao = new ProduitDAO();

        List< ProduitModel> listProduit = ProduitDAO.selectAllProduits((page - 1) * recordsPerPage, recordsPerPage);

        int noOfRecords = dao.getNoOfRecords();
        int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);

        request.setAttribute("listProduit", listProduit);
        request.setAttribute("noOfPages", noOfPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("noOfRecords", noOfRecords);
        request.setAttribute("pageActive", "produit");

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pagers/produit.jsp");
        dispatcher.forward(request, response);
    }

    private void selectProduit(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int idProduit = Integer.parseInt(request.getParameter("idProduit"));
        JSONObject selectedProduit = new JSONObject(ProduitDAO.selectProduit(idProduit));
        response.setContentType("application/json");
        response.getWriter().write(selectedProduit.toString());
    }

    private void addProduit(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        String designProduit = request.getParameter("designProduitToAdd");
        int prixUniProduit = Integer.parseInt(request.getParameter("prixUniProduitToAdd"));
        int stockProduit = Integer.parseInt(request.getParameter("stockProduitToAdd"));
        ProduitModel newProduit = new ProduitModel(designProduit, prixUniProduit, stockProduit);
        ProduitDAO.addProduit(newProduit);
        response.sendRedirect("produit");
    }

    private void updateProduit(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int idProduit = Integer.parseInt(request.getParameter("idProduit"));
        String designProduit = request.getParameter("designProduit");
        int prixUniProduit = Integer.parseInt(request.getParameter("prixUniProduit"));
        int stockProduit = Integer.parseInt(request.getParameter("stockProduit"));
        ProduitModel newProduit = new ProduitModel(idProduit, designProduit, prixUniProduit, stockProduit);
        ProduitDAO.updateProduit(newProduit);
        response.sendRedirect("produit");
    }

    private void deleteProduit(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int idProduit = Integer.parseInt(request.getParameter("idProduit"));
        ProduitDAO.deleteProduit(idProduit);
        response.sendRedirect("produit");
    }
    
    private void searchProduit(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        String keywordProduit = request.getParameter("keywordProduit");
        JSONArray listProduit = new JSONArray(ProduitDAO.searchClient(keywordProduit));
        response.setContentType("application/json");
        response.getWriter().write(listProduit.toString());
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
