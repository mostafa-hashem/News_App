import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/provider/app_provider.dart';
import 'package:news_app/shared/styles/app_colors.dart';
import 'package:provider/provider.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyAppProvider>(context);

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 36.w, vertical: 18.h),
      child: Container(
        width: 0.8.sw,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(35)),
        child: Center(
          child: TextField(
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Search',
              hintStyle: const TextStyle(
                  color: Colors.black54),
              suffixIcon: const Icon(Icons.search),
              suffixIconColor: AppCloros.greenColor,
              prefixIcon: InkWell(
                  onTap: () {
                    provider.onSearchClickedTrue();
                  },
                  child: const Icon(
                      Icons.cancel_outlined)),
              prefixIconColor: AppCloros.greenColor,
            ),
            style: const TextStyle(
              color: Colors.black,
            ),
            onSubmitted: (value) {

            },
          ),
        ),
      ),
    );
  }
}
