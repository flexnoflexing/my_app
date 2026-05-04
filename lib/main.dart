import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CatPage(),
    );
  }
}

class CatPage extends StatefulWidget {
  const CatPage({super.key});

  @override
  State<CatPage> createState() => _CatPageState();
}

class _CatPageState extends State<CatPage> {
  String imageUrl = '';

  void getRandomCat() {
    setState(() {
      // timestamp нужен, чтобы каждый раз была новая картинка
      imageUrl =
          'https://cataas.com/cat?${DateTime.now().millisecondsSinceEpoch}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Cat 🐱'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: imageUrl.isEmpty
                  ? const Text(
                      'Нажми кнопку 🐾',
                      style: TextStyle(fontSize: 20),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(16),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.contain,
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return const CircularProgressIndicator();
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Text('Ошибка загрузки 😢');
                        },
                      ),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: getRandomCat,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
              ),
              child: const Text(
                'Показать котика 🐾',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}