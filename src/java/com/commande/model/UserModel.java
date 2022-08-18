package com.commande.model;

public class UserModel {

    private final int idUser;
    private final String userName;
    private final String userPassword;

    public UserModel(int m_idUser, String m_userName, String m_userPassword) {
        this.idUser = m_idUser;
        this.userName = m_userName;
        this.userPassword = m_userPassword;
    }

    public int getIdUser() {
        return idUser;
    }

    public String getUserName() {
        return userName;
    }

    public String getUserPassword() {
        return userPassword;
    }
}
