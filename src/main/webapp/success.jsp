<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ru">
<head>
  <meta charset="UTF-8">
  <title>Успешная Регистрация</title>
  <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet"> <!-- Праздничный шрифт -->
  <style>
    body {
      margin: 0;
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      background-color: #87cefa;
      overflow: hidden;
      position: relative;
    }

    .balloon {
      position: absolute;
      height: auto; /* Автоматическая высота для изображения */
      animation: float 5s linear forwards; /* Анимация подъема */
    }

    @keyframes float {
      0% {
        transform: translateY(0);
      }
      100% {
        transform: translateY(-100vh); /* Поднимаем шарик на высоту экрана */
      }
    }

    .card {
      background-image: url('/resources/img/congratulations_card.png');
      background-size: cover;
      width: 600px;
      height: 400px;
      display: flex;
      flex-direction: column; /* Вертикальное выравнивание */
      justify-content: center;
      align-items: center; /* Центрируем контент */
      text-align: center;
      color: black;
      position: relative;
      z-index: 1; /* Чтобы открытка была над шариками */
      padding: 20px;
      border-radius: 15px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
    }

    .congratulations {
      font-family: 'Pacifico', cursive;
      font-size: 30px;
    }

    .countdown {/*отсчет времени */
      font-size: 20px;
      margin-top: 20px;
    }
  </style>
</head>
<body>
<div class="card">
  <div class="congratulations">
  <c:if test="${not empty sessionScope.user}">
    Поздравляем, ${sessionScope.user.name}<br/>
    Вы успешно зарегистрированы!
  </c:if>
  <c:if test="${empty sessionScope.user}">
    Поздравляем, гость<br/>
    Вы успешно зарегистрированы!
  </c:if>

    <div class="countdown" id="countdown">
      Осталось: 10 секунд
    </div>
  </div>
</div>

<script>
  const balloonImages = [
    '/resources/img/balls/ball1.png',
    '/resources/img/balls/ball2.png',
    '/resources/img/balls/ball3.png',
    '/resources/img/balls/ball4.png',
    '/resources/img/balls/ball5.png',
    '/resources/img/balls/ball6.png',
    '/resources/img/balls/ball7.png',
    '/resources/img/balls/ball8.png'
  ];

  function createBalloon() {
    const balloon = document.createElement('img'); // Создаем элемент <img>
    balloon.classList.add('balloon');

    const randomIndex = Math.floor(Math.random() * balloonImages.length);
    balloon.src = balloonImages[randomIndex]; // Устанавливаем путь к изображению
    balloon["style"].left = Math.random() * 100 + 'vw'; // Случайная позиция по горизонтали

    // Генерация случайного размера для шарика: минимум 60px, максимум 90px
    const size = Math.random() * (90 - 60) + 60; // Размер от 60px до 90px
    balloon["style"].width = size + 'px'; // Устанавливаем случайный размер

    balloon["style"].bottom = '0'; // Устанавливаем положение внизу
    document.body.appendChild(balloon);

    // Удаляем шарик после анимации
    balloon.addEventListener('animationend', () => {
      balloon.remove();
    });
  }

  // Создаем шарики каждые 300 мс
  setInterval(createBalloon, 300);

  let countdown = 10; // Начальное значение
  const countdownElement = document.getElementById('countdown');

  const interval = setInterval(() => {
    countdown--; // Уменьшаем на 1 каждую секунду
    countdownElement.textContent = countdown + ' секунд';

    if (countdown <= 0) {
      clearInterval(interval);
      countdownElement.textContent = 'Время вышло!';
      setTimeout(() => {
        window.location.href = 'start';
      }, 2000);
    }
  }, 1000);
</script>
</body>
</html>