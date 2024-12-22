package com.javarush.module3.web_quest_app.model.entiti;


import java.io.Serializable;

public class User implements Serializable {
    private String name;
    private String password;
    private String email;
    private int status;

    public User(String name, String password, String email, int status) {
        this.name = name;
        this.password = password;
        this.email = email;
        this.status = status;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
