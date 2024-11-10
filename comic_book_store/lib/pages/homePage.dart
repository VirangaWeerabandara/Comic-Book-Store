import 'package:flutter/material.dart';
import 'package:comic_book_store/components/card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;

    // Responsive spacing calculations
    final horizontalPadding = screenSize.width * 0.04; // 4% of screen width
    final verticalSpacing = screenSize.height * 0.02; // 2% of screen height

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Determine if we're in landscape mode
            final isLandscape = constraints.maxWidth > constraints.maxHeight;

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStatusBar(context),
                    SizedBox(height: verticalSpacing),
                    _buildHotTakes(context, constraints),
                    SizedBox(height: verticalSpacing),
                    _buildTrendingComics(context, constraints, isLandscape),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatusBar(BuildContext context) {
    return const Row(
      children: [
        Text(
          '9:41',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Icon(Icons.signal_cellular_alt),
        SizedBox(width: 8),
        Icon(Icons.wifi),
        SizedBox(width: 8),
        Icon(Icons.battery_full),
      ],
    );
  }

  Widget _buildHotTakes(BuildContext context, BoxConstraints constraints) {
    final titleStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        _HotTakeCard(constraints: constraints),
      ],
    );
  }

  Widget _buildTrendingComics(
    BuildContext context,
    BoxConstraints constraints,
    bool isLandscape,
  ) {
    final titleStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Trending comics', style: titleStyle),
        const SizedBox(height: 16),
        _TrendingComicsList(
          constraints: constraints,
          isLandscape: isLandscape,
        ),
      ],
    );
  }
}

class _HotTakeCard extends StatelessWidget {
  final BoxConstraints constraints;

  const _HotTakeCard({required this.constraints});

  @override
  Widget build(BuildContext context) {
    final cardHeight = constraints.maxHeight * 0.2;

    return Container(
      height: cardHeight.clamp(120.0, 200.0),
      decoration: BoxDecoration(
        color: Colors.deepOrange,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'New Issue',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'BRZRKR',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.horizontal(right: Radius.circular(12)),
              child: Image.network(
                'https://via.placeholder.com/100x120',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrendingComicsList extends StatelessWidget {
  final BoxConstraints constraints;
  final bool isLandscape;

  const _TrendingComicsList({
    required this.constraints,
    required this.isLandscape,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate responsive item width based on screen size and orientation
    final itemWidth =
        isLandscape ? constraints.maxWidth * 0.15 : constraints.maxWidth * 0.3;

    return SizedBox(
      height: constraints.maxHeight * 0.4,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              final comics = [
                {'title': 'Batman', 'rating': 4.5},
                {'title': 'The Amazing Spider-Man', 'rating': 4.5},
                {'title': 'Invincible', 'rating': 4.5},
              ];

              return Padding(
                padding: EdgeInsets.only(
                  right: index < 2 ? 16 : 0,
                ),
                child: ComicCard(
                  title: comics[index]['title'] as String,
                  imageUrl: 'https://via.placeholder.com/150x200',
                  rating: comics[index]['rating'] as double,
                  width: itemWidth,
                  height: constraints.maxHeight * 0.75,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
