import '../models/button_data.dart';

/// Класс для управления логикой кнопок и проверки совпадений
/// Портировано из button_manager.cpp
class ButtonManager {
  int _matchCount = 0; // Количество найденных пар
  int _clickCount = 1; // Количество кликов на кнопку
  bool _flag = false; // Флаг для сравнения карт

  int? _firstButtonId; // ID первой нажатой кнопки
  String? _firstButtonValue; // Значение первой нажатой кнопки

  /// Получить текущее количество найденных пар
  int get matchCount => _matchCount;

  /// Получить количество кликов
  int get clickCount => _clickCount;

  /// Обрабатывает клик по кнопке и возвращает результат проверки
  /// Возвращает Map с информацией о результате:
  /// - 'match': bool - совпала ли пара
  /// - 'wrongMatch': bool - неверное совпадение
  /// - 'firstClick': bool - это первый клик
  /// - 'secondButtonId': int? - ID второй кнопки для сброса текста
  Map<String, dynamic> handleButtonClick(ButtonData button) {
    Map<String, dynamic> result = {
      'match': false,
      'wrongMatch': false,
      'firstClick': false,
      'secondButtonId': null,
    };

    // Первый клик - запоминаем значение и ID кнопки
    if (!_flag) {
      _firstButtonValue = button.letter;
      _firstButtonId = button.id;
      _flag = true;
      result['firstClick'] = true;
      return result;
    }

    // Второй клик - проверяем совпадение
    if (button.letter == _firstButtonValue && _clickCount != 1) {
      _matchCount++;
      result['match'] = true;

      _clickCount = 0;
      _flag = false;
    } else if (button.letter != _firstButtonValue && _clickCount == 2) {
      // Неверное совпадение
      result['wrongMatch'] = true;
      result['secondButtonId'] = _firstButtonId;

      _clickCount = 0;
      _flag = false;
    }

    _clickCount++;
    return result;
  }

  /// Сбрасывает все счетчики и флаги (используется при перезапуске игры)
  void reset() {
    _matchCount = 0;
    _clickCount = 1;
    _flag = false;
    _firstButtonId = null;
    _firstButtonValue = null;
  }

  /// Проверяет, все ли пары найдены (5 пар = 5 совпадений)
  bool isGameComplete() {
    return _matchCount >= 5;
  }
}
