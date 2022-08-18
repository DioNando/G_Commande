/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.commande.ihm;

import com.commande.dao.DAOContext;
import com.commande.dao.UserDAO;
import com.commande.model.UserModel;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author mahef
 */
@WebServlet(name = "Login", urlPatterns = {"/login"})
public class Login extends HttpServlet {

    @Override
    public void init() throws ServletException {
        DAOContext.init(this.getServletContext());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("userName", "");
        request.setAttribute("userPassword", "");
        request.setAttribute("errorMessage", "");
        request.getRequestDispatcher("/WEB-INF/pagers/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userName = request.getParameter("userName");
        String userPassword = request.getParameter("userPassword");

        UserModel connectedUser = UserDAO.isValidLogin(userName, userPassword);
        if (connectedUser != null) {
            /* RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pagers/home.jsp");
            dispatcher.forward(request, response); */
            response.sendRedirect("client");
        } else {
            request.setAttribute("userName", request.getParameter("userName"));
            request.setAttribute("errorMessage", "Utilisateur ou mot de passe incorrecte");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pagers/login.jsp");
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
