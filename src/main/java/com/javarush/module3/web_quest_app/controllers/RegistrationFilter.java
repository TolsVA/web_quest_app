package com.javarush.module3.web_quest_app.controllers;

import com.javarush.module3.web_quest_app.db.DatabaseInitializer;
import com.javarush.module3.web_quest_app.model.entiti.User;
import com.javarush.module3.web_quest_app.utils.ConnectionDriverManager;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebFilter("/register")
public class RegistrationFilter implements Filter {
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
        String email = httpRequest.getParameter("email");

        String statusParam = httpRequest.getParameter("status");
        int status = (statusParam != null && !statusParam.isEmpty()) ? Integer.parseInt(statusParam) : 1;

        // Создаем объект User с новыми параметрами
        User user = new User(username, password, email, status);

        // Проверка на ошибки ввода
        List<String> errors = getListErrors(user);

        if (!errors.isEmpty()) {
            httpRequest.setAttribute("errors", errors);
            httpRequest.getRequestDispatcher("/WEB-INF/web_page/register.jsp").forward(httpRequest, httpResponse);
            return;
        }

        // Хешируем пароль перед сохранением
        String hashedPassword = hashPassword(user.getPassword());
        user.setPassword(hashedPassword);

        // Если статус "Администратор", проверяем пароль администратора
        if (status == 2) {
            String adminPassword = httpRequest.getParameter("adminPassword");
            if (adminPassword == null || !isValidAdminPassword(adminPassword)) {
                // Если пароль неверный, выводим ошибку и оставляем на странице регистрации
                List<String> adminErrors = new ArrayList<>();
                adminErrors.add("Неверный пароль администратора.");
                httpRequest.setAttribute("errors", adminErrors);
                httpRequest.getRequestDispatcher("/WEB-INF/web_page/confirm_admin.jsp").forward(httpRequest, httpResponse);
                return;
            }
        }

        // Сохраняем пользователя в базе данных
        try {
            saveToDatabase(user);
        } catch (RuntimeException e) {
            List<String> saveErrors = new ArrayList<>();
            saveErrors.add(e.getMessage());
            httpRequest.setAttribute("errors", saveErrors);
            httpRequest.getRequestDispatcher("/WEB-INF/web_page/register.jsp").forward(httpRequest, httpResponse);
            return;
        }

        // Сохраняем пользователя в сессии
        HttpSession session = httpRequest.getSession();
        session.setAttribute("user", user);  // Сохраняем пользователя в сессии

        // Перенаправляем на главную страницу
        httpResponse.sendRedirect("success.jsp");
    }

    private boolean isValidAdminPassword(String adminPassword) {
        // Здесь должен быть код для проверки пароля администратора
        String correctAdminPassword = "adminPassword123"; // Заглушка
        return adminPassword.equals(correctAdminPassword);
    }

    private void saveToDatabase(User user) {
        try {
            String sql = "INSERT INTO db_quest.users (username, password, email, status_id) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, user.getName());
            stmt.setString(2, user.getPassword()); // Хешированный пароль
            stmt.setString(3, user.getEmail());
            stmt.setInt(4, user.getStatus());
            stmt.executeUpdate();

            stmt.close();
        } catch (Exception e) {
            throw new RuntimeException("Ошибка при сохранении пользователя в базе данных: " + e.getMessage());
        }
    }

    private List<String> getListErrors(User user) {
        List<String> errors = new ArrayList<>();
        if (user.getName() == null || user.getName().isEmpty()) {
            errors.add("Имя пользователя не может быть пустым.");
        }
        if (user.getPassword() == null || user.getPassword().length() < 6) {
            errors.add("Пароль должен содержать минимум 6 символов.");
        }
        if (user.getEmail() == null || !user.getEmail().matches("^[^@]+@[^@]+\\.[^@]+$")) {
            errors.add("Некорректный email.");
        }

        try {
            Statement statement = connection.createStatement();
            if (userExists(statement, user.getName(), user.getEmail())) {
                errors.add("Пользователь с таким логином или email уже существует.");
            }
        } catch (SQLException e) {
            throw new RuntimeException("Ошибка при проверке существования пользователя: " + e.getMessage());
        }
        return errors;
    }

    private boolean userExists(Statement statement, String username, String email) throws SQLException {
        String query = "SELECT COUNT(*) FROM db_quest.users WHERE username = ? OR email = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, username);
            stmt.setString(2, email);
            ResultSet resultSet = stmt.executeQuery();

            if (resultSet.next()) {
                int count = resultSet.getInt(1);
                return count > 0;
            }
        }
        return false;
    }

    private String hashPassword(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt());
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