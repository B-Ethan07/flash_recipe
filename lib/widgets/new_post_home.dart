import 'package:flash_recipe/screens/recipe_detail_page.dart';
import 'package:flutter/material.dart';

class NewPostHome extends StatefulWidget {
  const NewPostHome({Key? key}) : super(key: key);

  @override
  _NewPostHomeState createState() => _NewPostHomeState();
}

class _NewPostHomeState extends State<NewPostHome> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isWeb = screenWidth > 600;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        children: [
          _buildRecipeCard(
            context: context,
            isDark: isDark,
            width: isWeb ? (screenWidth / 2) - 30 : screenWidth - 40,
            height: isWeb ? screenHeight / 1.8 : screenHeight / 1.5,
            title: 'Cookies maison',
            duration: '25min',
            difficulty: 'Facile',
            imageUrl:
            'https://images.pexels.com/photos/230325/pexels-photo-230325.jpeg',
          ),
          _buildRecipeCard(
            context: context,
            isDark: isDark,
            width: isWeb ? (screenWidth / 2) - 30 : screenWidth - 40,
            height: isWeb ? screenHeight / 1.8 : screenHeight / 1.5,
            title: 'Tarte aux pommes',
            duration: '45min',
            difficulty: 'Moyen',
            imageUrl:
            'https://cdn.pixabay.com/photo/2020/09/25/15/13/pie-5601656_960_720.jpg',
          ),
          _buildRecipeCard(
            context: context,
            isDark: isDark,
            width: isWeb ? (screenWidth / 2) - 30 : screenWidth - 40,
            height: isWeb ? screenHeight / 1.8 : screenHeight / 1.5,
            title: 'Lasagne',
            duration: '125min',
            difficulty: 'Moyen',
            imageUrl:
            'https://cdn.pixabay.com/photo/2021/02/06/11/51/food-5987888_960_720.jpg',
          ),
          _buildRecipeCard(
            context: context,
            isDark: isDark,
            width: isWeb ? (screenWidth / 2) - 30 : screenWidth - 40,
            height: isWeb ? screenHeight / 1.8 : screenHeight / 1.5,
            title: 'Ramen au boeuf',
            duration: '45min',
            difficulty: 'Moyen',
            imageUrl:
            'https://cdn.pixabay.com/photo/2022/05/10/18/50/ramen-7187810_960_720.jpg',
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeCard({
    required BuildContext context,
    required bool isDark,
    required double width,
    required double height,
    required String title,
    required String duration,
    required String difficulty,
    required String imageUrl,
  }) {
    return Container(
      width: width,
      height: height * 0.8,
      decoration: BoxDecoration(
        boxShadow: isDark
            ? [
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.1),
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(0, 0),
          ),
        ]
            : [],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Card(
        color: isDark ? Colors.black87 : Colors.amber[200],
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: height * 0.40,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('Titre :', title),
                  Divider(height: 20, thickness: 1),
                  _buildInfoRow('Durée :', duration),
                  Divider(height: 20, thickness: 1),
                  _buildInfoRow('Difficulté :', difficulty, italic: true),
                  Divider(height: 20, thickness: 1),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeDetailPage(
                              title: title,
                              duration: duration,
                              difficulty: difficulty,
                              imageUrl: imageUrl,
                            ),
                          ),
                        );
                      },
                      child: Text("Détail"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool italic = false}) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: italic ? TextStyle(fontStyle: FontStyle.italic) : null,
          ),
        ),
      ],
    );
  }
}
