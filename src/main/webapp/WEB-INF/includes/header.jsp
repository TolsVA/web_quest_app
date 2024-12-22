<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<header>
    <div class="logo">
        <img src="../../resources/img/logo.png" alt="Логотип">
    </div>
    Добро пожаловать на наш сайт!
    <nav class="nav">
        <a href="#">Главная</a>
        <a href="#">Квесты</a>
        <c:set var="user" value="${sessionScope.user}"/>
        <c:if test="${not empty user}">
            <c:if test="${user.getStatus() == 2}">
                <a href="${pageContext.request.contextPath}/upload_form.jsp">Конструктор квестов</a>
<%--                <a href="${pageContext.request.contextPath}/quest">Конструктор квестов</a>--%>
            </c:if>
        </c:if>
    </nav>
    <nav class="auth">
        <!-- Проверка наличия атрибута "user" в сессии -->
        <c:set var="user" value="${sessionScope.user}"/>
        <c:if test="${not empty user}">
            <!-- Если пользователь авторизован, показываем кнопку Выход -->
            <a href="${pageContext.request.contextPath}/logout">Выход</a>
        </c:if>
        <c:if test="${empty user}">
            <!-- Если пользователь не авторизован, показываем кнопки регистрации и Вход-->
            <a href="${pageContext.request.contextPath}/redirect_servlet?param=register.jsp">Регистрация</a>
            <a href="${pageContext.request.contextPath}/redirect_servlet?param=login.jsp">Вход</a>
        </c:if>
    </nav>
</header>