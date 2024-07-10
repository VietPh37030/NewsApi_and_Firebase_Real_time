import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:new_paper_pj/consts/vars.dart';
import 'package:new_paper_pj/inner_screens/blog_details.dart';
import 'package:new_paper_pj/models/news_model.dart';
import 'package:new_paper_pj/services/utils.dart';
import 'package:new_paper_pj/widgets/vertical_spacing.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../inner_screens/news_details_webview.dart';

class ArticlesWidget extends StatelessWidget {
  const ArticlesWidget({Key? key}) : super(key: key);

  // final String imageUrl, title, url, dateToShow, readingTime;

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final newsModelProvider = Provider.of<NewsModel>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor,
        child: GestureDetector(
          onTap: () {
            // Su li khi nhan vao tin
            Navigator.pushNamed(context, NewsDetailsScreen.routeName,arguments: newsModelProvider.publishedAt);
          },
          child: Stack(
            children: [
              Container(
                height: 60,
                width: 60,
                color: Theme.of(context).colorScheme.secondary,
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  height: 60,
                  width: 60,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Container(
                color: Theme.of(context).cardColor,
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Hero(
                        tag: newsModelProvider.publishedAt,
                        child: FancyShimmerImage(
                            height: size.height * 0.15,
                            width: size.width * 0.20,
                            boxFit: BoxFit.fill,
                            errorWidget:
                                Image.asset("assets/images/empty_image.png"),
                            imageUrl: newsModelProvider.urlToImage),
                      ),
                    ),
                    // Du lieu
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            newsModelProvider.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.justify,
                            style: smallTextStyle,
                          ),
                          const VerticalSpacing(5),
                          Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "⌛ ${newsModelProvider.readingTimeText}",
                                style: smallTextStyle,
                              )),
                          FittedBox(
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                            child: NewsDetailsWebView(
                                              url: newsModelProvider.url,
                                            ),
                                            type:
                                                PageTransitionType.rightToLeft,
                                            inheritTheme: true,
                                            ctx: context),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.link,
                                      color: Colors.blue,
                                    )),
                                Text(
                                  newsModelProvider.dateToShow,
                                  maxLines: 1,
                                  style: smallTextStyle,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
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
}
