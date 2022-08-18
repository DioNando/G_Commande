package com.commande.model;

public class ClientModel {

    private int idClient;
    private String nomClient;
    private String designProduit;
    private String dateCommande;
    private int total;

    public ClientModel() {
    }
    
    public ClientModel(String m_nomClient) {
        this.nomClient = m_nomClient;
    }

    public ClientModel(int m_idClient, String m_nomClient) {
        this.idClient = m_idClient;
        this.nomClient = m_nomClient;
    }
    
    public ClientModel(String m_nomClient, String m_designProduit, String m_dateCommande) {
        this.nomClient = m_nomClient;
        this.designProduit = m_designProduit;
        this.dateCommande = m_dateCommande;
    }
    
    public ClientModel(int m_idClient, String m_nomClient, int m_total) {
        this.idClient = m_idClient;
        this.nomClient = m_nomClient;
        this.total = m_total;
    }

    public int getIdClient() {
        return idClient;
    }

    public void setIdClient(int m_idClient) {
        this.idClient = m_idClient;
    }

    public String getNomClient() {
        return nomClient;
    }

    public void setNomClient(String m_nomClient) {
        this.nomClient = m_nomClient;
    }
    
    public String getDesignProduit() {
        return designProduit;
    }
    
    public String getDateCommande() {
        return dateCommande;
    }
    
    public int getTotal() {
        return total;
    }
}
