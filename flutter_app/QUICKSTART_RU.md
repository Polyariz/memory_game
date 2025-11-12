# 🚀 Быстрый старт - Memory Game Flutter

## Для Visual Studio Code (Рекомендуется)

### Шаг 1: Установка Flutter

**Windows:**
1. Скачайте Flutter SDK: https://docs.flutter.dev/get-started/install/windows
2. Распакуйте в `C:\flutter`
3. Добавьте в PATH: `C:\flutter\bin`

**Linux:**
```bash
sudo snap install flutter --classic
# или
git clone https://github.com/flutter/flutter.git
export PATH="$PATH:`pwd`/flutter/bin"
```

**MacOS:**
```bash
# Используя Homebrew
brew install --cask flutter
```

### Шаг 2: Установка VS Code расширений

1. Откройте VS Code
2. Нажмите `Ctrl+Shift+X` (или `Cmd+Shift+X` на Mac)
3. Установите:
   - **Flutter** (от Dart Code)
   - **Dart** (от Dart Code)

### Шаг 3: Проверка установки

```bash
flutter doctor
```

Должны быть галочки ✓ на:
- Flutter SDK
- Dart SDK
- VS Code

### Шаг 4: Открытие проекта

1. Откройте VS Code
2. File → Open Folder
3. Выберите папку `flutter_app`
4. VS Code автоматически определит Flutter проект

### Шаг 5: Установка зависимостей

В терминале VS Code:
```bash
flutter pub get
```

Или нажмите на кнопку "Get Packages" в файле `pubspec.yaml`

### Шаг 6: Запуск приложения

#### Вариант A: Запуск в Chrome (самый простой)
1. Нажмите `F5` или `Run > Start Debugging`
2. Выберите `Chrome (web)` в списке устройств
3. Приложение откроется в браузере

#### Вариант B: Запуск на Desktop
1. В правом нижнем углу VS Code кликните на устройство
2. Выберите:
   - `Windows (desktop)` для Windows
   - `Linux (desktop)` для Linux
   - `macOS (desktop)` для Mac
3. Нажмите `F5`

#### Вариант C: Запуск на эмуляторе Android
1. Установите Android Studio (если еще не установлен)
2. Создайте виртуальное устройство в AVD Manager
3. Запустите эмулятор
4. В VS Code выберите эмулятор в списке устройств
5. Нажмите `F5`

### Шаг 7: Горячая перезагрузка

Пока приложение запущено:
- **Сохраните файл** (`Ctrl+S`) - автоматическая горячая перезагрузка
- Или нажмите кнопку горячей перезагрузки в Debug панели
- Или в терминале нажмите `r`

---

## Команды терминала

### Запуск на разных платформах

```bash
# Web (Chrome)
flutter run -d chrome

# Windows Desktop
flutter run -d windows

# Linux Desktop
flutter run -d linux

# MacOS Desktop
flutter run -d macos

# Android эмулятор (должен быть запущен)
flutter run

# Посмотреть доступные устройства
flutter devices
```

### Сборка приложения

```bash
# APK для Android
flutter build apk --release

# Windows executable
flutter build windows --release

# Linux executable
flutter build linux --release

# Web
flutter build web --release
```

### Другие полезные команды

```bash
# Очистка кеша
flutter clean

# Обновление зависимостей
flutter pub get

# Обновление Flutter
flutter upgrade

# Проверка проблем
flutter doctor -v

# Анализ кода
flutter analyze
```

---

## Структура проекта

```
flutter_app/
├── lib/
│   ├── main.dart              ← НАЧНИТЕ ОТСЮДА (точка входа)
│   ├── models/
│   │   └── button_data.dart   ← Модель кнопки
│   ├── utils/
│   │   └── randomizer.dart    ← Генератор букв
│   ├── managers/
│   │   └── button_manager.dart ← Логика игры
│   └── screens/
│       ├── game_screen.dart    ← Главный экран
│       └── about_screen.dart   ← Экран "О программе"
├── pubspec.yaml               ← Конфигурация и зависимости
└── README_RU.md              ← Полная документация
```

---

## Решение проблем

### ❌ "flutter: command not found"

```bash
# Добавьте Flutter в PATH
# Windows: добавьте C:\flutter\bin в System Environment Variables
# Linux/Mac:
export PATH="$PATH:/path/to/flutter/bin"
```

### ❌ Ошибка при flutter pub get

```bash
flutter clean
flutter pub get
```

### ❌ Не видно устройств (flutter devices пуст)

**Для Chrome:**
```bash
flutter config --enable-web
flutter devices
```

**Для Desktop:**
```bash
# Windows
flutter config --enable-windows-desktop

# Linux
flutter config --enable-linux-desktop

# Mac
flutter config --enable-macos-desktop

flutter devices
```

### ❌ VS Code не определяет Flutter проект

1. Перезагрузите VS Code
2. Убедитесь, что открыта папка `flutter_app` (не родительская!)
3. Проверьте, что установлены Flutter и Dart расширения
4. Запустите: `Flutter: Reload Extension` из Command Palette (`Ctrl+Shift+P`)

---

## Тестирование изменений

1. Откройте `lib/screens/game_screen.dart`
2. Измените текст, например строка 135:
   ```dart
   'Найдите пару для каждой кнопки!'
   ```
   на
   ```dart
   'Найдите все пары!'
   ```
3. Сохраните файл (`Ctrl+S`)
4. Приложение автоматически обновится (hot reload)

---

## Отладка

### Точки останова (Breakpoints)

1. Кликните слева от номера строки в коде
2. Появится красная точка
3. Запустите с отладкой (`F5`)
4. Когда выполнение дойдет до точки, оно остановится
5. Исследуйте переменные в Debug панели

### Debug Console

- Смотрите вывод в Debug Console внизу VS Code
- Видите ошибки и print() сообщения

### Flutter DevTools

1. Когда приложение запущено, в терминале увидите ссылку
2. Кликните на ссылку или нажмите `Ctrl+Shift+P` → `Dart: Open DevTools`
3. Доступны:
   - Inspector (иерархия виджетов)
   - Performance (производительность)
   - Memory (память)
   - Network (сеть)

---

## Следующие шаги

### 1. Изучите код
- Начните с `lib/main.dart`
- Изучите `lib/screens/game_screen.dart` (основная логика)
- Посмотрите на модели и менеджеры

### 2. Сделайте изменения
- Измените цвета букв
- Добавьте звуковые эффекты
- Добавьте анимации
- Увеличьте количество кнопок

### 3. Прочитайте полную документацию
- `README_RU.md` - полное руководство
- `VERIFICATION_RU.md` - детали портирования
- [Flutter документация](https://docs.flutter.dev/)

---

## Горячие клавиши VS Code

| Клавиши | Действие |
|---------|----------|
| `F5` | Запуск с отладкой |
| `Ctrl+F5` | Запуск без отладки |
| `Shift+F5` | Остановка |
| `Ctrl+Shift+F5` | Перезапуск |
| `Ctrl+S` | Сохранить и hot reload |
| `Ctrl+Shift+P` | Command Palette |
| `Ctrl+Space` | Автодополнение |
| `F12` | Перейти к определению |
| `Alt+F12` | Peek определение |

---

## Полезные ресурсы

- 📚 [Flutter документация](https://docs.flutter.dev/)
- 🎓 [Flutter примеры](https://flutter.dev/docs/cookbook)
- 💬 [Flutter сообщество](https://flutter.dev/community)
- 🎥 [Flutter YouTube](https://www.youtube.com/c/flutterdev)
- 📖 [Dart язык](https://dart.dev/guides)

---

**Готово! Теперь запустите игру и наслаждайтесь! 🎮**

Если возникли проблемы, откройте `README_RU.md` для подробной информации.
