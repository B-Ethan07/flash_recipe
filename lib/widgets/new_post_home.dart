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
    final isWeb = MediaQuery.of(context).size.width > 600;

    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: [
        _buildRecipeCard(
          isDark: isDark,
          isWeb: isWeb,
          title: 'Cookies maison',
          duration: '25min',
          difficulty: 'Facile',
          imageUrl: 'https://images.pexels.com/photos/230325/pexels-photo-230325.jpeg',
        ),
        _buildRecipeCard(
          isDark: isDark,
          isWeb: isWeb,
          title: 'Tarte aux pommes',
          duration: '45min',
          difficulty: 'Moyen',
          imageUrl: 'https://cdn.pixabay.com/photo/2020/09/25/15/13/pie-5601656_960_720.jpg',
        ),
      ],
    );
  }

  _buildRecipeCard({
    required bool isDark,
    required bool isWeb,
    required String title,
    required String duration,
    required String difficulty,
    required String imageUrl,
  }) {
    return Container(
      width: isWeb ? (MediaQuery.of(context).size.width / 2) - 30 : double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
              height: 400,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Titre: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(title),
                      ),
                    ],
                  ),
                  Divider(height: 20, thickness: 1),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Durée de la recette : ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(duration),
                      ),
                    ],
                  ),
                  Divider(height: 20, thickness: 1),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Difficulté: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          difficulty,
                          style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 20, thickness: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // ← Navigation vers la page de détail
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
                    ]
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
