import 'package:flash_recipe/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final _formKey = GlobalKey<FormState>();
  String? _imageUrl;
  bool _isLoading = false;
  String? _selectedValue;

  final _titleController = TextEditingController();
  final _durationController = TextEditingController();
  final _imageUrlController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _durationController.dispose();
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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Recette postée avec succès !')),
        );
      });
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
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUnfocus,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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

                  TextFormField(
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
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Veuillez entrer une URL d'image";
                      }
                      final uri = Uri.tryParse(value);
                      if (uri == null || !uri.hasScheme) {
                        return "URL invalide (doit commencer par http:// ou https://)";
                      }
                      if (!uri.scheme.startsWith('http')) {
                        return "L'URL doit commencer par http:// ou https://";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _titleController,
                    enabled: !_isLoading,
                    decoration: const InputDecoration(
                      labelText: "Titre de la recette",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Le titre est obligatoire";
                      }
                      if (value.trim().length < 3) {
                        return "Le titre doit contenir au moins 3 caractères";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _durationController,
                    enabled: !_isLoading,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Durée de la recette (en minutes)',
                      border: OutlineInputBorder(),
                      hintText: 'Ex: 25',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "La durée est obligatoire";
                      }
                      final duration = int.tryParse(value.trim());
                      if (duration == null) {
                        return "Veuillez entrer un nombre valide";
                      }
                      if (duration <= 0) {
                        return "La durée doit être supérieure à 0";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Select an option',
                      border: OutlineInputBorder(),
                      hintText: 'Facile, Moyen ou Difficile',
                    ),
                      initialValue: _selectedValue,
                      items: ['Facile', 'Moyen', 'Difficile']
                          .map((option) => DropdownMenuItem(
                        value: option,
                        child: Text(option),
                      ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select an option';
                        }
                        return null;
                      },
                  ),
                  const SizedBox(height: 32),

                  // Bouton Post
                  ElevatedButton(
                    onPressed: _isLoading ? null : _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 50),
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
