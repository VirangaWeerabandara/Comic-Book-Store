import 'package:flutter/material.dart';

class LibraryPage extends StatelessWidget {
  final List<CollectionItem> collections = [
    CollectionItem(
      title: 'Favourites',
      image: 'assets/watchmen.jpg',
      isSpecial: true,
    ),
    CollectionItem(
      title: 'Want to read',
      image: 'assets/saga.jpg',
      isSpecial: true,
    ),
    CollectionItem(
      title: 'My horrors',
      image: 'assets/horror.jpg',
    ),
    CollectionItem(
      title: 'Badass heroes',
      image: 'assets/transmetropolitan.jpg',
    ),
    CollectionItem(
      title: 'DC',
      image: 'assets/batman.jpg',
    ),
    CollectionItem(
      title: 'Spider-Man',
      image: 'assets/spiderman.jpg',
    ),
    CollectionItem(
      title: 'Comedy',
      image: 'assets/chew.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Library',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: collections.length,
        itemBuilder: (context, index) {
          return CollectionCard(item: collections[index]);
        },
      ),
    );
  }
}

class CollectionItem {
  final String title;
  final String image;
  final bool isSpecial;

  CollectionItem({
    required this.title,
    required this.image,
    this.isSpecial = false,
  });
}

class CollectionCard extends StatelessWidget {
  final CollectionItem item;

  const CollectionCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          // Book cover image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(item.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),
          // Title
          Positioned(
            left: 12,
            bottom: 12,
            child: Text(
              item.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: item.isSpecial ? 18 : 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
