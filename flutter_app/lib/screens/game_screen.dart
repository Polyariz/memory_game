import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/button_data.dart';
import '../utils/randomizer.dart';
import '../managers/button_manager.dart';
import 'about_screen.dart';

/// Главный экран игры
/// Портировано из MyForm.h
class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<ButtonData> _buttons;
  late Randomizer _randomizer;
  late ButtonManager _buttonManager;

  bool _isProcessing = false; // Предотвращает клики во время проверки

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  /// Инициализирует новую игру
  void _initializeGame() {
    _randomizer = Randomizer();
    _buttonManager = ButtonManager();
    _buttons = _randomizer.generateButtons();
  }

  /// Обрабатывает клик по кнопке игры
  void _onButtonClick(int buttonId) {
    if (_isProcessing) return;

    final button = _buttons[buttonId];

    // Не обрабатываем клик, если кнопка уже открыта или совпадение найдено
    if (button.isRevealed || button.isMatched) return;

    setState(() {
      // Открываем кнопку
      _buttons[buttonId] = button.copyWith(isRevealed: true);
    });

    // Обрабатываем логику совпадения
    final result = _buttonManager.handleButtonClick(button);

    if (result['match']) {
      // Совпадение найдено!
      setState(() {
        // Помечаем обе кнопки как совпавшие
        for (int i = 0; i < _buttons.length; i++) {
          if (_buttons[i].isRevealed &&
              _buttons[i].letter == button.letter &&
              !_buttons[i].isMatched) {
            _buttons[i] = _buttons[i].copyWith(isMatched: true);
          }
        }
      });

      // Проверяем, завершена ли игра
      if (_buttonManager.isGameComplete()) {
        _showGameCompleteDialog();
      }
    } else if (result['wrongMatch']) {
      // Неверное совпадение - показываем сообщение и скрываем кнопки
      _isProcessing = true;

      Future.delayed(const Duration(milliseconds: 500), () {
        _showWrongMatchDialog(buttonId, result['secondButtonId']);
      });
    }
  }

  /// Показывает диалог о неверном совпадении
  void _showWrongMatchDialog(int firstId, int secondId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Неверное совпадение'),
        content: const Text('Буквы не совпадают. Попробуйте еще раз.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                // Скрываем обе кнопки
                _buttons[firstId] = _buttons[firstId].copyWith(isRevealed: false);
                _buttons[secondId] = _buttons[secondId].copyWith(isRevealed: false);
                _isProcessing = false;
              });
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  /// Показывает диалог о завершении игры
  void _showGameCompleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Поздравляем!'),
        content: const Text('Вы нашли все пары! Отличная работа!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _restartGame();
            },
            child: const Text('Играть снова'),
          ),
        ],
      ),
    );
  }

  /// Перезапускает игру
  void _restartGame() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Перезапуск игры'),
        content: const Text('Вы уверены, что хотите перезапустить игру?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _initializeGame();
                _isProcessing = false;
              });
            },
            child: const Text('Да'),
          ),
        ],
      ),
    );
  }

  /// Показывает информацию об игре Memory Game
  void _showMemoryGameInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Memory Game'),
        content: const Text(
          'Вы собираетесь перейти на страницу Wikipedia о игре "Concentration".\n\n'
          'Продолжить?'
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _launchUrl('https://en.wikipedia.org/wiki/Concentration_(card_game)');
            },
            child: const Text('Да'),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Не удалось открыть $urlString')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Game'),
        backgroundColor: Colors.blue,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'about') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutScreen()),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'about',
                child: Text('О программе'),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Заголовок
            InkWell(
              onTap: _showMemoryGameInfo,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: const Text(
                  'Memory Game',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Найдите пару для каждой кнопки!',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            // Сетка кнопок 2x5
            Expanded(
              child: Center(
                child: SizedBox(
                  width: 300,
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      final buttonData = _buttons[index];
                      return _buildGameButton(buttonData);
                    },
                  ),
                ),
              ),
            ),

            // Счетчик пар
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Найдено пар: ${_buttonManager.matchCount}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Доступные буквы
            const Text(
              'Доступные буквы:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLetterLabel('A', Colors.green),
                const SizedBox(width: 16),
                _buildLetterLabel('E', const Color(0xFFFF00FF)),
                const SizedBox(width: 16),
                _buildLetterLabel('Z', Colors.black),
                const SizedBox(width: 16),
                _buildLetterLabel('P', Colors.cyan),
                const SizedBox(width: 16),
                _buildLetterLabel('D', Colors.blue),
              ],
            ),
            const SizedBox(height: 24),

            // Кнопка перезапуска
            ElevatedButton(
              onPressed: _restartGame,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
              ),
              child: const Text(
                'Перезапустить игру',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  /// Создает кнопку игры
  Widget _buildGameButton(ButtonData buttonData) {
    return ElevatedButton(
      onPressed: () => _onButtonClick(buttonData.id),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        padding: EdgeInsets.zero,
      ),
      child: buttonData.isRevealed || buttonData.isMatched
          ? Text(
              buttonData.letter,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: buttonData.color,
              ),
            )
          : null,
    );
  }

  /// Создает метку с буквой и цветом
  Widget _buildLetterLabel(String letter, Color color) {
    return Text(
      letter,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }
}
