package com.commande.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.commande.model.ProduitModel;

public class ProduitDAO extends DAOContext {
    
    private static final String SELECT_ALL_PRODUITS = "SELECT * FROM Produit ORDER BY idProduit DESC";
    private static final String SELECT_PRODUIT_BY_ID = "SELECT * FROM Produit WHERE idProduit = ?";
    private static final String SEARCH_PRODUIT_BY_KEYWORD = "SELECT * FROM Produit WHERE CONCAT(idProduit, ' ', designProduit) LIKE ?";
    private static final String INSERT_PRODUIT = "INSERT INTO Produit (designProduit, prixUniProduit, stockProduit) VALUES (?,?,?)";
    private static final String UPDATE_PRODUIT = "UPDATE Produit set designProduit = ?, prixUniProduit = ?, stockProduit = ? WHERE idProduit = ?";
    private static final String DELETE_PRODUIT = "DELETE FROM Produit WHERE idProduit = ?";

    private int noOfRecords;
    
    public static List< ProduitModel> selectAllProduits(int offset, int noOfRecords) {
        List< ProduitModel> produits = new ArrayList<>();

        try ( Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword)) {
            try ( PreparedStatement statement = connection.prepareStatement(SELECT_ALL_PRODUITS + " LIMIT " + offset + "," + noOfRecords)) {

                ResultSet rs = statement.executeQuery();
                while (rs.next()) {
                    int idProduit = rs.getInt("idProduit");
                    String designProduit = rs.getString("designProduit");
                    int prixUniProduit = rs.getInt("prixUniProduit");
                    int stockProduit = rs.getInt("stockProduit");
                    produits.add(new ProduitModel(idProduit, designProduit, prixUniProduit, stockProduit));
                }
            }
        } catch (Exception exception) {
            throw new RuntimeException(exception);
        }
        return produits;
    }
    
    public static List< ProduitModel> selectAllProduitsNoPagination() {
        List< ProduitModel> produits = new ArrayList<>();

        try ( Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword)) {
            try ( PreparedStatement statement = connection.prepareStatement(SELECT_ALL_PRODUITS)) {

                ResultSet rs = statement.executeQuery();
                while (rs.next()) {
                    int idProduit = rs.getInt("idProduit");
                    String designProduit = rs.getString("designProduit");
                    int prixUniProduit = rs.getInt("prixUniProduit");
                    int stockProduit = rs.getInt("stockProduit");
                    produits.add(new ProduitModel(idProduit, designProduit, prixUniProduit, stockProduit));
                }
            }
        } catch (Exception exception) {
            throw new RuntimeException(exception);
        }
        return produits;
    }
    
    public static ProduitModel selectProduit(int numProduit) {
        ProduitModel produit = null;
        try ( Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword)) {
            try ( PreparedStatement statement = connection.prepareStatement(SELECT_PRODUIT_BY_ID)) {

                statement.setInt(1, numProduit);
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
    
    public static void addProduit(ProduitModel produit) {
        try ( Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword)) {
            try ( PreparedStatement statement = connection.prepareStatement(INSERT_PRODUIT)) {

                statement.setString(1, produit.getDesignProduit());
                statement.setInt(2, produit.getPrixUniProduit());
                statement.setInt(3, produit.getStockProduit());
                statement.executeUpdate();

            }
        } catch (Exception exception) {
            throw new RuntimeException(exception);
        }
    }
    
    public static boolean updateProduit(ProduitModel produit) {
        boolean rowUpdated;
        try (Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword)) {
            try (PreparedStatement statement = connection.prepareStatement(UPDATE_PRODUIT)) {

                statement.setString(1, produit.getDesignProduit());
                statement.setInt(2, produit.getPrixUniProduit());
                statement.setInt(3, produit.getStockProduit());
                statement.setInt(4, produit.getIdProduit());
                rowUpdated = statement.executeUpdate() > 0;
            }
        } catch (Exception exception) {
            throw new RuntimeException(exception);
        }
        return rowUpdated;
    }

    public static boolean deleteProduit(int idProduit) {
        boolean rowDeleted;
        try (Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword)) {
            try (PreparedStatement statement = connection.prepareStatement(DELETE_PRODUIT)) {

                statement.setInt(1, idProduit);
                rowDeleted = statement.executeUpdate() > 0;
            }
        } catch (Exception exception) {
            throw new RuntimeException(exception);
        }
        return rowDeleted;
    }
    
    public static List< ProduitModel> searchClient(String keywordProduit) {
        List< ProduitModel> produits = new ArrayList<>();

        try ( Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword)) {
            try ( PreparedStatement statement = connection.prepareStatement(SEARCH_PRODUIT_BY_KEYWORD)) {

                statement.setString(1, "%" + keywordProduit + "%");
                ResultSet rs = statement.executeQuery();
                while (rs.next()) {
                    int idProduit = rs.getInt("idProduit");
                    String designProduit = rs.getString("designProduit");
                    int prixUniProduit = rs.getInt("prixUniProduit");
                    int stockProduit = rs.getInt("stockProduit");
                    produits.add(new ProduitModel(idProduit, designProduit, prixUniProduit, stockProduit));
                }
            }
        } catch (Exception exception) {
            throw new RuntimeException(exception);
        }
        return produits;
    }
    
    public int getNoOfRecords() {
        try ( Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword)) {
            try ( PreparedStatement statement = connection.prepareStatement("SELECT COUNT(*) FROM Produit")) {
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
