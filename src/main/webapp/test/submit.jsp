<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Результат</title>
</head>
<body>
<h1>Спасибо за ваше сообщение!</h1>
<p>Ваше имя: <%= request.getParameter("name") %></p>
</body>
</html>

