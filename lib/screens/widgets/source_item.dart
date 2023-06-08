import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/models/SoursesResponse.dart';

class SourceItem extends StatelessWidget {
  Sources sources;
  bool selected;

  SourceItem(this.sources, this.selected);

  static const String routeName = "SourceItem";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: selected ? const Color(0xff39A552) : Colors.transparent,
        border: Border.all(
          color: const Color(0xff39A552),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Text(sources.name ?? "",
          style: selected
              ? GoogleFonts.novaSquare(color: Colors.white, fontSize: 15)
              : GoogleFonts.novaSquare(
                  color: const Color(0xff39A552), fontSize: 15)),
    );
  }
}
