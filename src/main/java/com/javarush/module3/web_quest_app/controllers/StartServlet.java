package com.javarush.module3.web_quest_app.controllers;

import com.javarush.module3.web_quest_app.services.Directs;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "StartServlet", value = "/start")
public class StartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Directs.getPathAttributes(req);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/web_page/index.jsp");
        dispatcher.forward(req, resp);
    }
}