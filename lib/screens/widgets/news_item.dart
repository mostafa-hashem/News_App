import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/models/NewsResponse.dart';
import 'package:news_app/provider/app_provider.dart';
import 'package:news_app/screens/full_new_screen.dart';
import 'package:provider/provider.dart';

class NewsItem extends StatelessWidget {
  Articles article;

  NewsItem(this.article);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyAppProvider>(context);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, FullNewScreen.routeName,
            arguments: article);
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Card(
          color: provider.themeMode == ThemeMode.light ? Colors.white : null,
          elevation: 20,
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: const BorderSide(color: Colors.transparent)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: FadeInImage.assetNetwork(
                    placeholder: "assets/images/loading.png",
                    image: article.urlToImage!,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 0.02.sh,
                ),
                RichText(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Title: ",
                        style: GoogleFonts.novaSquare(
                            color: Colors.red,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.normal),
                      ),
                      TextSpan(
                        text: article.title ?? "",
                        style: GoogleFonts.novaSquare(
                            color: provider.themeMode == ThemeMode.light
                                ? const Color(0xff707070)
                                : Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 0.015.sh,
                ),
                RichText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Description: ",
                        style: GoogleFonts.novaSquare(
                            color: Colors.red,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.normal),
                      ),
                      TextSpan(
                        text: article.description ?? " ",
                        style: GoogleFonts.novaSquare(
                            color: provider.themeMode == ThemeMode.light
                                ? Colors.black45
                                : Colors.white70,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 0.015.sh,
                ),
                RichText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Author: ",
                        style: GoogleFonts.novaSquare(
                            color: Colors.red,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.normal),
                      ),
                      TextSpan(
                        text: article.author ?? "",
                        style: GoogleFonts.novaSquare(
                            color: provider.themeMode == ThemeMode.dark
                                ? Colors.cyanAccent
                                : Colors.cyan,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 0.02.sh,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${article.publishedAt?.substring(0, 10)}",
                        style: TextStyle(
                            color: provider.themeMode == ThemeMode.dark
                                ? Colors.black45
                                : Colors.white70,
                            fontSize: 16)),
                    Text("${article.publishedAt?.substring(12, 16)}",
                        style: TextStyle(
                            color: provider.themeMode == ThemeMode.dark
                                ? Colors.black45
                                : Colors.white70,
                            fontSize: 16)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
