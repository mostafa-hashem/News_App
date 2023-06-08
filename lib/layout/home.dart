import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/screens/categories.dart';
import 'package:news_app/shared/styles/app_colors.dart';
import 'package:provider/provider.dart';
import '../provider/app_provider.dart';
import '../screens/widgets/drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/screens/news_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "HomeScreen";

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyAppProvider>(context);
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
                      provider.searchClicked
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 36.w, vertical: 18.h),
                              child: Container(
                                width: 0.8.sw,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(35)
                                ),
                                child: Center(
                                  child: TextField(
                                    textInputAction: TextInputAction.search,
                                    decoration:  InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Search',
                                      hintStyle: const TextStyle(color: Colors.black54),
                                      suffixIcon: const Icon(Icons.search),
                                      suffixIconColor: AppCloros.greenColor,
                                      prefixIcon: InkWell(
                                          onTap: (){
                                            provider.onSearchClickedTrue();
                                          },
                                          child: const Icon(Icons.cancel_outlined)),
                                      prefixIconColor: AppCloros.greenColor,
                                    ),
                                    onSubmitted: (value) {},
                                  ),
                                ),
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
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
                : NewsScreen(provider.categoryModel!)));
  }
}
