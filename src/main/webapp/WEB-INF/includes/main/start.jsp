<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<main class="main-content">
    <div class="container">
        <div class="main-header">
            <c:if test="${not empty sessionScope.user}">
                <h1>Добро пожаловать, ${sessionScope.user.name}! Здесь ты можешь погрузиться в мир невероятных приключений!</h1>
            </c:if>
            <c:if test="${empty sessionScope.user}">
                <h1>Здесь ты можешь погрузиться в мир невероятных приключений!</h1>
            </c:if>

            <h2>Присоединяйся к нам и начни свой путь!</h2>
            <h3>Не бойся трудных решений — они открывают новые горизонты.</h3>
            <h4>Открой эту дверь и узнай, что ждёт за ней!</h4>
        </div>

        <div class="hover-area" id="hoverArea"></div>

        <c:if test="${not empty sessionScope.user}">
            <div class="tooltip" id="tooltip">
                    ${sessionScope.user.name}, ты можешь войти в эту дверь просто кликни по ней.
            </div>
        </c:if>
        <c:if test="${empty sessionScope.user}">
            <div class="tooltip" id="tooltip">
                Чтобы открыть эту дверь войдите в систему как зарегистрированный пользователь!
            </div>
        </c:if>
    </div>
</main>

<script>
    const hoverArea = document.querySelector('.hover-area');
    const tooltip = document.getElementById('tooltip');

    hoverArea.addEventListener('mouseenter', (event) => {
        tooltip["style"].display = 'block';
        tooltip["style"].left = event.clientX + 'px';
        tooltip["style"].top = event.clientY + 'px';
    });

    hoverArea.addEventListener('mousemove', (event) => {
        tooltip["style"].left = event.clientX + 'px';
        tooltip["style"].top = (event.clientY + 20) + 'px'; // смещение вниз от курсора
    });

    hoverArea.addEventListener('mouseleave', () => {
        tooltip["style"].display = 'none';
    });

    hoverArea.addEventListener('click', () => {
        // Используем JSTL для безопасного получения данных пользователя
        let user = '<c:out value="${sessionScope.user != null ? sessionScope.user.name : ''}"/>';

        if (user) {
            window.location.href = "${pageContext.request.contextPath}/start?key_file=includePath&" +
                "value_file=/WEB-INF/includes/main/main_entrance.jsp";
        } else {
            <%--window.location.href = "${pageContext.request.contextPath}/upload_form.jsp";--%>
            window.location.href = "${pageContext.request.contextPath}/redirect_servlet?param=login.jsp";
        }
    });
</script>
