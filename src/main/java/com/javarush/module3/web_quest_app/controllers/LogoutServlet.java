package com.javarush.module3.web_quest_app.controllers;

import com.javarush.module3.web_quest_app.services.Directs;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Получаем текущую сессию, если она существует
        if (session != null) {
            session.invalidate(); // Завершаем сессию
        }
        Directs.getPathAttributes(request);
        request.getRequestDispatcher("/WEB-INF/web_page/index.jsp").forward(request, response);
    }
}

