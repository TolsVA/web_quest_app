package com.javarush.module3.web_quest_app.utils;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtils {
    // Метод для хеширования пароля
    public static String hashPassword(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt());
    }

    // Метод для проверки пароля
    public static boolean checkPassword(String enteredPassword, String storedHash) {
        return BCrypt.checkpw(enteredPassword, storedHash);
    }
}

