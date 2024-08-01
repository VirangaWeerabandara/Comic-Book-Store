import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({super.key});

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [__buildSerchWidget()],
        ),
      )),
    );
  }
}

__buildSerchWidget() {
  return const SearchBar(
    hintText: "Search word here",
  );
}
