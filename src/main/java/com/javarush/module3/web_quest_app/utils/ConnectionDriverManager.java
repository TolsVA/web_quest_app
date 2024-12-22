package com.javarush.module3.web_quest_app.utils;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
public final class ConnectionDriverManager {
    private static final String URL="url";
    private static final String USERNAME="username";
    private static final String PASSWORD="password";

    public static Connection open() throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.cj.jdbc.Driver");

        return DriverManager.getConnection(PropertiesConfig.get(URL),
                PropertiesConfig.get(USERNAME),
                PropertiesConfig.get(PASSWORD));
    }
}
