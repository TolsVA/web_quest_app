# Используем официальный образ OpenJDK с JDK 22
FROM openjdk:22-jdk-slim

# Устанавливаем Tomcat 10.1.31
ENV TOMCAT_VERSION 10.1.31
ENV CATALINA_HOME /usr/local/tomcat

RUN apt-get update && apt-get install -y \
    curl \
    mysql-client \
    && curl -fsSL "https://downloads.apache.org/tomcat/tomcat-10/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz" -o tomcat.tar.gz \
    && mkdir /usr/local/tomcat \
    && tar -xzf tomcat.tar.gz --strip-components=1 -C /usr/local/tomcat \
    && rm tomcat.tar.gz

# Создаем директорию для хранения WAR файла
RUN mkdir -p /usr/local/tomcat/webapps/

# Копируем WAR файл с вашего хоста в контейнер с правами root
COPY web_quest_app-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/web_quest_app.war

# Устанавливаем MySQL (настройка пароля и установка MySQL-клиента)
RUN apt-get update && apt-get install -y mysql-server

# Устанавливаем MySQL с паролем nsw25899
RUN service mysql start && \
    mysql -e "CREATE DATABASE IF NOT EXISTS web_quest_db;" && \
    mysql -e "CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY 'nsw25899';" && \
    mysql -e "GRANT ALL PRIVILEGES ON web_quest_db.* TO 'root'@'%';"

# Открываем порты для Tomcat и MySQL
EXPOSE 8080 3306

# Запускаем Tomcat и MySQL
CMD service mysql start && $CATALINA_HOME/bin/catalina.sh run
