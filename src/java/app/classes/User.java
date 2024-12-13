/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package app.classes;

/**
 *
 * @author lakru
 */
public class User {
    
    private String ID;
    private String username;
    private String phonoNo;
    private String email;
    private String password;

    public String getID() {
        return ID;
    }

    public void setID(String SID) {
        this.ID = SID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPhonoNo() {
        return phonoNo;
    }

    public void setPhonoNo(String phonoNo) {
        this.phonoNo = phonoNo;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

}
