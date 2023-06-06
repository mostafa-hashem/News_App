import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../shared/components/constans.dart';
import '../../shared/network/remot/api_manager.dart';

class Category extends StatelessWidget {
  const Category({Key? key});

  static const String routeName = "Category";

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: FutureBuilder(
          future: ApiManager.getSources(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Column(
                children: [Text("Something went wrong")],
              );
            }
            if (snapshot.data?.status != STATUS) {
              return const Column(
                children: [Text("Error!")],
              );
            }
            var sources = snapshot.data?.sources ?? [];
            return ListView.separated(
              scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) =>
                    SizedBox(width: 0.03.sw),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.green,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Center(
                          child: Text(
                            sources[index].name ?? "",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: sources.length);
          }),
    );
  }
}
