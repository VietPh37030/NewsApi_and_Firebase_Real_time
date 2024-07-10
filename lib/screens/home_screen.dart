import 'dart:developer';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:new_paper_pj/consts/vars.dart';
import 'package:new_paper_pj/inner_screens/search_screen.dart';
import 'package:new_paper_pj/providers/news_provider.dart';
import 'package:new_paper_pj/services/news_api.dart';
import 'package:new_paper_pj/widgets/articles_widget.dart';
import 'package:new_paper_pj/widgets/drawer_widget.dart';
import 'package:new_paper_pj/widgets/empty_screen.dart';
import 'package:new_paper_pj/widgets/loading_widget.dart';
import 'package:new_paper_pj/widgets/tabs.dart';
import 'package:new_paper_pj/widgets/vertical_spacing.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../models/news_model.dart';
import '../providers/theme_provider.dart';
import '../services/utils.dart';
import '../widgets/top_tending.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var newstype = NewType.allNews;
  int currentPageIndex = 0;
  String sortBy = SortByEnum.publishedAt.name;

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    final newsProvider = Provider.of<NewsProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: color),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Báo nhảm nhí",
                style: GoogleFonts.bonaNova(
                  textStyle: const TextStyle(
                    letterSpacing: 0.2,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Lottie.asset(
                'assets/lottie/bitcoin.json',
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    child: const SearchScreen(),
                    type: PageTransitionType.rightToLeft,
                    inheritTheme: true,
                    ctx: context,
                  ),
                );
              },
              icon: const Icon(IconlyLight.search),
            ),
          ],
        ),
        drawer: const DrawerWidget(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  TabsWidget(
                    text: 'Fake247news',
                    color: newstype == NewType.allNews
                        ? Theme.of(context).cardColor
                        : Colors.transparent,
                    function: () {
                      if (newstype == NewType.allNews) {
                        return;
                      }
                      setState(() {
                        newstype = NewType.allNews;
                      });
                    },
                    fontSize: newstype == NewType.allNews ? 16 : 14,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  TabsWidget(
                    text: 'Top trending',
                    color: newstype == NewType.topTrending
                        ? Theme.of(context).cardColor
                        : Colors.transparent,
                    function: () {
                      if (newstype == NewType.topTrending) {
                        return;
                      }
                      setState(() {
                        newstype = NewType.topTrending;
                      });
                    },
                    fontSize: newstype == NewType.topTrending ? 16 : 14,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  TabsWidget(
                    text: 'Thị trường',
                    color: newstype == NewType.market
                        ? Theme.of(context).cardColor
                        : Colors.transparent,
                    function: () {
                      if (newstype == NewType.market) {
                        return;
                      }
                      setState(() {
                        newstype = NewType.market;
                      });
                    },
                    fontSize: newstype == NewType.market ? 16 : 14,
                  ),
                ],
              ),
              VerticalSpacing(10),
              newstype == NewType.topTrending
                  ? Container()
                  : SizedBox(
                height: kBottomNavigationBarHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    paginationButtons(
                      text: 'Quay lại',
                      funtion: () {
                        if (currentPageIndex == 0) {
                          return;
                        }
                        setState(() {
                          currentPageIndex -= 1;
                        });
                      },
                    ),
                    Flexible(
                      flex: 2,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              color: currentPageIndex == index
                                  ? Colors.blue
                                  : Theme.of(context).cardColor,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    currentPageIndex = index;
                                  });
                                },
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("${index + 1}"),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    paginationButtons(
                      text: 'Chuyển',
                      funtion: () {
                        if (currentPageIndex == 9) {
                          return;
                        }
                        setState(() {
                          currentPageIndex += 1;
                        });
                      },
                    ),
                  ],
                ),
              ),
              VerticalSpacing(10),
              newstype == NewType.topTrending
                  ? Container()
                  : Align(
                alignment: Alignment.topRight,
                child: Material(
                  color: Theme.of(context).cardColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: DropdownButton(
                      value: sortBy,
                      items: dropDownItems,
                      onChanged: (String? value) {
                        setState(() {
                          sortBy = value!;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const VerticalSpacing(10),
              FutureBuilder<List<NewsModel>>(
                future: newstype == NewType.topTrending
                    ? newsProvider.fetchTopHeadlines()
                    : newsProvider.fetchAllNews(
                    pageIndex: currentPageIndex + 1, sortBy: sortBy),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return newstype == NewType.allNews
                        ? LoadingWidget(
                      newsType: newstype,
                    )
                        : Expanded(
                      child: LoadingWidget(
                        newsType: newstype,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Expanded(
                      child: EmptyNewsWidget(
                          text: "BUGGGGGGG ${snapshot.error}",
                          imagePath: "assets/images/no_news.png"),
                    );
                  } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return Expanded(
                      child: EmptyNewsWidget(
                          text: "Không tìm thấy tin tức nào",
                          imagePath: "assets/images/no_news.png"),
                    );
                  }
                  return newstype == NewType.allNews
                      ? Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (ctx, index) {
                          return ChangeNotifierProvider.value(
                            value: snapshot.data![index],
                            child: const ArticlesWidget(),
                          );
                        }),
                  )
                      : SizedBox(
                    height: size.height * 0.6,
                    child: Swiper(
                      autoplayDelay: 8000,
                      autoplay: true,
                      itemWidth: size.width * 0.9,
                      layout: SwiperLayout.STACK,
                      viewportFraction: 0.9,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                          value: snapshot.data![index],
                          child: TopTrendingWidget(),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> get dropDownItems {
    List<DropdownMenuItem<String>> menuItem = [
      DropdownMenuItem(
        value: SortByEnum.relevancy.name,
        child: Text("Liên quan"),
      ),
      DropdownMenuItem(
        value: SortByEnum.popularity.name,
        child: Text("Phổ biến"),
      ),
      DropdownMenuItem(
        value: SortByEnum.publishedAt.name,
        child: Text("Mới nhất"),
      ),
    ];

    return menuItem;
  }

  Widget paginationButtons({required Function funtion, required String text}) {
    return ElevatedButton(
      onPressed: () {
        funtion();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.blueAccent;
          }
          return Colors.red;
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      child: Text(text),
    );
  }
}