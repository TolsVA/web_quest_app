<%@ page import="com.javarush.module3.web_quest_app.model.entiti.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Title</title>
    <style>
        body {
            background-image: url('https://fabbofuturos.com.br/wp-content/uploads/2021/09/shutterstock_1076276255-2-scaled.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            min-height: 100vh;
        }

        .container {
            display: flex;
            justify-content: space-around;
        }

        .block {
            width: 160px;
            position: relative;
            text-align: center; /* Центрируем текст внутри блока */
            margin: 50px;
        }

        .hover-area {
            width: 100%; /* Ширина области наведения */
            height: 250px; /* Высота области наведения */
            cursor: pointer;
            text-align: center;
            line-height: 100px; /* Центрирование текста */
        }

        .tooltip {
            position: absolute;
            background-color: #333;
            color: #fff;
            padding: 5px;
            border-radius: 5px;
            white-space: nowrap; /* Не переносить текст */
            z-index: 10;
            display: none; /* Скрываем подсказку по умолчанию */
        }

        .block-image {
            width: 80%; /* Устанавливаем ширину изображения на 100% блока */
            height: auto; /* Сохраняем пропорции изображения */
            margin-top: 10px; /* Отступ сверху для изображения */
            margin-right: 20px;
            border-radius: 5px; /* Закругленные углы для изображения */
            transition: transform 0.3s; /* Плавный переход для эффекта при наведении */
        }

        .block-image:hover {
            transform: scale(3); /* Увеличение логотипа при наведении */
        }
    </style>
</head>
<body>
<main class="main-content">
    <div class="container">
        <div class="main-header">
            <h1>Мы приветствуем тебя, ${sessionScope.user.name}.</h1>
            <h2>На этот раз задача стала более увлекательной — выбор дверей значительно увеличился, и интересно, что
                тебя ждёт впереди.</h2>
            <h3>За каждой дверью ждут новые приключения, полные сюрпризов!</h3>
            <h4>Выбери и открой ту дверь, которая приведёт к твоим мечтам!</h4>
        </div>
    </div>
    <div class="container">
        <div class="block" data-page="0" data-tooltip="Квест: Богатырь и Зачарованный Лес">
            <div class="hover-area">
                <img src="../../../resources/img/bg.png" alt="БОГАТЫРЬ" class="block-image">
            </div>
            <div class="tooltip" style="display: none;"></div>
        </div>
        <div class="block" data-page="page2.jsp" data-tooltip="DEVELOPMENT">
            <div class="hover-area">
                <img src="../../../resources/img/tr.png" alt="Технические работы" class="block-image">
            </div>
            <div class="tooltip" style="display: none;"></div>
        </div>
        <div class="block" data-page="page3.jsp" data-tooltip="DEVELOPMENT">
            <div class="hover-area">
                <img src="../../../resources/img/tr.png" alt="Технические работы" class="block-image">
            </div>
            <div class="tooltip" style="display: none;"></div>
        </div>
        <div class="block" data-page="page4.jsp" data-tooltip="DEVELOPMENT">
            <div class="hover-area">
                <img src="../../../resources/img/tr.png" alt="Технические работы" class="block-image">
            </div>
            <div class="tooltip" style="display: none;"></div>
        </div>
        <div class="block" data-page="page5.jsp" data-tooltip="DEVELOPMENT">
            <div class="hover-area">
                <img src="../../../resources/img/tr.png" alt="Технические работы" class="block-image">
            </div>
            <div class="tooltip" style="display: none;"></div>
        </div>
        <div class="block" data-page="page6.jsp" data-tooltip="DEVELOPMENT">
            <div class="hover-area">
                <img src="../../../resources/img/tr.png" alt="Технические работы" class="block-image">
            </div>
            <div class="tooltip" style="display: none;"></div>
        </div>
        <div class="block" data-page="page7.jsp" data-tooltip="DEVELOPMENT">
            <
            <div class="hover-area">
                <img src="../../../resources/img/tr.png" alt="Технические работы" class="block-image">
            </div>
            <div class="tooltip" style="display: none;"></div>
        </div>
    </div>

</main>
<script>
    const blocks = document.querySelectorAll('.block');

    blocks.forEach((block, index) => {
        const hoverArea = block.querySelector('.hover-area');
        const tooltip = block.querySelector('.tooltip');
        const page = block.getAttribute('data-page');
        const tooltipText = block.getAttribute('data-tooltip');

        // Обработчик наведения
        hoverArea.addEventListener('mouseenter', (event) => {
            tooltip.innerText = tooltipText;
            tooltip.style.display = 'block';
            positionTooltip(event, tooltip, index); // Передаем индекс в функцию
        });

        hoverArea.addEventListener('mousemove', (event) => {
            positionTooltip(event, tooltip, index);
        });

        hoverArea.addEventListener('mouseleave', () => {
            tooltip.style.display = 'none';
        });

        // Обработчик клика
        hoverArea.addEventListener('click', () => {
            // Переход на страницу, которая указана в data-page
            <%--window.location.href = "${pageContext.request.contextPath}/" + page;--%>
            <%--window.location.href = "${pageContext.request.contextPath}/redirect_servlet?param=" + page;--%>
            window.location.href = "${pageContext.request.contextPath}/quest?index=" + page;
        });
    });

    // Функция для позиционирования подсказки с учетом индекса
    function positionTooltip(event, tooltip, index) {
        const tooltipOffsetX = -180; // Смещение вправо
        const tooltipOffsetY = -350; // Смещение вниз

        // Масштабируем отступы в зависимости от индекса
        const offsetCorrection = 240 * (index); // Например, 50px на каждый индекс

        tooltip.style.left = (event.clientX + tooltipOffsetX - offsetCorrection) + 'px';
        tooltip.style.top = (event.clientY + tooltipOffsetY) + 'px';
    }

</script>
</body>
</html>