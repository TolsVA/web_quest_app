package com.javarush.module3.web_quest_app.controllers;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.nio.file.Paths;
import java.util.Collection;

@WebServlet("/add_quest")
@MultipartConfig
public class AddQuestServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Получаем все загруженные части файла
        Collection<Part> parts = request.getParts();

        for (Part part : parts) {
            String fileName = part.getSubmittedFileName();

            // Проверяем, что это текстовый файл
            if (fileName != null && fileName.endsWith(".txt")) {
                // Считываем содержимое файла в строку
                String fileContent = readFileContent(part);

//                // Здесь файл сохранён в переменной fileContent. Вы можете использовать эту строку по своему усмотрению.
//                // Например, сохраняем в атрибут запроса для дальнейшей обработки.
//                request.setAttribute("fileContent", fileContent);
//
//                // Отправляем подтверждение клиенту
//                response.getWriter().write("Файл загружен и обработан.");

                try (PrintWriter out = response.getWriter()) {
                    response.setContentType("text/html;charset=UTF-8");
                    response.setCharacterEncoding("UTF-8");

                    // Если индекс корректен, выводим нужный контент
                    out.println(fileContent);

//                    RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/web_page/quest.jsp");  // Перенаправляем на страницу успеха
//                    dispatcher.forward(request, response);
                }
            } else {
                response.getWriter().write("Ошибка: файл должен быть в формате .txt.");
            }
        }
    }

    private String readFileContent(Part part) throws IOException {
        // Используем BufferedReader для чтения файла
        StringBuilder content = new StringBuilder();

        try (BufferedReader reader = new BufferedReader(new InputStreamReader(part.getInputStream(), StandardCharsets.UTF_8))) {
            String line;
            while ((line = reader.readLine()) != null) {
                content.append(line).append("\n");
            }
        }

        return content.toString();
    }
}
