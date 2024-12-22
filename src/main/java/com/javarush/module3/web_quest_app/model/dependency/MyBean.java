package com.javarush.module3.web_quest_app.model.dependency;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

public class MyBean {
    private static volatile MyBean instance; // единственный экземпляр
    private final Map<String, String> values; // карта значений

    private MyBean() {
        values = new HashMap<>(); // инициализируем карту
    }

    public static MyBean getInstance() {
        if (instance == null) {
            synchronized (MyBean.class) {
                if (instance == null) {
                    instance = new MyBean();
                }
            }
        }
        return instance;
    }

    public Map<String, String> getValues() {
        return Collections.unmodifiableMap(values); // возвращаем неизменяемую карту
    }

    public void addValue(String key, String value) {
        values.put(key, value);
    }
}