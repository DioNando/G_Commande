/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.commande.ihm;

import com.commande.dao.ClientDAO;
import com.commande.dao.DAOContext;
import com.commande.model.ClientModel;
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
@WebServlet(name = "Client", urlPatterns = {"/client", "/chiffre-affaire", "/liste-2-date"})
public class Client extends HttpServlet {

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
                case "/G_Commande/client":
                    if (request.getParameter("action") != null) {
                        String action = request.getParameter("action");
                        try {
                            switch (action) {
                                case "Selectionner":
                                    selectClient(request, response);
                                    break;
                                default:
                                    listAllClients(request, response);
                                    break;
                            }
                        } catch (SQLException ex) {
                            throw new ServletException(ex);
                        }
                    } else {
                        try {
                            listAllClients(request, response);
                        } catch (SQLException ex) {
                            throw new ServletException(ex);
                        }
                    }
                    break;
                case "/G_Commande/chiffre-affaire":
                    listChiffreAffaire(request, response);
                    break;
                case "/G_Commande/liste-2-date":
                    list2Date(request, response);
                    break;
                default:
                    listAllClients(request, response);
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
                    addClient(request, response);
                    break;
                case "Modifier":
                    updateClient(request, response);
                    break;
                case "Supprimer":
                    deleteClient(request, response);
                    break;
                case "Chercher":
                    searchClient(request, response);
                    break;
                case "Chercher2Dates":
                    list2Date(request, response);
                    break;
                case "Chart":
                    JSONArray listClient = new JSONArray(ClientDAO.selectChiffreAffaire());
                    response.setContentType("application/json");
                    response.getWriter().write(listClient.toString());
                    break;
                default:
                    listAllClients(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void listAllClients(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {

        int page = 1;
        int recordsPerPage = 10;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        ClientDAO dao = new ClientDAO();

        List< ClientModel> listClient = ClientDAO.selectAllClients((page - 1) * recordsPerPage, recordsPerPage);

        int noOfRecords = dao.getNoOfRecords();
        int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);

        request.setAttribute("listClient", listClient);
        request.setAttribute("noOfPages", noOfPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("noOfRecords", noOfRecords);
        request.setAttribute("pageActive", "client");

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pagers/client.jsp");
        dispatcher.forward(request, response);
    }

    private void listChiffreAffaire(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {

        List< ClientModel> listClient = ClientDAO.selectChiffreAffaire();
        int total = ClientDAO.totalChiffreAffaire();

        request.setAttribute("total", total);
        request.setAttribute("listClient", listClient);
        request.setAttribute("pageActive", "client");

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pagers/chiffre-affaire.jsp");
        dispatcher.forward(request, response);
    }

    private void selectClient(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int idClient = Integer.parseInt(request.getParameter("idClient"));
        JSONObject selectedClient = new JSONObject(ClientDAO.selectClient(idClient));
        response.setContentType("application/json");
        response.getWriter().write(selectedClient.toString());
    }

    private void addClient(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        String nomClient = request.getParameter("nomClientToAdd");
        ClientModel newClient = new ClientModel(nomClient);
        ClientDAO.addClient(newClient);
        response.sendRedirect("client");
    }

    private void updateClient(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int idClient = Integer.parseInt(request.getParameter("idClient"));
        String nomClient = request.getParameter("nomClient");
        ClientModel newClient = new ClientModel(idClient, nomClient);
        ClientDAO.updateClient(newClient);
        response.sendRedirect("client");
    }

    private void deleteClient(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int idClient = Integer.parseInt(request.getParameter("idClient"));
        ClientDAO.deleteClient(idClient);
        response.sendRedirect("client");
    }

    private void searchClient(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        String keywordClient = request.getParameter("keywordClient");
        JSONArray listClient = new JSONArray(ClientDAO.searchClient(keywordClient));
        response.setContentType("application/json");
        response.getWriter().write(listClient.toString());
    }

    private void list2Date(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        /*int idClient = Integer.parseInt(request.getParameter("idClient"));
        String dateDebut = request.getParameter("dateDebut");
        String dateFin = request.getParameter("dateFin"); */

        if (request.getParameter("submit") != null) {
            int idClient = Integer.parseInt(request.getParameter("idClient"));
            String dateDebut = request.getParameter("dateDebut");
            String dateFin = request.getParameter("dateFin");
            JSONArray listClient = new JSONArray(ClientDAO.selectClient2Date(idClient, dateDebut, dateFin));
            response.setContentType("application/json");
            response.getWriter().write(listClient.toString());
        } else {
            List< ClientModel> listClient = ClientDAO.selectAllClientsNoPagination();

            request.setAttribute("listClient", listClient);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pagers/liste-2-date.jsp");
            dispatcher.forward(request, response);

        }
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
