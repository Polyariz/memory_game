import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Экран "О программе"
/// Портировано из aboutToolStripMenuItem_Click
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('О программе'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Memory Game',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Версия 1.0.0 (Flutter)',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Оригинальная версия на C++:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Memory Game, v0.2.0\n'
              'Copyright (C) 2022-2023 David Leal (halfpacho@gmail.com)',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 24),
            const Text(
              'Портирована на Flutter в 2025',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 24),
            const Text(
              'Лицензия:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Licensed under MIT License',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () => _launchUrl('https://github.com/Panquesito7/memory_game'),
              child: const Text(
                'https://github.com/Panquesito7/memory_game',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                ),
                child: const Text(
                  'Закрыть',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      debugPrint('Could not launch $urlString');
    }
  }
}
