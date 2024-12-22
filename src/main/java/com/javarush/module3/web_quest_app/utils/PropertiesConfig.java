package com.javarush.module3.web_quest_app.utils;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
public final class PropertiesConfig {
    private static final Properties PROPERTIES = new Properties();
    static {
        loadProperties();
    }

    private static void loadProperties() {
        try (InputStream is = PropertiesConfig.class.getClassLoader().getResourceAsStream("config.properties")) {
            PROPERTIES.load(is);
        } catch (IOException e) {
            throw new RuntimeException();
        }
    }

    public static String get(String key) {
        return PROPERTIES.getProperty(key);
    }
}