<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Регистрация</title>
    <link rel="stylesheet" type="text/css" href="../../styles/register.css">
</head>
<body>
<div class="container">
    <form action="<c:choose>
                    <c:when test="${param.status == '2'}">confirm_admin.jsp</c:when>
                    <c:otherwise>register</c:otherwise>
                  </c:choose>" method="post" class="form">
        <h1>Регистрация</h1>

        <label for="username">Имя пользователя</label>
        <input type="text" id="username" name="username" required autocomplete="off" value="${param.username}">

        <label for="password">Пароль</label>
        <input type="password" id="password" name="password" required autocomplete="new-password" value="${param.password}">

        <label for="email">Email</label>
        <input type="email" id="email" name="email" required autocomplete="off" value="${param.email}">

        <!-- Динамическое поле для выбора статуса -->
        <label for="status">Статус</label>
        <select name="status" id="status">
            <option value="1" <c:if test="${param.status == '1'}">selected</c:if>>User</option>
            <option value="2" <c:if test="${param.status == '2'}">selected</c:if>>Administrator</option>
        </select>

        <!-- Добавляем пространство между статусом и кнопкой -->
        <div style="margin-bottom: 20px;"></div>

        <input id="submit" type="submit" class="button" value="Зарегистрироваться">

        <p class="message">Уже есть аккаунт? <a href="${pageContext.request.contextPath}/redirect_servlet?param=login.jsp">Войти</a></p>
    </form>

    <!-- Ошибки, если они есть -->
    <c:if test="${not empty requestScope.errors}">
        <div style="color: red; font-size: 12px">
            <c:forEach var="error" items="${requestScope.errors}">
                <span>${error}</span>
                <br>
            </c:forEach>
        </div>
    </c:if>
</div>
</body>
</html>






<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>--%>
<%--<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>--%>
<%--<!DOCTYPE html>--%>
<%--<html lang="ru">--%>
<%--<head>--%>
<%--    <meta charset="UTF-8">--%>
<%--    <meta name="viewport" content="width=device-width, initial-scale=1.0">--%>
<%--    <title>Регистрация</title>--%>
<%--    <link rel="stylesheet" type="text/css" href="../../styles/register.css">--%>
<%--</head>--%>
<%--<body>--%>
<%--<div class="container">--%>
<%--    <form action="register" method="post" class="form">--%>
<%--        <h1>Регистрация</h1>--%>

<%--        <label for="username">Имя пользователя</label>--%>
<%--        <input type="text" id="username" name="username" required autocomplete="off">--%>

<%--        <label for="password">Пароль</label>--%>
<%--        <input type="password" id="password" name="password" required autocomplete="new-password">--%>

<%--        <label for="email">Email</label>--%>
<%--        <input type="email" id="email" name="email" required autocomplete="off">--%>

<%--        <!-- Динамическое поле для выбора статуса -->--%>
<%--        <label for="status">Статус</label>--%>
<%--        <select name="status" id="status">--%>
<%--            <!-- Статус по умолчанию - User -->--%>
<%--            <option value="1" <c:if test="${empty param.status or param.status == 1}">selected</c:if>>User</option>--%>
<%--            <option value="2" <c:if test="${param.status == 2}">selected</c:if>>Administrator</option>--%>
<%--        </select>--%>

<%--        <!-- Добавляем пространство между статусом и кнопкой -->--%>
<%--        <div style="margin-bottom: 20px;"></div>--%>

<%--        <input id="submit" type="submit" class="button" value="Зарегистрироваться">--%>

<%--        <p class="message">Уже есть аккаунт? <a href="${pageContext.request.contextPath}/redirect_servlet?param=login.jsp">Войти</a></p>--%>
<%--    </form>--%>

<%--    <!-- Ошибки, если они есть -->--%>
<%--    <c:if test="${not empty requestScope.errors}">--%>
<%--        <div style="color: red; font-size: 12px">--%>
<%--            <c:forEach var="error" items="${requestScope.errors}">--%>
<%--                <span>${error}</span>--%>
<%--                <br>--%>
<%--            </c:forEach>--%>
<%--        </div>--%>
<%--    </c:if>--%>
<%--</div>--%>
<%--</body>--%>
<%--</html>--%>





<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>--%>
<%--<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>--%>
<%--<!DOCTYPE html>--%>
<%--<html lang="ru">--%>
<%--<head>--%>
<%--    <meta charset="UTF-8">--%>
<%--    <meta name="viewport" content="width=device-width, initial-scale=1.0">--%>
<%--    <title>Регистрация</title>--%>
<%--    <link rel="stylesheet" type="text/css" href="../../styles/register.css">--%>
<%--</head>--%>
<%--<body>--%>
<%--<div class="container">--%>
<%--    <form action="register" method="post" class="form">--%>
<%--        <h1>Регистрация</h1>--%>

<%--        <label for="username">Имя пользователя</label>--%>
<%--        <input type="text" id="username" name="username" required autocomplete="off">--%>

<%--        <label for="password">Пароль</label>--%>
<%--        <input type="password" id="password" name="password" required autocomplete="new-password">--%>

<%--        <label for="email">Email</label>--%>
<%--        <input type="email" id="email" name="email" required autocomplete="off">--%>

<%--        <!-- Динамическое поле для выбора статуса -->--%>
<%--        <label for="status">Статус</label>--%>
<%--        <select name="status" id="status">--%>
<%--            <!-- Статус по умолчанию - user -->--%>
<%--            <option value="1" <c:if test="${status == 1}">selected</c:if>>User</option>--%>
<%--            <option value="2" <c:if test="${status == 2}">selected</c:if>>Administrator</option>--%>
<%--            <option value="3" <c:if test="${status == 3}">selected</c:if>>Blocked</option>--%>
<%--        </select>--%>

<%--        <input id="submit" type="submit" class="button" value="Зарегистрироваться">--%>

<%--        <p class="message">Уже есть аккаунт? <a href="${pageContext.request.contextPath}/redirect_servlet?param=login.jsp">Войти</a></p>--%>
<%--    </form>--%>

<%--    <!-- Ошибки, если они есть -->--%>
<%--    <c:if test="${not empty requestScope.errors}">--%>
<%--        <div style="color: red; font-size: 12px">--%>
<%--            <c:forEach var="error" items="${requestScope.errors}">--%>
<%--                <span>${error}</span>--%>
<%--                <br>--%>
<%--            </c:forEach>--%>
<%--        </div>--%>
<%--    </c:if>--%>

<%--    <!-- Кнопка для перехода на страницу администратора -->--%>
<%--    <div class="button-container">--%>
<%--        <button class="status-button" onclick="window.location.href='${pageContext.request.contextPath}/confirm_admin.jsp'">Получить статус администратора</button>--%>
<%--    </div>--%>
<%--</div>--%>
<%--</body>--%>
<%--</html>--%>