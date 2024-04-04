import 'package:flutter/material.dart';
import 'package:salle_magne/widget/favorite_item.dart';

class FavoritesPage extends StatelessWidget {
  final List<FavoriteItem> favoriteItems;

  const FavoritesPage({Key? key, required this.favoriteItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoris'),
      ),
      body: ListView.builder(
        itemCount: favoriteItems.length,
        itemBuilder: (context, index) {
          final item = favoriteItems[index];
          return ListTile(
            title: Text(item.name),
            trailing: IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () {
                // Action lorsque l'utilisateur supprime un favori
              },
            ),
          );
        },
      ),
    );
  }
}
