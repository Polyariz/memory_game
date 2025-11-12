import 'dart:math';
import 'package:flutter/material.dart';
import '../models/button_data.dart';

/// Класс для генерации случайных значений букв и цветов для кнопок
/// Портировано из randomizer.cpp
class Randomizer {
  // Буквы, которые используются в игре (каждая встречается дважды)
  static const List<String> letters = ['A', 'E', 'Z', 'P', 'D'];

  // Цвета для каждой буквы
  static const Map<String, Color> letterColors = {
    'A': Colors.green,
    'E': Color(0xFFFF00FF), // Fuchsia
    'Z': Colors.black,
    'P': Colors.cyan, // Aqua
    'D': Colors.blue,
  };

  final Random _random = Random();
  bool _hasBeenReset = false;

  /// Создает список из 10 кнопок с случайно назначенными буквами
  /// Каждая буква встречается ровно 2 раза
  List<ButtonData> generateButtons() {
    // Создаем список, где каждая буква встречается дважды
    List<String> buttonLetters = [];
    for (String letter in letters) {
      buttonLetters.add(letter);
      buttonLetters.add(letter);
    }

    // Перемешиваем буквы случайным образом
    buttonLetters.shuffle(_random);

    // Создаем список кнопок с назначенными буквами и цветами
    List<ButtonData> buttons = [];
    for (int i = 0; i < buttonLetters.length; i++) {
      String letter = buttonLetters[i];
      buttons.add(ButtonData(
        id: i,
        letter: letter,
        color: letterColors[letter]!,
      ));
    }

    return buttons;
  }

  /// Сбрасывает состояние randomizer'а (используется при перезапуске игры)
  void reset() {
    _hasBeenReset = true;
  }

  /// Проверяет, был ли выполнен сброс
  bool get hasBeenReset => _hasBeenReset;
}
