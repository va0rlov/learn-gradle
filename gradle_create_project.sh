#!/bin/bash

# Проверка наличия аргумента (названия проекта)
if [ -z "$1" ]; then
  echo "Использование: $0 <название_проекта>"
  exit 1
fi

PROJECT_NAME=$1

# Создание директорий
mkdir -p $PROJECT_NAME/src/main/java
mkdir -p $PROJECT_NAME/src/main/resources
mkdir -p $PROJECT_NAME/src/test/java
mkdir -p $PROJECT_NAME/src/test/resources

# Создание файла build.gradle
cat <<EOL > $PROJECT_NAME/build.gradle
plugins {
    id 'java'
}

group 'com.example'
version '1.0-SNAPSHOT'

sourceCompatibility = '11'
targetCompatibility = '11'

repositories {
    mavenCentral()
}

dependencies {
    // Здесь можно добавить зависимости
}
EOL

# Создание примера класса Main
cat <<EOL > $PROJECT_NAME/src/main/java/Main.java
public class Main {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}
EOL

echo "Проект $PROJECT_NAME успешно создан!"

# Переход в директорию проекта
cd $PROJECT_NAME

# Создание Gradle Wrapper
echo "Создание Gradle Wrapper..."
gradle wrapper --gradle-version 8.11.1

# Сборка проекта с помощью Gradle Wrapper
echo "Сборка проекта..."
./gradlew clean build

# Запуск проекта
echo "Запуск проекта $PROJECT_NAME..."
java -cp build/classes/java/main Main

# Возврат в исходную директорию
cd ..

echo "Проект $PROJECT_NAME успешно запущен!"
