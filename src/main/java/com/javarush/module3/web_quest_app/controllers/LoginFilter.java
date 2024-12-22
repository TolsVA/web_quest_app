package com.javarush.module3.web_quest_app.controllers;

import com.javarush.module3.web_quest_app.db.DatabaseInitializer;
import com.javarush.module3.web_quest_app.model.entiti.User;
import com.javarush.module3.web_quest_app.utils.ConnectionDriverManager;
import com.javarush.module3.web_quest_app.utils.PasswordUtils;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.lang.String;

@WebFilter("/login")
public class LoginFilter implements Filter {
    private Connection connection;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        try {
            connection = ConnectionDriverManager.open();
        } catch (ClassNotFoundException | SQLException e) {
            throw new ServletException("Ошибка подключения к базе данных", e);
        }
        DatabaseInitializer dbInitializer = new DatabaseInitializer();
        dbInitializer.initializeDatabase(); // Инициализация базы данных и таблиц
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String username = httpRequest.getParameter("username");
        String password = httpRequest.getParameter("password");

        List<String> errors = new ArrayList<>();

        if (username == null || username.isEmpty()) {
            errors.add("Имя пользователя не может быть пустым.");
        }
        if (password == null || password.length() < 6) {
            errors.add("Пароль должен содержать минимум 6 символов.");
        }

        if (!errors.isEmpty()) {
            httpRequest.setAttribute("errors", errors);
            httpRequest.getRequestDispatcher("/WEB-INF/web_page/login.jsp").forward(httpRequest, httpResponse);
            return;
        }

        // Проверка существования пользователя в базе данных с проверкой пароля
        User user = getUserByUsernameAndPassword(username, password);

        if (user != null) {
            // Если пользователь найден, создаем сессию
            HttpSession session = httpRequest.getSession();
            session.setAttribute("user", user);

            // Перенаправляем на главную страницу
            RequestDispatcher dispatcher = httpRequest.getRequestDispatcher("/WEB-INF/web_page/index.jsp");
            dispatcher.forward(httpRequest, httpResponse);
        } else {
            // Если пользователь не найден, перенаправляем на страницу входа с ошибкой
            errors.add("Пользователь с такими данными не существует");
            httpRequest.setAttribute("errors", errors);
            httpRequest.getRequestDispatcher("/WEB-INF/web_page/login.jsp").forward(httpRequest, httpResponse);
        }
    }

    // Метод для получения пользователя по имени и паролю
    private User getUserByUsernameAndPassword(String username, String enteredPassword) {
        try {
            // Запрос для получения всех пользователей с одинаковым именем
            String query = "SELECT * FROM db_quest.users WHERE username = ?";
            try (PreparedStatement stmt = connection.prepareStatement(query)) {
                stmt.setString(1, username);  // Устанавливаем параметр для имени
                ResultSet resultSet = stmt.executeQuery();

                // Проходим по всем пользователям с одинаковым именем
                while (resultSet.next()) {
                    // Получаем хеш пароля из базы данных
                    String storedHash = resultSet.getString("password");

                    // Проверяем введённый пароль с хешем пароля в базе данных
                    if (PasswordUtils.checkPassword(enteredPassword, storedHash)) {
                        String name = resultSet.getString("username");
                        String email = resultSet.getString("email");
                        int status = resultSet.getInt("status_id");

                        // Возвращаем пользователя, если пароли совпадают
                        return new User(name, storedHash, email, status);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();  // Логируем ошибку при запросе к базе данных
        }
        // Если не нашли совпадений
        return null;
    }

    @Override
    public void destroy() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
