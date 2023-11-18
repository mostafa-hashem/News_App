import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/features/news/cubit/cubit.dart';
import 'package:news_app/provider/app_provider.dart';
import 'package:news_app/route_manager.dart';
import 'package:provider/provider.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyAppProvider>(context);
    return Column(
      children: [
        Container(
          height: 0.2.sh,
          width: double.infinity,
          decoration: const BoxDecoration(color: Color(0xff39A552)),
          child: Center(
            child: Text(
              "News App!",
              style: GoogleFonts.novaSquare(
                fontSize: 22,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 0.04.sh,
        ),
        InkWell(
          onTap: () {
            provider.onCategorySelectedNull();
            NewsCubit.get(context).selectedIndex = 0;
            Navigator.pop(context);
          },
          child: Row(
            children: [
              SizedBox(
                width: 0.02.sw,
              ),
              const Icon(Icons.list),
              SizedBox(
                width: 0.02.sw,
              ),
              Text("Category", style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
        SizedBox(
          height: 0.03.sh,
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, Routes.settings);
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
              Text("Settings", style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }
}
