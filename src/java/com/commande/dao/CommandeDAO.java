/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.commande.dao;

import java.util.ArrayList;
import java.util.List;
import java.sql.*;

import com.commande.model.CommandeModel;
import com.commande.model.ProduitModel;
import com.commande.model.ClientModel;

public class CommandeDAO extends DAOContext {

    private static final String SELECT_ALL_COMMANDES = "SELECT * FROM Commande JOIN Client ON client.idClient = commande.idClient JOIN Produit ON produit.idProduit = commande.idProduit ORDER BY idCommande DESC";
    private static final String SELECT_COMMANDE_BY_ID = "SELECT * FROM Commande JOIN Client ON client.idClient = commande.idClient JOIN Produit ON produit.idProduit = commande.idProduit WHERE idCommande = ?";
    private static final String INSERT_COMMANDE = "INSERT INTO Commande (idClient, idProduit, quantite, dateCommande) VALUES (?,?,?,?)";
    private static final String UPDATE_STOCK_PRODUIT = "UPDATE Produit set stockProduit = ? WHERE idProduit = ?";
    private static final String SELECT_PRODUIT_BY_ID = "SELECT * FROM Produit WHERE idProduit = ?";
    private static final String DELETE_COMMANDE = "DELETE FROM Commande WHERE idCommande = ?";

    private int noOfRecords;

    public static List< CommandeModel> selectAllCommandes(int offset, int noOfRecords) {
        List< CommandeModel> commandes = new ArrayList<>();

        try ( Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword)) {
            try ( PreparedStatement statement = connection.prepareStatement(SELECT_ALL_COMMANDES + " LIMIT " + offset + "," + noOfRecords)) {

                ResultSet rs = statement.executeQuery();

                while (rs.next()) {
                    int idCommande = rs.getInt("idCommande");
                    int idClient = rs.getInt("idClient");
                    String nomClient = rs.getString("nomClient");
                    int idProduit = rs.getInt("idProduit");
                    String designProduit = rs.getString("designProduit");
                    int prixUniProduit = rs.getInt("prixUniProduit");
                    int quantite = rs.getInt("quantite");
                    String dateCommande = rs.getString("dateCommande");
                    commandes.add(new CommandeModel(idCommande, idClient, nomClient, idProduit, designProduit, prixUniProduit, quantite, dateCommande));
                }
            }
        } catch (Exception exception) {
            throw new RuntimeException(exception);
        }
        return commandes;
    }

    public static void addCommande(CommandeModel commande) {
        ProduitModel produit = null;
        try ( Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword)) {
            try ( PreparedStatement statement = connection.prepareStatement(INSERT_COMMANDE)) {

                statement.setInt(1, commande.getIdClient());
                statement.setInt(2, commande.getIdProduit());
                statement.setInt(3, commande.getQuantite());
                statement.setString(4, commande.getDateCommande());
                statement.executeUpdate();
            }
            produit = selectProduit(commande.getIdProduit());
            produit.setStockProduit(produit.getStockProduit() - commande.getQuantite());
            updateStockProduit(commande.getIdProduit(), produit.getStockProduit());
        } catch (Exception exception) {
            throw new RuntimeException(exception);
        }
    }

    public static boolean deleteCommande(int idCommande) {
        boolean rowDeleted;
        CommandeModel commande = null;
        ProduitModel produit = null;
        try ( Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword)) {

            commande = selectCommande(idCommande);
            produit = selectProduit(commande.getIdProduit());
            produit.setStockProduit(produit.getStockProduit() + commande.getQuantite());
            updateStockProduit(commande.getIdProduit(), produit.getStockProduit());
            try ( PreparedStatement statement = connection.prepareStatement(DELETE_COMMANDE)) {
                statement.setInt(1, idCommande);
                rowDeleted = statement.executeUpdate() > 0;
            }
        } catch (Exception exception) {
            throw new RuntimeException(exception);
        }
        return rowDeleted;
    }

    public static CommandeModel selectCommande(int m_idCommande) {
        CommandeModel commande = null;
        try ( Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword)) {
            try ( PreparedStatement statement = connection.prepareStatement(SELECT_COMMANDE_BY_ID)) {

                statement.setInt(1, m_idCommande);
                ResultSet rs = statement.executeQuery();

                while (rs.next()) {
                    int idCommande = rs.getInt("idCommande");
                    int idClient = rs.getInt("idClient");
                    String nomClient = rs.getString("nomClient");
                    int idProduit = rs.getInt("idProduit");
                    String designProduit = rs.getString("designProduit");
                    int prixUniProduit = rs.getInt("prixUniProduit");
                    int quantite = rs.getInt("quantite");
                    String dateCommande = rs.getString("dateCommande");
                    commande = new CommandeModel(idCommande, idClient, nomClient, idProduit, designProduit, prixUniProduit, quantite, dateCommande);
                }
            }
        } catch (Exception exception) {
            throw new RuntimeException(exception);
        }
        return commande;
    }

    public static ProduitModel selectProduit(int m_idProduit) {
        ProduitModel produit = null;
        try ( Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword)) {
            try ( PreparedStatement statement = connection.prepareStatement(SELECT_PRODUIT_BY_ID)) {

                statement.setInt(1, m_idProduit);
                ResultSet rs = statement.executeQuery();

                while (rs.next()) {
                    int idProduit = rs.getInt("idProduit");
                    String designProduit = rs.getString("designProduit");
                    int prixUniProduit = rs.getInt("prixUniProduit");
                    int stockProduit = rs.getInt("stockProduit");
                    produit = new ProduitModel(idProduit, designProduit, prixUniProduit, stockProduit);
                }
            }
        } catch (Exception exception) {
            throw new RuntimeException(exception);
        }
        return produit;
    }

    public static void updateStockProduit(int idProduit, int newStock) {
        try ( Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword)) {
            try ( PreparedStatement statement = connection.prepareStatement(UPDATE_STOCK_PRODUIT)) {

                statement.setInt(1, newStock);
                statement.setInt(2, idProduit);
                statement.executeUpdate();
            }

        } catch (Exception exception) {
            throw new RuntimeException(exception);
        }
    }

    public int getNoOfRecords() {
        try ( Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword)) {
            try ( PreparedStatement statement = connection.prepareStatement("SELECT COUNT(*) FROM COMMANDE")) {
                ResultSet rs = statement.executeQuery();
                if (rs.next()) {
                    this.noOfRecords = rs.getInt(1);
                }
            }
        } catch (Exception exception) {
            throw new RuntimeException(exception);
        }
        return noOfRecords;
    }

}
