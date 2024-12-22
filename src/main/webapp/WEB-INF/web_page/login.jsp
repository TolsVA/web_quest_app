<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Вход</title>
    <link rel="stylesheet" type="text/css" href="../../styles/register.css">
</head>
<body>
<div class="container">
    <form action="login" method="post" class="form">
        <h1>Вход</h1>
        <label for="username">Имя пользователя</label>
        <input type="text" id="username" name="username" required autocomplete="off">

        <label for="password">Пароль</label>
        <input type="password" id="password" name="password" required autocomplete="new-password">

        <input id="submit" type="submit" class="button" value="Войти">
        <p class="message">Нет аккаунта?
            <a href="${pageContext.request.contextPath}/redirect_servlet?param=register.jsp">Зарегистрироваться</a>
        </p>
    </form>
    <c:if test="${not empty requestScope.errors}">
        <div style="color: red; font-size: 12px">
            <c:forEach var ="error" items="${requestScope.errors}">
                <span>${error}</span>
                <br>
            </c:forEach>
        </div>
    </c:if>
</div>
</body>
</html>
