package com.javarush.module3.web_quest_app;

import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

public class DataManager {

    // Статическое поле для хранения единственного экземпляра класса
    private static volatile DataManager instance;

    // Потокобезопасный список строк
    private List<String> contentList;

    // Приватный конструктор, чтобы предотвратить создание экземпляра вне класса
    private DataManager() {
        // Используем CopyOnWriteArrayList для потокобезопасности
        this.contentList = new CopyOnWriteArrayList<>();
    }

    // Метод для получения единственного экземпляра класса
    public static DataManager getInstance() {
        if (instance == null) {
            synchronized (DataManager.class) {
                if (instance == null) {
                    instance = new DataManager();
                }
            }
        }
        return instance;
    }

    // Метод для добавления строки в список
    public void addContent(String content) {
        this.contentList.add(content);
    }

    // Метод для получения списка строк
    public List<String> getContentList() {
        return contentList;
    }

    // Метод для очистки списка
    public void clearContent() {
        this.contentList.clear();
    }

    // Метод для проверки наличия данных в списке
    public boolean hasContent() {
        return !contentList.isEmpty();
    }
}

