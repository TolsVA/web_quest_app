<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Ошибка</title>
</head>
<body>
<h1>Произошла ошибка</h1>
<p style="color:red;">${errorMessage}</p> <!-- Отображаем сообщение об ошибке -->
<a href="javascript:history.back()">Вернуться назад</a> <!-- Ссылка для возврата -->
</body>
</html>

