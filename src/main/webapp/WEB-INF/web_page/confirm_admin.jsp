<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ru">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Подтверждение статуса администратора</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f9;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }

    .login-container {
      background-color: white;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      width: 300px;
      box-sizing: border-box;
    }

    h2 {
      text-align: center;
    }

    input[type="password"], input[type="submit"] {
      width: 100%;
      padding: 10px;
      margin: 10px 0;
      border-radius: 4px;
      box-sizing: border-box;
    }

    input[type="password"], input[type="submit"] {
      border: 1px solid #ccc;
    }

    input[type="submit"] {
      background-color: #4CAF50;
      color: white;
      font-size: 16px;
      border: none;
    }

    input[type="submit"]:hover {
      background-color: #45a049;
    }

    .error {
      color: red;
      font-size: 14px;
      text-align: center;
    }
  </style>
</head>
<body>
<div class="login-container">
  <h2>Подтверждение статуса администратора</h2>
  <form action="register" method="post">
    <label for="adminPassword">Введите пароль администратора:</label>
    <input type="password" id="adminPassword" name="adminPassword" required>

    <input type="hidden" name="username" value="${param.username}">
    <input type="hidden" name="password" value="${param.password}">
    <input type="hidden" name="email" value="${param.email}">
    <input type="hidden" name="status" value="${param.status}">

    <input type="submit" value="Подтвердить">

    <!-- Ошибка, если пароль неверный -->
    <c:if test="${not empty requestScope.errorMessage}">
      <div class="error">${requestScope.errorMessage}</div>
    </c:if>
  </form>

  <button class="back-button" onclick="window.location.href='${pageContext.request.contextPath}/redirect_servlet?param=register.jsp';">Назад</button>
</div>
</body>
</html>




<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<!DOCTYPE html>--%>
<%--<html lang="ru">--%>
<%--<head>--%>
<%--  <meta charset="UTF-8">--%>
<%--  <meta name="viewport" content="width=device-width, initial-scale=1.0">--%>
<%--  <title>Вход администратора</title>--%>
<%--  <style>--%>
<%--    body {--%>
<%--      font-family: Arial, sans-serif;--%>
<%--      background-color: #f4f4f9;--%>
<%--      display: flex;--%>
<%--      justify-content: center;--%>
<%--      align-items: center;--%>
<%--      height: 100vh;--%>
<%--      margin: 0;--%>
<%--    }--%>

<%--    .login-container {--%>
<%--      background-color: white;--%>
<%--      padding: 30px;--%>
<%--      border-radius: 8px;--%>
<%--      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);--%>
<%--      width: 300px;--%>
<%--      box-sizing: border-box;--%>
<%--    }--%>

<%--    h2 {--%>
<%--      text-align: center;--%>
<%--    }--%>

<%--    input[type="password"], input[type="submit"], .back-button {--%>
<%--      width: 100%;--%>
<%--      padding: 10px;--%>
<%--      margin: 10px 0;--%>
<%--      border-radius: 4px;--%>
<%--      box-sizing: border-box;--%>
<%--    }--%>

<%--    input[type="password"], input[type="submit"] {--%>
<%--      border: 1px solid #ccc;--%>
<%--    }--%>

<%--    input[type="submit"] {--%>
<%--      background-color: #4CAF50;--%>
<%--      color: white;--%>
<%--      font-size: 16px;--%>
<%--      border: none;--%>
<%--    }--%>

<%--    input[type="submit"]:hover {--%>
<%--      background-color: #45a049;--%>
<%--    }--%>

<%--    .back-button {--%>
<%--      background-color: #f44336;--%>
<%--      color: white;--%>
<%--      font-size: 16px;--%>
<%--      border: none;--%>
<%--    }--%>

<%--    .back-button:hover {--%>
<%--      background-color: #e53935;--%>
<%--    }--%>

<%--    .error {--%>
<%--      color: red;--%>
<%--      font-size: 14px;--%>
<%--      text-align: center;--%>
<%--    }--%>
<%--  </style>--%>
<%--</head>--%>
<%--<body>--%>
<%--<div class="login-container">--%>
<%--  <h2>Вход администратора</h2>--%>
<%--  <form action="register" method="POST">--%>
<%--    <label for="password">Введите пароль администратора:</label>--%>
<%--    <input type="password" id="password" name="adminPassword" required>--%>
<%--    <input type="submit" value="Подтвердить">--%>
<%--  </form>--%>

<%--  <!-- Ошибка, если не правильный пароль администратора -->--%>
<%--  <c:if test="${not empty errorMessage}">--%>
<%--    <div class="error">${errorMessage}</div>--%>
<%--  </c:if>--%>

<%--  <!-- Кнопка "Назад", которая перенаправляет на страницу регистрации -->--%>
<%--  <button class="back-button" onclick="window.location.href='${pageContext.request.contextPath}/redirect_servlet?param=register.jsp';">Назад</button>--%>
<%--</div>--%>
<%--</body>--%>
<%--</html>--%>



<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<!DOCTYPE html>--%>
<%--<html lang="ru">--%>
<%--<head>--%>
<%--  <meta charset="UTF-8">--%>
<%--  <meta name="viewport" content="width=device-width, initial-scale=1.0">--%>
<%--  <title>Вход администратора</title>--%>
<%--  <style>--%>
<%--    body {--%>
<%--      font-family: Arial, sans-serif;--%>
<%--      background-color: #f4f4f9;--%>
<%--      display: flex;--%>
<%--      justify-content: center;--%>
<%--      align-items: center;--%>
<%--      height: 100vh;--%>
<%--      margin: 0;--%>
<%--    }--%>

<%--    .login-container {--%>
<%--      background-color: white;--%>
<%--      padding: 30px;--%>
<%--      border-radius: 8px;--%>
<%--      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);--%>
<%--      width: 300px;--%>
<%--      box-sizing: border-box; /* Учитываем padding и border в расчете ширины */--%>
<%--    }--%>

<%--    h2 {--%>
<%--      text-align: center;--%>
<%--    }--%>

<%--    /* Универсальные стили для всех элементов ввода и кнопок */--%>
<%--    input[type="password"], input[type="submit"], .back-button {--%>
<%--      width: 100%; /* Задаем одинаковую ширину */--%>
<%--      padding: 10px;--%>
<%--      margin: 10px 0;--%>
<%--      border-radius: 4px;--%>
<%--      box-sizing: border-box; /* Чтобы padding и border учитывались в ширине */--%>
<%--    }--%>

<%--    input[type="password"], input[type="submit"] {--%>
<%--      border: 1px solid #ccc;--%>
<%--    }--%>

<%--    input[type="submit"] {--%>
<%--      background-color: #4CAF50;--%>
<%--      color: white;--%>
<%--      font-size: 16px;--%>
<%--      border: none;--%>
<%--    }--%>

<%--    input[type="submit"]:hover {--%>
<%--      background-color: #45a049;--%>
<%--    }--%>

<%--    .back-button {--%>
<%--      background-color: #f44336;--%>
<%--      color: white;--%>
<%--      font-size: 16px;--%>
<%--      border: none;--%>
<%--    }--%>

<%--    .back-button:hover {--%>
<%--      background-color: #e53935;--%>
<%--    }--%>

<%--    .error {--%>
<%--      color: red;--%>
<%--      font-size: 14px;--%>
<%--      text-align: center;--%>
<%--    }--%>
<%--  </style>--%>
<%--</head>--%>
<%--<body>--%>
<%--<div class="login-container">--%>
<%--  <h2>Вход администратора</h2>--%>
<%--  <form action="admin_login" method="POST">--%>
<%--    <label for="password">Введите пароль:</label>--%>
<%--    <input type="password" id="password" name="password" required>--%>
<%--    <input type="submit" value="Войти">--%>
<%--  </form>--%>

<%--  <!-- Вывод ошибки, если она была передана из сервлета -->--%>
<%--  <c:if test="${not empty errorMessage}">--%>
<%--    <div class="error">${errorMessage}</div>--%>
<%--  </c:if>--%>

<%--  <!-- Кнопка "Назад", которая перенаправляет на указанную страницу -->--%>
<%--  <button class="back-button" onclick="window.location.href='${pageContext.request.contextPath}/redirect_servlet?param=register.jsp';">Назад</button>--%>
<%--</div>--%>
<%--</body>--%>
<%--</html>--%>