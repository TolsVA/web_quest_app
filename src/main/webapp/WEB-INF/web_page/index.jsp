<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="com.javarush.module3.web_quest_app.model.dependency.MyBean" %>
<%request.setAttribute("myBean", MyBean.getInstance());%>
<!DOCTYPE html>
<html lang="ru">
<head>
    <jsp:include page="links.jsp"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Главная страница</title>
</head>
<body>
<jsp:include page="../includes/header.jsp"/>
<br>
<div id="content">
    <c:forEach var="entry" items="${myBean.values}">
        <c:if test="${entry.key == 'includePath'}">
            <c:set var="includePath" value="${entry.value}" />
        </c:if>
    </c:forEach>
    <c:choose>
        <c:when test="${not empty includePath}">
            <jsp:include page="${includePath}" />
        </c:when>
        <c:otherwise>
            <p>Включаемый файл не найден.</p>
        </c:otherwise>
    </c:choose>
</div>
<jsp:include page="../includes/footer.jsp"/>
</body>
</html>
