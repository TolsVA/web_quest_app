<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ru">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Загрузка файла</title>
  <style>
    .drop-area {
      width: 100%;
      height: 200px;
      border: 2px dashed #ccc;
      border-radius: 10px;
      display: flex;
      justify-content: center;
      align-items: center;
      text-align: center;
      font-size: 18px;
      color: #888;
      background-color: #f9f9f9;
    }
    .drop-area.dragover {
      background-color: #e0e0e0;
      border-color: #666;
    }
    .error {
      color: red;
      font-size: 14px;
    }

    .form-container {
      margin-bottom: 20px;
    }
  </style>
</head>
<body>
<div class="form-container">
<h1>Загрузите файл</h1>
<div class="drop-area" id="drop-area">
  Перетащите ваш файл сюда
</div>
<div class="error" id="error-message"></div>

<form id="fileForm" action="add_quest" method="post" enctype="multipart/form-data" style="display: none;">
  <input type="file" name="file" id="fileInput" accept=".txt">
</form>
</div>

<!-- Форма для ввода информации о квесте -->
<div class="form-container">
  <h2>Информация о квесте</h2>
  <form id="questInfoForm" action="add_quest_info" method="post">
    <div class="form-field">
      <label for="questName">Название квеста:</label>
      <input type="text" id="questName" name="questName" required>
    </div>

    <div class="form-field">
      <label for="levelCount">Количество уровней:</label>
      <input type="number" id="levelCount" name="levelCount" min="1" required>
    </div>

    <div class="form-field">
      <label for="scenarioCount">Количество сценариев на каждом уровне:</label>
      <input type="number" id="scenarioCount" name="scenarioCount" min="1" required>
    </div>

    <button type="submit">Отправить информацию о квесте</button>
  </form>
</div>
<script>
  const dropArea = document.getElementById('drop-area');
  const fileInput = document.getElementById('fileInput');
  const errorMessage = document.getElementById('error-message');

  dropArea.addEventListener('dragover', (e) => {
    e.preventDefault();
    dropArea.classList.add('dragover');
  });

  dropArea.addEventListener('dragleave', () => {
    dropArea.classList.remove('dragover');
  });

  dropArea.addEventListener('drop', (e) => {
    e.preventDefault();
    dropArea.classList.remove('dragover');

    const file = e.dataTransfer.files[0];

    if (file && file.name.endsWith('.txt')) {
      // Clear any previous error messages
      errorMessage.textContent = '';
      // Set the file input to the dropped file
      fileInput.files = e.dataTransfer.files;
      // Submit the form
      document.getElementById('fileForm').submit();
    } else {
      // Show error message if the file is not .txt
      errorMessage.textContent = 'Ошибка: Загрузите файл в формате .txt';
    }
  });

  fileInput.addEventListener('change', () => {
    const file = fileInput.files[0];
    if (file && !file.name.endsWith('.txt')) {
      errorMessage.textContent = 'Ошибка: Загрузите файл в формате .txt';
    }
  });
</script>
</body>
</html>
