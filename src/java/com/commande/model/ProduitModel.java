package com.commande.model;

public class ProduitModel {

    private int idProduit;
    private String designProduit;
    private int prixUniProduit;
    private int stockProduit;

    public ProduitModel() {
    }

    public ProduitModel(String m_designProduit, int m_prixUniProduit, int m_stockProduit) {
        this.designProduit = m_designProduit;
        this.prixUniProduit = m_prixUniProduit;
        this.stockProduit = m_stockProduit;
    }

    public ProduitModel(int m_idProduit, String m_designProduit, int m_prixUniProduit, int m_stockProduit) {
        this.idProduit = m_idProduit;
        this.designProduit = m_designProduit;
        this.prixUniProduit = m_prixUniProduit;
        this.stockProduit = m_stockProduit;
    }

    public int getIdProduit() {
        return idProduit;
    }

    public void setId(int m_idProduit) {
        this.idProduit = m_idProduit;
    }

    public String getDesignProduit() {
        return designProduit;
    }

    public void setDesignation(String m_designProduit) {
        this.designProduit = m_designProduit;
    }

    public int getPrixUniProduit() {
        return prixUniProduit;
    }

    public void setPrixUniProduit(int m_prixUniProduit) {
        this.prixUniProduit = m_prixUniProduit;
    }

    public int getStockProduit() {
        return stockProduit;
    }

    public void setStockProduit(int m_stockProduit) {
        this.stockProduit = m_stockProduit;
    }

}
