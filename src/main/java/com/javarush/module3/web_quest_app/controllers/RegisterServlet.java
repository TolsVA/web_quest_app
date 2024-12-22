package com.javarush.module3.web_quest_app.controllers;

import com.javarush.module3.web_quest_app.services.Directs;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "RegisterServlet", value = "/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        Directs.getPathAttributes(req);
        req.getRequestDispatcher("/WEB-INF/web_page/index.jsp").forward(req, resp);
    }
}

