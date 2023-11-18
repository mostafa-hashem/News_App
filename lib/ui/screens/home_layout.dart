import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/features/news/cubit/cubit.dart';
import 'package:news_app/features/news/ui/news_screen.dart';
import 'package:news_app/provider/app_provider.dart';
import 'package:news_app/screens/categories.dart';
import 'package:news_app/screens/widgets/search_widget.dart';
import 'package:news_app/ui/screens/drawer.dart';
import 'package:provider/provider.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout();

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyAppProvider>(context);
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg_image.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff39A552),
          centerTitle: true,
          toolbarHeight: 90,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(70.r),
              bottomRight: Radius.circular(70.r),
            ),
          ),
          title: provider.searchClicked == false
              ? Text(
                  provider.categoryModel == null
                      ? AppLocalizations.of(context)!.appName
                      : provider.categoryModel!.name,
                  style: provider.language == "en"
                      ? Theme.of(context).textTheme.bodyLarge
                      : GoogleFonts.cairo(),
                )
              : const Text(""),
          actions: provider.categoryModel != null
              ? [
                  if (provider.searchClicked)
                    const SearchWidget()
                  else
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: InkWell(
                        onTap: () {
                          provider.onSearchClickedFalse();
                        },
                        child: provider.searchClicked == false
                            ? const Icon(Icons.search_rounded)
                            : null,
                      ),
                    ),
                ]
              : [],
          leading: Padding(
            padding: provider.language == "en"
                ? EdgeInsets.only(left: 0.03.sw)
                : EdgeInsets.only(right: 0.03.sw),
            child: Builder(
              builder: (BuildContext context) {
                return provider.searchClicked == false
                    ? InkWell(
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                        child: const Icon(
                          Icons.menu,
                          size: 30,
                        ),
                      )
                    : const Text("");
              },
            ),
          ),
        ),
        drawer: const Drawer(child: DrawerScreen()),
        body: provider.categoryModel == null
            ? CategoriesScreen(provider.onCategorySelected)
            : NewsScreen(provider.categoryModel!),
      ),
    );
  }

  void onSearchSubmitted(String query, MyAppProvider provider) {
    provider.onSearchClickedTrue();
    if (provider.categoryModel != null) {
      NewsCubit.get(context).getNews(query: query);
    }
  }
}
