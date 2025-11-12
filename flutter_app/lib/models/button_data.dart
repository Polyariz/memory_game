import 'package:flutter/material.dart';

/// Класс для хранения данных каждой кнопки в игре
class ButtonData {
  final int id;
  String letter;
  Color color;
  bool isRevealed;
  bool isMatched;

  ButtonData({
    required this.id,
    required this.letter,
    required this.color,
    this.isRevealed = false,
    this.isMatched = false,
  });

  /// Создает копию ButtonData с измененными полями
  ButtonData copyWith({
    int? id,
    String? letter,
    Color? color,
    bool? isRevealed,
    bool? isMatched,
  }) {
    return ButtonData(
      id: id ?? this.id,
      letter: letter ?? this.letter,
      color: color ?? this.color,
      isRevealed: isRevealed ?? this.isRevealed,
      isMatched: isMatched ?? this.isMatched,
    );
  }
}
