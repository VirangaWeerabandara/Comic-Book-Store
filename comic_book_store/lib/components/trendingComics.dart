import 'package:comic_book_store/models/manga.dart';
import 'package:comic_book_store/pages/comicBookPage.dart';
import 'package:flutter/material.dart';

class TrendingComicsList extends StatelessWidget {
  final List<Manga> manga;

  const TrendingComicsList({Key? key, required this.manga}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: manga.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(right: index != manga.length - 1 ? 16 : 0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ComicDetailPage(mangaId: manga[index].malId),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    manga[index].imageUrl,
                    width: 140,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
