import 'package:flutter/material.dart';

class ComicCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double rating;
  final double width;
  final double height;

  const ComicCard({
    required this.title,
    required this.imageUrl,
    required this.rating,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              width: width,
              height: height,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Center(child: Icon(Icons.error));
              },
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              ...List.generate(
                5,
                (index) {
                  if (index < rating.floor()) {
                    return Icon(Icons.star, size: 16, color: Colors.amber);
                  } else if (index < rating) {
                    return Icon(Icons.star_half, size: 16, color: Colors.amber);
                  } else {
                    return Icon(Icons.star_border,
                        size: 16, color: Colors.amber);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
