import 'package:flutter/material.dart';

class RecipeDetailPage extends StatelessWidget {
  final String title;
  final String duration;
  final String difficulty;
  final String imageUrl;

  const RecipeDetailPage({
    Key? key,
    required this.title,
    required this.duration,
    required this.difficulty,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 300,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 20),
                      SizedBox(width: 8),
                      Text(
                        duration,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(width: 30),
                      Icon(Icons.bar_chart, size: 20),
                      SizedBox(width: 8),
                      Text(
                        difficulty,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Ingrédients',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('• 200g de farine'),
                  Text('• 100g de sucre'),
                  Text('• 2 œufs'),
                  Text('• 50g de beurre'),
                  SizedBox(height: 30),
                  Text(
                    'Étapes',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('1. Préchauffer le four à 180°C'),
                  Text('2. Mélanger tous les ingrédients'),
                  Text('3. Former des boules sur une plaque'),
                  Text('4. Cuire pendant 15 minutes'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}