import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/features/news/data/models/NewsResponse.dart';
import 'package:news_app/provider/app_provider.dart';
import 'package:news_app/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class NewsItem extends StatelessWidget {
  final Articles article;

  const NewsItem(this.article);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyAppProvider>(context);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.fullNew,
          arguments: article,
        );
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Card(
          color: provider.themeMode == ThemeMode.light ? Colors.white : null,
          elevation: 20,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    // Shimmer placeholder
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.white,
                      period: const Duration(seconds: 3),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: Container(
                          width: double.infinity,
                          height: 200.h,
                          color: Colors.grey,
                        ),
                      ),
                    ),

                    // Actual image
                    Visibility(
                      visible: article.urlToImage != null,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: Image.network(
                          article.urlToImage ?? "",
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors
                                  .grey,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
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
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextSpan(
                        text: article.title ?? "",
                        style: GoogleFonts.novaSquare(
                          color: provider.themeMode == ThemeMode.light
                              ? const Color(0xff707070)
                              : Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.normal,
                        ),
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
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextSpan(
                        text: article.description ?? " ",
                        style: GoogleFonts.novaSquare(
                          color: provider.themeMode == ThemeMode.light
                              ? Colors.black45
                              : Colors.white70,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.normal,
                        ),
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
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextSpan(
                        text: article.author ?? "",
                        style: GoogleFonts.novaSquare(
                          color: provider.themeMode == ThemeMode.dark
                              ? Colors.cyanAccent
                              : Colors.cyan,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal,
                        ),
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
                    Text(
                      "${article.publishedAt?.substring(0, 10)}",
                      style: TextStyle(
                        color: provider.themeMode == ThemeMode.dark
                            ? Colors.black45
                            : Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "${article.publishedAt?.substring(12, 16)}",
                      style: TextStyle(
                        color: provider.themeMode == ThemeMode.dark
                            ? Colors.black45
                            : Colors.white70,
                        fontSize: 16,
                      ),
                    ),
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
