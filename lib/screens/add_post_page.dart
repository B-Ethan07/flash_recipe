import 'package:flash_recipe/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  String? _imageUrl;
  bool _isLoading = false;

  final _titleController = TextEditingController();
  final _durationController = TextEditingController();
  final _difficultyController = TextEditingController();
  final _imageUrlController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _durationController.dispose();
    _difficultyController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  Future<bool> isValidImageUrl(String url) async {
    try {
      final response = await http.head(Uri.parse(url));
      final contentType = response.headers['content-type'];

      return response.statusCode == 200 &&
          contentType != null &&
          contentType.startsWith('image/');
    } catch (_) {
      return false;
    }
  }

  Widget _buildImagePreview() {
    if (_imageUrl == null || _imageUrl!.isEmpty) {
      return Center(
        child: Icon(Icons.image_outlined, color: Colors.grey[600], size: 60),
      );
    }

    return Image.network(
      _imageUrl!,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return const Center(child: Text("Image non valide"));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: _buildImagePreview(),
                ),
                const SizedBox(height: 24),

                // Boutons pour caméra et galerie
                TextField(
                  controller: _imageUrlController,
                  enabled: !_isLoading,
                  decoration: const InputDecoration(
                    labelText: "Lien de l'image",
                    border: OutlineInputBorder(),
                    hintText: "https://example.com/image.jpg",
                  ),
                  onChanged: (value) {
                    setState(() {
                      _imageUrl = value.trim();
                    });
                  },
                ),
                const SizedBox(height: 16),

                // Formulaire
                TextField(
                  controller: _titleController,
                  enabled: !_isLoading,
                  decoration: const InputDecoration(
                    labelText: "Titre de la recette",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _durationController,
                  enabled: !_isLoading,
                  decoration: const InputDecoration(
                    labelText: 'Durée de la recette',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _difficultyController,
                  enabled: !_isLoading,
                  decoration: const InputDecoration(
                    labelText: 'Difficultée',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 32),

                // Bouton Post
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : const Text('Poster'),
                ),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black38,
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
