import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Category extends StatelessWidget {
  int color;
  String image;
  String text;
  String side;

  Category(
      {required this.color,
      required this.image,
      required this.text,
      required this.side});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Container(
        width: 0.35.sw,
        height: 0.21.sh,
        decoration: side == "left"
            ? BoxDecoration(
                color: Color(color),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)))
            : BoxDecoration(
                color: Color(color),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
        child: Column(
          children: [
            SizedBox(
              height: 0.01.sh,
            ),
            Image.asset(image),
            SizedBox(
              height: 0.02.sh,
            ),
            Text(
              text,
              style: GoogleFonts.novaSquare(color: Colors.white, fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
