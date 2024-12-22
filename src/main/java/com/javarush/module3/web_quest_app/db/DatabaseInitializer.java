package com.javarush.module3.web_quest_app.db;

import com.javarush.module3.web_quest_app.utils.ConnectionDriverManager;

import java.sql.*;

public class DatabaseInitializer {

    public void initializeDatabase() {
        try (Connection connection = ConnectionDriverManager.open();
             Statement statement = connection.createStatement()) {

            System.out.println("Подключение к MySQL установлено!");

            // Проверка, существует ли схема
            if (!databaseExists(statement, "db_quest")) {
                System.out.println("База данных не существует. Создаем новую...");
                // Создаем схему
                statement.executeUpdate("CREATE DATABASE db_quest");
                System.out.println("База данных 'db_quest' успешно создана.");
            } else {
                System.out.println("База данных 'db_quest' уже существует.");
            }

            // Создаем таблицы, если они не существуют
            createTables(statement);

        } catch (SQLException e) {
            System.err.println("Ошибка при работе с базой данных: " + e.getMessage());
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    private boolean databaseExists(Statement statement, String dbName) throws SQLException {
        ResultSet resultSet = statement.executeQuery("SHOW DATABASES LIKE '" + dbName + "'");
        return resultSet.next();
    }

    private void createTables(Statement statement) throws SQLException {

        // Проверка, существует ли таблица 'user_status'
        if (!tableExists(statement, "user_status")) {
            // Создаем таблицу user_status
            statement.executeUpdate("CREATE TABLE user_status (\n" +
                    "    id INT AUTO_INCREMENT PRIMARY KEY,\n" +
                    "    status VARCHAR(20) NOT NULL\n" +
                    ");");
            System.out.println("Таблица 'user_status' успешно создана.");

        } else {
            System.out.println("Таблица 'user_status' уже существует.");
        }

        // Добавляем статусы в таблицу user_status, если они не существуют
        ResultSet rs = statement.executeQuery("SELECT * FROM db_quest.user_status");
        if (!rs.next()) {
            // Добавляем начальные статусы
            statement.executeUpdate("INSERT INTO db_quest.user_status (status) VALUES ('user')");
            statement.executeUpdate("INSERT INTO db_quest.user_status (status) VALUES ('administrator')");
            statement.executeUpdate("INSERT INTO db_quest.user_status (status) VALUES ('blocked')");
            System.out.println("Добавлены начальные статусы в таблицу 'user_status'.");
        }

        // Проверка, существует ли таблица
        if (!tableExists(statement, "users")) {
            // Создаем таблицу users
            statement.executeUpdate("CREATE TABLE users (\n" +
                    "    id INT AUTO_INCREMENT PRIMARY KEY,\n" +
                    "    username VARCHAR(50) NOT NULL UNIQUE,\n" +
                    "    password VARCHAR(255) NOT NULL,\n" +
                    "    email VARCHAR(100) NOT NULL UNIQUE,\n" +
                    "    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,\n" +
                    "    status_id INT,\n" +  // Поле для ссылки на статус
                    "    FOREIGN KEY (status_id) REFERENCES db_quest.user_status(id) ON DELETE SET NULL\n" +  // Связь с таблицей user_status
                    ");");
            System.out.println("Таблица 'users' успешно создана.");
        } else {
            System.out.println("Таблица 'users' уже существует.");
        }

//   'hero_and_the_enchanted_forest'

        // Создаем таблицу 'quest', если не существует
        if (!tableExists(statement, "quest")) {
            statement.executeUpdate("CREATE TABLE quest (\n" +
                    "    id INT AUTO_INCREMENT PRIMARY KEY,\n" +
                    "    name TEXT NOT NULL\n" +
                    ");");
        }


        // Создаем таблицу 'content_jsp', если не существует
        if (!tableExists(statement, "content_jsp")) {
            statement.executeUpdate("CREATE TABLE content_jsp (\n" +
                    "    id INT AUTO_INCREMENT PRIMARY KEY,\n" +
                    "    content TEXT NOT NULL\n" +
                    ");");


            String questHeroAndTheEnchantedForest = """
                <!DOCTYPE html>
                <html lang="ru">
                <head>
                  <meta charset="UTF-8">
                  <title>Квест: Богатырь и Зачарованный Лес</title>
                  <style>
                    body {
                      margin: 0;
                      height: 100vh;
                      display: flex;
                      justify-content: center;
                      align-items: center;
                      background-image: url('https://img.goodfon.ru/original/2048x1365/d/49/lake-geroldsee-bavaria-germany-bavarian-alps-ozero-geroldz-1.jpg'); /* Замените на ваш фон */
                      background-size: cover;
                      color: white;
                      font-family: 'Arial', sans-serif;
                      text-align: center;
                      padding: 20px;
                    }
                
                    .container {
                      background: rgba(0, 0, 0, 0.7); /* Полупрозрачный фон для текста */
                      border-radius: 10px;
                      padding: 30px;
                      max-width: 1200px;
                    }
                
                    h1 {
                      font-size: 36px;
                      margin-bottom: 20px;
                    }
                
                    p {
                      font-size: 18px;
                      line-height: 1.6;
                    }
                  </style>
                </head>
                <body>
                <div class="container">
                  <h1>Квест: Богатырь и Зачарованный Лес</h1>
                  <p>В далёком царстве, среди величественных гор и безбрежных полей, жил славный богатырь по имени Виталий. Славился он не только своей силой, но и добротой. Но однажды, над его родными землями нависла тень беды: Зачарованный Лес, который долгое время был источником волшебства и благополучия, стал темным и таинственным.</p>
                
                  <p>Лес населили злые духи, и его мирные обитатели начали исчезать. Местные жители в страхе заперлись в своих домах, а река, ранее полная жизни, пересохла. Виталий, узнав о бедах своего народа, решил отправиться в Зачарованный Лес, чтобы вернуть его магию и спасти своих сограждан.</p>
                
                  <p>Перед отправлением он встретил мудрого старца, который поведал ему о таинственных испытаниях, ожидающих его в лесу. Чтобы справиться с ними, Виталию понадобятся не только сила и отвага, но и мудрость. Старец рассказал о древнем артефакте, который, находясь в сердце леса, способен вернуть волшебство и прогнать тьму.</p>
                
                  <p>Богатырь, вооружившись своей верой и мечом, ступил на тропу, ведущую в лес. По пути его ждали множество испытаний: он должен был решить загадки лесных духов, сразиться с охраняющими тайны змеями и найти ключи к древним загадкам. Каждое испытание было не только физическим, но и умственным, проверяя его силу воли и способность к размышлениям.</p>
                
                  <p>Когда Виталий, преодолев все трудности, наконец достиг Древа Жизни, он осознал, что истинная сила не только в мускулах, но и в дружбе, уважении и любви к своему народу. С помощью силы Древа и его магии богатырь смог восстановить волшебство леса, освободить его обитателей и вернуть счастье в родное царство.</p>
                
                  <p>В результате его смелости и решимости лес вновь засиял яркими красками, и его обитатели вновь зазвучали. Виталий вернулся домой как герой, не только славясь своей силой, но и мудростью, которую он приобрел на своём пути.</p>
                </div>
                </body>
                </html>""";

            String insertQuery = "INSERT INTO db_quest.content_jsp (content) VALUES (?)";

            try (Connection conn = ConnectionDriverManager.open();
                 PreparedStatement stmt = conn.prepareStatement(insertQuery)) {

                // Устанавливаем значение для первого параметра (?)
                stmt.setString(1, questHeroAndTheEnchantedForest);

                // Выполняем вставку
                int rowsAffected = stmt.executeUpdate();

                System.out.println("Добавлено " + rowsAffected + " строк в таблицу.");
            } catch (SQLException e) {
                e.printStackTrace();
            } catch (ClassNotFoundException e) {
                throw new RuntimeException(e);
            }
            System.out.println("Таблица 'content_jsp' успешно создана.");
        } else {
            System.out.println("Таблица 'content_jsp' уже существует.");
        }

    }

    private boolean tableExists(Statement statement, String tableName) throws SQLException {
        // Используем базу данных перед проверкой существования таблицы
        statement.executeUpdate("USE db_quest");

        ResultSet resultSet = statement.executeQuery("SHOW TABLES LIKE '" + tableName + "'");
        return resultSet.next();
    }
}
