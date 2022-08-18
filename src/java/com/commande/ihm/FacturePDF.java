/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.commande.ihm;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gnostice.pdfone.PDFOne;
import com.gnostice.pdfone.PdfDocument;
import com.gnostice.pdfone.fonts.PdfFont;
import java.awt.Color;

/**
 *
 * @author mahef
 */
@WebServlet(name = "FacturePDF", urlPatterns = {"/facturepdf"})
public class FacturePDF extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            /*
            // Create a new PDF document

            PdfDocument doc = new PdfDocument();
            // Access the default font and modify it
            PdfFont defaultFont = doc.getFont();
            defaultFont.setStyle(PdfFont.STROKE_AND_FILL);
            defaultFont.setSize(60);
            defaultFont.setStrokeColor(Color.RED);
            defaultFont.setStrokeWidth(2);
            defaultFont.setColor(Color.YELLOW);

            // Prepare the browser
            response.setContentType("application/pdf");
            response.setBufferSize(2000);

            // Set PDF version to 1.4 for backward compatibility
            doc.setVersion(PdfDocument.VERSION_1_4);

            // Render text on the first page
            doc.writeText("Hello, World!", 100, 100);

            // Save the document to the browser
            doc.save(response.getOutputStream());

            // Close the document
            doc.close();

            // Close the browser output
            response.flushBuffer(); */
        } catch (Exception e) {
            System.out.println("Sorry, an error occurred " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
