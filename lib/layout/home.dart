import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../provider/app_provider.dart';
import '../screens/widgets/category_container.dart';
import '../screens/widgets/drawer.dart';
import '../screens/widgets/language_bootom_sheet.dart';
import '../screens/widgets/theme_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
            title: Text(
              AppLocalizations.of(context)!.appName,
            ),
            leading: Padding(
              padding: provider.language == "en"
                  ? EdgeInsets.only(left: 0.03.sw)
                  : EdgeInsets.only(right: 0.03.sw),
              child: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(
                      Icons.menu,
                      size: 30,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              ),
            ),
          ),
          drawer: const Drawer(child: DrawerScreen()),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Pick your category of interest",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Category(
                  color: 0xffC91C22,
                  image: "assets/images/ball.png",
                  text: 'Sports',
                  side: 'left',
                ),
                SizedBox(
                  width: 0.1.sw,
                ),
                Category(
                  color: 0xff003E90,
                  image: "assets/images/Politics.png",
                  text: 'Politics',
                  side: 'right',
                )
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Category(
                  color: 0xffED1E79,
                  image: "assets/images/health.png",
                  text: 'Health',
                  side: 'left',
                ),
                SizedBox(
                  width: 0.1.sw,
                ),
                Category(
                  color: 0xffCF7E48,
                  image: "assets/images/bussines.png",
                  text: 'Business',
                  side: 'right',
                )
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Category(
                  color: 0xff4882CF,
                  image: "assets/images/environment.png",
                  text: 'Environment',
                  side: 'left',
                ),
                SizedBox(
                  width: 0.1.sw,
                ),
                Category(
                  color: 0xffF2D352,
                  image: "assets/images/science.png",
                  text: 'Science',
                  side: 'right',
                )
              ])
            ],
          )),
    );
  }

  void showLanguageSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return LanguageBottomSheet();
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
    );
  }

  void showThemeSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ThemeBottomSheet();
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0.r),
      ),
    );
  }
}
