import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/models/NewsResponse.dart';
import 'package:news_app/models/SoursesResponse.dart';
import 'package:news_app/provider/app_provider.dart';
import 'package:news_app/screens/widgets/news_item.dart';
import 'package:news_app/screens/widgets/source_item.dart';
import 'package:news_app/shared/components/constans.dart';
import 'package:news_app/shared/network/remot/api_manager.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatelessWidget {
  List<Sources> sources;

  TabsScreen(this.sources);

  @override
  Widget build(BuildContext context) {
    final MyAppProvider provider = Provider.of(context);
    return Column(children: [
      DefaultTabController(
        length: sources.length,
        child: TabBar(
          onTap: (value) {
            provider.selectedItem(value);
          },
          indicatorColor: Colors.transparent,
          isScrollable: true,
          tabs: sources.map((source) {
            return Tab(
                child: SourceItem(
                    source, sources.indexOf(source) == provider.selectedIndex));
          }).toList(),
        ),
      ),
      Expanded(
        child: FutureBuilder<NewsResponse>(
          future: () async {
            var response = await ApiManager.getNewsData(
                sources[provider.selectedIndex].id ?? "", "");
            return response;
          }(),
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
              return Column(
                children: [Text(snapshot.data?.message ?? "")],
              );
            }
            var newsData = snapshot.data?.articles ?? [];
            return ListView.separated(
              scrollDirection: Axis.vertical,
              separatorBuilder: (context, index) => SizedBox(height: 0.03.sw),
              itemBuilder: (context, index) {
                return NewsItem(newsData[index]);
              },
              itemCount: newsData.length,
            );
          },
        ),
      ),
    ]);
  }
}
