import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/features/news/cubit/cubit.dart';
import 'package:news_app/features/news/data/models/SourcesResponse.dart';
import 'package:news_app/screens/widgets/news_item.dart';
import 'package:news_app/screens/widgets/source_item.dart';

class TabsScreen extends StatelessWidget {
  final List<Sources> sources;

  const TabsScreen(this.sources);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTabController(
          length: sources.length,
          child: TabBar(
            onTap: (value) {
              NewsCubit.get(context).changeSource(value);
            },
            indicatorColor: Colors.transparent,
            isScrollable: true,
            tabs: sources.map((source) {
              return Tab(
                child: SourceItem(
                  source,
                  sources.indexOf(source) ==
                      NewsCubit.get(context).selectedIndex,
                ),
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 0.03.sw),
            itemBuilder: (context, index) {
              return NewsItem(NewsCubit.get(context).news[index]);
            },
            itemCount: NewsCubit.get(context).news.length,
          ),
        ),
      ],
    );
  }
}
