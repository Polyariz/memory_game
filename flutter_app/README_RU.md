# Memory Game (Flutter) 🎴

Игра на память, портированная с C++ Windows Forms на Flutter/Dart.

![Игра Memory Game](https://github.com/Panquesito7/memory-game/assets/51391473/881ef6ca-4c4c-4187-ad5a-cc1b6946e73e)

## Описание

Memory Game - это классическая игра на запоминание, где вам нужно найти пары одинаковых букв. Игра содержит:
- 10 кнопок (5 пар)
- 5 различных букв с уникальными цветами
- Счетчик найденных пар
- Возможность перезапуска игры

## Требования

- Flutter SDK 3.0.0 или выше
- Dart SDK 3.0.0 или выше
- Visual Studio Code или Android Studio (рекомендуется)

## Установка

### 1. Установка Flutter

Если Flutter еще не установлен на вашей системе:

#### Windows
```bash
# Скачайте Flutter SDK с официального сайта
# https://docs.flutter.dev/get-started/install/windows

# Распакуйте архив и добавьте в PATH:
# C:\flutter\bin
```

#### Linux/MacOS
```bash
# Скачайте Flutter SDK
git clone https://github.com/flutter/flutter.git -b stable

# Добавьте Flutter в PATH
export PATH="$PATH:`pwd`/flutter/bin"

# Проверьте установку
flutter doctor
```

### 2. Установка проекта

```bash
# Перейдите в директорию проекта
cd flutter_app

# Установите зависимости
flutter pub get

# Проверьте, что все настроено корректно
flutter doctor
```

## Запуск приложения

### На эмуляторе/симуляторе

```bash
# Запустите эмулятор Android или симулятор iOS
# Затем выполните команду:
flutter run
```

### На реальном устройстве

```bash
# Подключите устройство через USB
# Включите режим разработчика на устройстве
# Выполните команду:
flutter run
```

### На Desktop (Windows/Linux/MacOS)

```bash
# Запуск на текущей платформе
flutter run -d windows   # для Windows
flutter run -d linux     # для Linux
flutter run -d macos     # для MacOS
```

### В веб-браузере

```bash
flutter run -d chrome
```

## Использование в Visual Studio Code

### Установка расширений

1. Откройте VS Code
2. Установите расширения:
   - Flutter (от Dart Code)
   - Dart (от Dart Code)

### Запуск из VS Code

1. Откройте папку `flutter_app` в VS Code
2. Нажмите `F5` или выберите `Run > Start Debugging`
3. Выберите устройство для запуска (эмулятор, браузер, desktop)

### Горячая перезагрузка

Во время работы приложения:
- Нажмите `r` в терминале для горячей перезагрузки (hot reload)
- Нажмите `R` для полного перезапуска (hot restart)
- Нажмите `q` для выхода

## Структура проекта

```
flutter_app/
├── lib/
│   ├── main.dart                    # Точка входа приложения
│   ├── models/
│   │   └── button_data.dart         # Модель данных кнопки
│   ├── utils/
│   │   └── randomizer.dart          # Генератор случайных букв
│   ├── managers/
│   │   └── button_manager.dart      # Менеджер логики кнопок
│   └── screens/
│       ├── game_screen.dart         # Главный экран игры
│       └── about_screen.dart        # Экран "О программе"
├── pubspec.yaml                     # Конфигурация проекта
├── analysis_options.yaml            # Настройки анализатора кода
└── README_RU.md                     # Этот файл
```

## Портирование из C++

Все компоненты оригинального C++ проекта были полностью портированы на Dart:

### 1. randomizer.cpp → lib/utils/randomizer.dart
- ✅ Генерация случайных букв (A, E, Z, P, D)
- ✅ Назначение цветов каждой букве
- ✅ Гарантия 2 копий каждой буквы
- ✅ Функция сброса

### 2. button_manager.cpp → lib/managers/button_manager.dart
- ✅ Обработка кликов по кнопкам
- ✅ Проверка совпадений
- ✅ Счетчик найденных пар
- ✅ Логика первого и второго клика
- ✅ Сброс состояния

### 3. MyForm.h → lib/screens/game_screen.dart
- ✅ Интерфейс с 10 кнопками (сетка 2x5)
- ✅ Заголовок и описание
- ✅ Счетчик пар
- ✅ Список доступных букв с цветами
- ✅ Кнопка перезапуска
- ✅ Меню "О программе"
- ✅ Диалоги (неверное совпадение, завершение игры)
- ✅ Ссылка на Wikipedia

### 4. MainForm.cpp → lib/main.dart
- ✅ Точка входа приложения
- ✅ Инициализация Flutter приложения

## Особенности Flutter версии

### Преимущества перед C++ версией:

1. **Кроссплатформенность**
   - Работает на Windows, Linux, MacOS
   - Работает на Android и iOS
   - Работает в веб-браузере

2. **Современный UI**
   - Material Design
   - Адаптивный интерфейс
   - Плавные анимации

3. **Лучший UX**
   - Автоматическая задержка при неверном совпадении
   - Диалог завершения игры
   - Более удобное управление

4. **Простота разработки**
   - Горячая перезагрузка
   - Легкая поддержка
   - Чистая архитектура кода

## Игровой процесс

1. **Начало игры**
   - При запуске все кнопки скрыты
   - Каждая кнопка содержит букву (всего 5 букв, каждая дважды)

2. **Игра**
   - Кликайте на кнопки, чтобы открыть буквы
   - Найдите пары одинаковых букв
   - При совпадении пара остается открытой
   - При несовпадении обе кнопки скрываются

3. **Завершение**
   - Найдите все 5 пар
   - Появится диалог с поздравлением
   - Можно начать новую игру

## Буквы и цвета

- **A** - Зеленый (Green)
- **E** - Фиолетовый (Fuchsia)
- **Z** - Черный (Black)
- **P** - Голубой (Aqua/Cyan)
- **D** - Синий (Blue)

## Сборка релизной версии

### Android APK
```bash
flutter build apk --release
# Файл будет в: build/app/outputs/flutter-apk/app-release.apk
```

### iOS
```bash
flutter build ios --release
# Требуется MacOS и Xcode
```

### Windows
```bash
flutter build windows --release
# Файлы в: build/windows/runner/Release/
```

### Linux
```bash
flutter build linux --release
# Файлы в: build/linux/x64/release/bundle/
```

### Web
```bash
flutter build web --release
# Файлы в: build/web/
```

## Решение проблем

### Flutter не найден
```bash
# Добавьте Flutter в PATH
export PATH="$PATH:/path/to/flutter/bin"
```

### Ошибки при flutter pub get
```bash
# Очистите кеш и попробуйте снова
flutter clean
flutter pub get
```

### Устройство не найдено
```bash
# Проверьте подключенные устройства
flutter devices

# Убедитесь, что эмулятор запущен или устройство подключено
```

## Лицензия

Оригинальный проект: Copyright (C) 2022-2023 David Leal (halfpacho@gmail.com)

Flutter версия: 2025

Licensed under MIT License

## Ссылки

- [Оригинальный проект на GitHub](https://github.com/Panquesito7/memory_game)
- [Flutter документация](https://docs.flutter.dev/)
- [Dart документация](https://dart.dev/guides)
- [Memory Game на Wikipedia](https://en.wikipedia.org/wiki/Concentration_(card_game))

## Автор портирования

Портировано на Flutter/Dart в 2025 году с использованием Claude AI.

---

**Приятной игры! 🎮**
