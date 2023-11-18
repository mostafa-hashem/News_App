import 'package:flutter/material.dart';
import 'package:news_app/features/news/data/models/SourcesResponse.dart';

class SourceItem extends StatelessWidget {
  final Sources source;
  final bool selected;

  const SourceItem(this.source, this.selected);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF39A552) : Colors.transparent,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: const Color(0xFF39A552), width: 2),
      ),
      child: Text(
        source.name ?? "",
        style:
            TextStyle(color: selected ? Colors.white : const Color(0xFF39A552)),
      ),
    );
  }
}
