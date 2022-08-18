package com.commande.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.commande.model.ClientModel;

public class ClientDAO extends DAOContext {

    private static final String SELECT_ALL_CLIENTS = "SELECT * FROM Client ORDER BY idClient DESC";
    private static final String SELECT_CHIFFRE_AFFAIRE = "SELECT *, SUM(commande.quantite*produit.prixUniProduit) AS total FROM Commande JOIN Client ON client.idClient = commande.idClient JOIN Produit ON produit.idProduit = commande.idProduit GROUP BY commande.idClient ORDER BY idCommande DESC";
    private static final String TOTAL_CHIFFRE_AFFAIRE = "SELECT SUM(commande.quantite*produit.prixUniProduit) AS total FROM Commande JOIN Client ON client.idClient = commande.idClient JOIN Produit ON produit.idProduit = commande.idProduit";
    private static final String SELECT_CLIENT_BY_ID = "SELECT * FROM Client WHERE idClient = ?";
    private static final String SEARCH_CLIENT_BY_KEYWORD = "SELECT * FROM Client WHERE CONCAT(idClient, ' ', nomClient) LIKE ?";
    private static final String SELECT_CLIENT_2_DATE = "SELECT client.nomClient, produit.designProduit, commande.dateCommande FROM client, produit, commande WHERE client.idClient = commande.idClient AND produit.idProduit = commande.idProduit AND client.idClient LIKE ? AND commande.dateCommande BETWEEN ? AND ?";
    private static final String INSERT_CLIENT = "INSERT INTO Client (nomClient) VALUES (?)";
    private static final String UPDATE_CLIENT = "UPDATE Client set nomClient = ? WHERE idClient = ?";
    private static final String DELETE_CLIENT = "DELETE FROM Client WHERE idClient = ?";

    private int noOfRecords;

    public static List< ClientModel> selectAllClients(int offset, int noOfRecords) {
        List< ClientModel> clients = new ArrayList<>();

        try ( Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword)) {
            try ( PreparedStatement statement = connection.prepareStatement(SELECT_ALL_CLIENTS + " LIMIT " + offset + "," + noOfRecords)) {

                ResultSet rs = statement.executeQuery();
                while (rs.next()) {
                    int idClient = rs.getInt("idClient");
                    String nomClient = rs.getString("nomClient");
                    clients.add(new ClientModel(idClient, nomClient));
                }
            }
        } catch (Exception exception) {
            throw new RuntimeException(exception);
        }
        return clients;
    }

    public static List< ClientModel> selectAllClientsNoPagination() {
        List< ClientModel> clients = new ArrayList<>();

        try ( Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword)) {
            try ( PreparedStatement statement = connection.prepareStatement(SELECT_ALL_CLIENTS)) {

                ResultSet rs = statement.executeQuery();
                while (rs.next()) {
                    int idClient = rs.getInt("idClient");
                    String nomClient = rs.getString("nomClient");
                    clients.add(new ClientModel(idClient, nomClient));
                }
            }
        } catch (Exception exception) {
            throw new RuntimeException(exception);
        }
        return clients;
    }

    public static List< ClientModel> selectChiffreAffaire() {
        List< ClientModel> clients = new ArrayList<>();

        try ( Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword)) {
            try ( PreparedStatement statement = connection.prepareStatement(SELECT_CHIFFRE_AFFAIRE)) {

                ResultSet rs = statement.executeQuery();
                while (rs.next()) {
                    int idClient = rs.getInt("idClient");
                    String nomClient = rs.getString("nomClient");
                    int total = rs.getInt("total");
                    clients.add(new ClientModel(idClient, nomClient, total));
                }
            }
        } catch (Exception exception) {
            throw new RuntimeException(exception);
        }
        return clients;
    }

    public static int totalChiffreAffaire() {
        int total = 0;

        try ( Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword)) {
            try ( PreparedStatement statement = connection.prepareStatement(TOTAL_CHIFFRE_AFFAIRE)) {

                ResultSet rs = statement.executeQuery();
                while (rs.next()) {
                    total = rs.getInt("total");
                }
            }
        } catch (Exception exception) {
            throw new RuntimeException(exception);
        }
        return total;
    }

    public static ClientModel selectClient(int numClient) {
        ClientModel client = null;
        try ( Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword)) {
            try ( PreparedStatement statement = connection.prepareStatement(SELECT_CLIENT_BY_ID)) {

                statement.setInt(1, numClient);
                ResultSet rs = statement.executeQuery();

                while (rs.next()) {
                    int idClient = rs.getInt("idClient");
                    String nomClient = rs.getString("nomClient");
                    client = new ClientModel(idClient, nomClient);
                }
            }
        } catch (Exception exception) {
            throw new RuntimeException(exception);
        }
        return client;
    }

    public static void addClient(ClientModel client) {
        try ( Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword)) {
            try ( PreparedStatement statement = connection.prepareStatement(INSERT_CLIENT)) {

                statement.setString(1, client.getNomClient());
                statement.executeUpdate();

            }
        } catch (Exception exception) {
            throw new RuntimeException(exception);
        }
    }

    public static boolean updateClient(ClientModel client) {
        boolean rowUpdated;
        try ( Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword)) {
            try ( PreparedStatement statement = connection.prepareStatement(UPDATE_CLIENT)) {

                statement.setString(1, client.getNomClient());
                statement.setInt(2, client.getIdClient());
                rowUpdated = statement.executeUpdate() > 0;
            }
        } catch (Exception exception) {
            throw new RuntimeException(exception);
        }
        return rowUpdated;
    }

    public static boolean deleteClient(int idClient) {
        boolean rowDeleted;
        try ( Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword)) {
            try ( PreparedStatement statement = connection.prepareStatement(DELETE_CLIENT)) {

                statement.setInt(1, idClient);
                rowDeleted = statement.executeUpdate() > 0;
            }
        } catch (Exception exception) {
            throw new RuntimeException(exception);
        }
        return rowDeleted;
    }

    public static List< ClientModel> searchClient(String keywordClient) {
        List< ClientModel> clients = new ArrayList<>();

        try ( Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword)) {
            try ( PreparedStatement statement = connection.prepareStatement(SEARCH_CLIENT_BY_KEYWORD)) {

                statement.setString(1, "%" + keywordClient + "%");
                ResultSet rs = statement.executeQuery();
                while (rs.next()) {
                    int idClient = rs.getInt("idClient");
                    String nomClient = rs.getString("nomClient");
                    clients.add(new ClientModel(idClient, nomClient));
                }
            }
        } catch (Exception exception) {
            throw new RuntimeException(exception);
        }
        return clients;
    }

    public static List< ClientModel> selectClient2Date(int m_idClient, String m_dateDebut, String m_dateFin) {
        List< ClientModel> clients = new ArrayList<>();

        try ( Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword)) {
            try ( PreparedStatement statement = connection.prepareStatement(SELECT_CLIENT_2_DATE)) {

                statement.setInt(1, m_idClient);
                statement.setString(2, m_dateDebut);
                statement.setString(3, m_dateFin);
                ResultSet rs = statement.executeQuery();
                while (rs.next()) {
                    String nomClient = rs.getString("client.nomClient");
                    String designProduit = rs.getString("produit.designProduit");
                    String dateCommande = rs.getString("commande.dateCommande");
                    clients.add(new ClientModel(nomClient, designProduit, dateCommande));
                }
            }
        } catch (Exception exception) {
            throw new RuntimeException(exception);
        }
        return clients;
    }

    public int getNoOfRecords() {
        try ( Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword)) {
            try ( PreparedStatement statement = connection.prepareStatement("SELECT COUNT(*) FROM Client")) {
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
