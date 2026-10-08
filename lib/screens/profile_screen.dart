import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final StorageService storageService = StorageService();

  Map<String, dynamic>? user;
  List<Map<String, dynamic>> favorites = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final savedUser = await storageService.getUser();
    final savedFavorites = await storageService.getFavorites();

    if (!mounted) return;

    setState(() {
      user = savedUser;
      favorites = savedFavorites;
      isLoading = false;
    });
  }

  Future<void> removeFavorite(String id) async {
    await storageService.removeFavorite(id);
    await loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final username = user?['username']?.toString() ?? 'User';
    final email = user?['email']?.toString() ?? 'No email';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: RefreshIndicator(
        onRefresh: loadProfile,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: CircleAvatar(
                radius: 45,
                child: Text(
                  username.isNotEmpty
                      ? username[0].toUpperCase()
                      : 'U',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Center(
              child: Text(
                username,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 5),

            Center(
              child: Text(
                email,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Favorites',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            if (favorites.isEmpty)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      'No favorite items yet.',
                    ),
                  ),
                ),
              ),

            ...favorites.map(
                  (item) => Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  title: Text(
                    item['title']?.toString() ?? 'No title',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    item['body']?.toString() ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      removeFavorite(
                        item['id'].toString(),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}