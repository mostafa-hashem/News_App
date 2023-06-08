import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/models/NewsResponse.dart';
import 'package:news_app/provider/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class FullNewScreen extends StatefulWidget {
  static const String routeName = "FullNewScreen";

  @override
  State<FullNewScreen> createState() => _FullNewScreenState();
}

class _FullNewScreenState extends State<FullNewScreen> {
  late Uri url;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var article = ModalRoute.of(context)?.settings.arguments as Articles;
    url = Uri.parse(article.url ?? "");
  }

  @override
  Widget build(BuildContext context) {
    var article = ModalRoute.of(context)?.settings.arguments as Articles;
    var provider = Provider.of<MyAppProvider>(context);
    var publishedAt = DateTime.parse(article.publishedAt!);
    var timeDifference = DateTime.now().difference(publishedAt);
    var formattedDuration = formatDuration(timeDifference);

    return Scaffold(
      appBar: AppBar(
        title: Text(article.title ?? ""),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 0.03.sh,
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(22),
                    topLeft: Radius.circular(22)),
                child: Image.network(article.urlToImage ?? ""),
              ),
              SizedBox(
                height: 0.02.sh,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${article.source?.name} .",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: provider.themeMode == ThemeMode.light
                              ? Colors.black45
                              : Colors.white70,
                        ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.repeat,
                        size: 15,
                        color: provider.themeMode == ThemeMode.light
                            ? Colors.black45
                            : Colors.white70,
                      ),
                      SizedBox(
                        width: 0.01.sw,
                      ),
                      Text(formattedDuration,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: provider.themeMode == ThemeMode.light
                                      ? Colors.black45
                                      : Colors.white70)),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 0.01.sh,
              ),
              Text(
                article.title ?? "",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(
                height: 0.02.sh,
              ),
              SizedBox(
                height: 0.04.sh,
              ),
              Text(
                article.content ?? "",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: provider.themeMode == ThemeMode.light
                          ? Colors.black45
                          : Colors.white70,
                    ),
              ),
              SizedBox(
                height: 0.03.sh,
              ),
              GestureDetector(
                onTap: () {
                  viewMoreURL();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "View Full Article",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: provider.themeMode == ThemeMode.light
                              ? Colors.black
                              : Colors.white,
                          fontSize: 15,
                          decoration: TextDecoration.underline),
                    ),
                    const Icon(
                      Icons.arrow_right_outlined,
                      size: 24,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatDuration(Duration duration) {
    if (duration.inDays >= 1) {
      return DateFormat('d MMMM y').format(DateTime.now().subtract(duration));
    } else if (duration.inHours >= 1) {
      return '${duration.inHours} hours ago';
    } else if (duration.inMinutes >= 1) {
      return '${duration.inMinutes} minutes ago';
    } else {
      return 'Moments ago';
    }
  }

  Future<void> viewMoreURL() async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
