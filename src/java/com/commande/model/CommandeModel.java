package com.commande.model;
import com.github.royken.converter.FrenchNumberToWords;

public class CommandeModel {

    private int idCommande;
    private int idClient;
    private String nomClient;
    private int idProduit;
    private String designProduit;
    private int quantite;
    private int prixUniProduit;
    private int montant;
    private String montantLettre;
    private String dateCommande;

    public CommandeModel() {
    }

    public CommandeModel(int m_idClient, int m_idProduit, int m_quantite, String m_dateCommande) {
        this.idClient = m_idClient;
        this.idProduit = m_idProduit;
        this.quantite = m_quantite;
        this.dateCommande = m_dateCommande;
    }

    public CommandeModel(int m_idCommande, int m_idClient, int m_idProduit, int m_quantite, String m_dateCommande) {
        this.idCommande = m_idCommande;
        this.idClient = m_idClient;
        this.idProduit = m_idProduit;
        this.quantite = m_quantite;
        this.dateCommande = m_dateCommande;
    }

    public CommandeModel(int m_idCommande, int m_idClient, String m_nomClient, int m_idProduit, String m_designProduit, int m_prixUniProduit, int m_quantite, String m_dateCommande) {
        this.idCommande = m_idCommande;
        this.idClient = m_idClient;
        this.nomClient = m_nomClient;
        this.idProduit = m_idProduit;
        this.designProduit = m_designProduit;
        this.quantite = m_quantite;
        this.prixUniProduit = m_prixUniProduit;
        this.montant = m_prixUniProduit * m_quantite;
        this.montantLettre = FrenchNumberToWords.convert(this.montant);
        this.dateCommande = m_dateCommande;
    }

    public int getIdCommande() {
        return idCommande;
    }

    public void setIdCommande(int m_idCommande) {
        this.idCommande = m_idCommande;
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

    public int getIdProduit() {
        return idProduit;
    }

    public void setIdProduit(int m_idProduit) {
        this.idProduit = m_idProduit;
    }
    
    public String getDesignProduit() {
        return designProduit;
    }
    
    public int getPrixUniProduit() {
        return prixUniProduit;
    }

    public int getMontant() {
        return montant;
    }
    
    public String getMontantLettre() {
        return montantLettre;
    }

    public int getQuantite() {
        return quantite;
    }

    public void setQuantite(int m_quantite) {
        this.quantite = m_quantite;
    }

    public String getDateCommande() {
        return dateCommande;
    }

    public void setDateCommande(String m_dateCommande) {
        this.dateCommande = m_dateCommande;
    }

}
