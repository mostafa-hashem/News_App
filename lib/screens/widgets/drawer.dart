import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/provider/app_provider.dart';
import 'package:provider/provider.dart';
import '../settings_tab.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyAppProvider>(context);
    return Column(
      children: [
        Container(
          height: 0.2.sh,
          width: double.infinity,
          decoration: const BoxDecoration(color: Color(0xff39A552)),
          child: Center(
              child: Text("News App!",
                  style: GoogleFonts.novaSquare(
                      fontSize: 22, color: Colors.white))),
        ),
        SizedBox(
          height: 0.04.sh,
        ),
        InkWell(
          onTap: () {
            provider.onCategorySelectedNull();
            Navigator.pop(context);
          },
          child: Row(children: [
            SizedBox(
              width: 0.02.sw,
            ),
            const Icon(Icons.list),
            SizedBox(
              width: 0.02.sw,
            ),
            Text("Category", style: Theme.of(context).textTheme.bodyMedium)
          ]),
        ),
        SizedBox(
          height: 0.03.sh,
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, SettingsTab.routeName);
          },
          child: Row(
            children: [
              SizedBox(
                width: 0.02.sw,
              ),
              const Icon(Icons.settings),
              SizedBox(
                width: 0.02.sw,
              ),
              Text("Settings", style: Theme.of(context).textTheme.bodyMedium)
            ],
          ),
        )
      ],
    );
  }
}
