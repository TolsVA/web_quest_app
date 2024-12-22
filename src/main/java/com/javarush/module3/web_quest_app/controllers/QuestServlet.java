package com.javarush.module3.web_quest_app.controllers;

import com.javarush.module3.web_quest_app.utils.ConnectionDriverManager;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URISyntaxException;
import java.sql.*;
import java.util.HashMap;
import java.util.List;

import java.nio.file.*;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@WebServlet(name = "QuestServlet", value = "/quest")
public class QuestServlet extends HttpServlet {
//    String questHeroAndTheEnchantedForest = """


//    List<String> content = new ArrayList<String>() {{
//        add(questHeroAndTheEnchantedForest);
//    }};

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int index = -1;
        try {
            index = getIndex(req.getParameter("index"));
        } catch (NumberFormatException e) {
            req.setAttribute("errorMessage", "Неверный формат индекса! Пожалуйста, передайте правильное число.");
            RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/web_page/error.jsp");
            dispatcher.forward(req, resp);
            return;
        } catch (RuntimeException e) {
            req.setAttribute("errorMessage", e.getMessage());
            RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/web_page/error.jsp");
            dispatcher.forward(req, resp);
        }

        String content = getContent(index);

        try (PrintWriter out = resp.getWriter()) {
            resp.setContentType("text/html;charset=UTF-8");
            resp.setCharacterEncoding("UTF-8");

            // Если индекс корректен, выводим нужный контент
            out.println(content);
        }
//        displayDirectoriesAndFiles(resp);
    }

    private void displayDirectoriesAndFiles(HttpServletResponse resp) {
        // Устанавливаем тип контента на HTML
        resp.setContentType("text/html; charset=UTF-8");

        // Получаем путь к директории с текстовыми файлами если развёрнуто в WAR
//        Path rootDirectory = Paths.get(getServletContext().getRealPath("/resources/questTxt"));
        Path rootDirectory = null;
        try {
            rootDirectory = Paths.get(Objects.requireNonNull(getClass().getResource("/questTxt")).toURI());
        } catch (URISyntaxException e) {
            throw new RuntimeException(e);
        }
        // Map для хранения каталогов и их текстовых файлов
        Map<String, List<String>> directoriesFilesMap = new HashMap<>();

        // Читаем все подкаталоги в директории, используя try-with-resources для закрытия потока
        try (Stream<Path> paths = Files.walk(rootDirectory)) {
            paths.filter(Files::isDirectory)  // Фильтруем только каталоги
                    .forEach(path -> {
                        try (Stream<Path> list = Files.list(path)){
                            // Получаем имя каталога (без полного пути)
                            String directoryName = path.getFileName().toString();

                            // Получаем все .txt файлы в этом каталоге
                            List<String> txtFiles = list
                                    .filter(p -> p.toString().endsWith(".txt"))  // Фильтруем только текстовые файлы
                                    .map(p -> p.getFileName().toString())  // Получаем только имена файлов
                                    .collect(Collectors.toList());

                            // Если каталог содержит файлы .txt, добавляем его в Map
                            if (!txtFiles.isEmpty()) {
                                directoriesFilesMap.put(directoryName, txtFiles);
                            }
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    });
        } catch (IOException e) {
            e.printStackTrace();
            try {
                resp.getWriter().println("Ошибка при чтении каталога: " + e.getMessage());
            } catch (IOException ex) {
                throw new RuntimeException(ex);
            }
            return;
        }

        // Получаем writer для отправки HTML
        PrintWriter out = null;
        try {
            out = resp.getWriter();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        // Генерация HTML страницы
        out.println("<!DOCTYPE html>");
        out.println("<html lang='ru'>");
        out.println("<head>");
        out.println("<meta charset='UTF-8'>");
        out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
        out.println("<title>Каталоги и текстовые файлы</title>");
        out.println("<style>");
        out.println("body { font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 20px; }");
        out.println("table { width: 100%; border-collapse: collapse; }");
        out.println("th, td { padding: 10px; border: 1px solid #ddd; }");
        out.println("th { background-color: #f2f2f2; }");
        out.println("h1 { text-align: center; }");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");

        out.println("<h1>Список каталогов и текстовых файлов</h1>");

        // Если в Map есть данные, выводим таблицу
        if (!directoriesFilesMap.isEmpty()) {
            out.println("<table>");
            out.println("<thead><tr><th>Каталог</th><th>Текстовые файлы</th></tr></thead>");
            out.println("<tbody>");
            // Итерируем по Map и выводим каталог и список файлов
            for (Map.Entry<String, List<String>> entry : directoriesFilesMap.entrySet()) {
                out.println("<tr>");
                out.println("<td>" + entry.getKey() + "</td>");
                out.println("<td>");
                out.println("<ul>");
                // Для каждого каталога выводим список файлов
                for (String fileName : entry.getValue()) {
                    out.println("<li>" + fileName + "</li>");
                }
                out.println("</ul>");
                out.println("</td>");
                out.println("</tr>");
            }
            out.println("</tbody>");
            out.println("</table>");
        } else {
            out.println("<p>Нет доступных каталогов с текстовыми файлами.</p>");
        }

        out.println("</body>");
        out.println("</html>");
    }

    private String getContent(int id) {
        String content;
        String query = "SELECT * FROM db_quest.content_jsp WHERE id = ?"; // Мы будем искать элемент по индексу (id)

        try (
                Connection conn = ConnectionDriverManager.open();
                PreparedStatement stmt = conn.prepareStatement(query)
        ) {

            // Устанавливаем параметр запроса (например, ищем элемент с id = 2)
            stmt.setInt(1, id); // Это установит id для поиска

            // Выполняем запрос
            ResultSet rs = stmt.executeQuery();
            // Если данные найдены
            if (rs.next()) {
                content = rs.getString("content");
            } else {
                content = "Запись не найдена.";
            }

        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        return content;
    }

    private int getIndex(String indexStr) throws NumberFormatException {
        int index = Integer.parseInt(indexStr);
        if (index < 0 || index > 6) throw new RuntimeException("index должен содержать значения от 0 до 6");
        return index + 1;
    }
}
