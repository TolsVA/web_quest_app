package com.javarush.module3.web_quest_app.controllers;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;


@WebServlet(name = "RedirectServlet", value = "/redirect_servlet")
public class RedirectServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Получаем имя JSP файла, на который нужно перейти
        String targetPage = req.getParameter("param");

        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/web_page/" + targetPage);
        dispatcher.forward(req, resp);
    }
}