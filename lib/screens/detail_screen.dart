import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final StorageService storageService = StorageService();

  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final args =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final int id = args?['id'] ?? 0;
    final String title = args?['title']?.toString() ?? 'No title';
    final String body = args?['body']?.toString() ?? 'No description';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.article,
              size: 70,
              color: Colors.blue,
            ),

            const SizedBox(height: 20),

            Text(
              title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              body,
              style: const TextStyle(
                fontSize: 17,
                height: 1.6,
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () async {
                  await storageService.addFavorite({
                    'id': id,
                    'title': title,
                    'body': body,
                  });

                  if (!mounted) return;

                  setState(() {
                    isFavorite = true;
                  });

                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Added to favorites'),
                    ),
                  );
                },
                icon: Icon(
                  isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                ),
                label: Text(
                  isFavorite
                      ? 'Added to Favorites'
                      : 'Add to Favorites',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}