import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_paper_pj/widgets/empty_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../inner_screens/search_screen.dart';
import '../services/utils.dart';
import '../widgets/articles_widget.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: color),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          "Bookmarks",
          style: GoogleFonts.bonaNova(
            textStyle: TextStyle(
              letterSpacing: 0.2,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: EmptyNewsWidget(
        text: "Không có dữ liệu!",
        imagePath: 'assets/images/bookmark.png',
      ),
      // Expanded(
      //   child: ListView.builder(
      //       itemCount: 20,
      //       itemBuilder: (ctx, index) {
      //         return const ArticlesWidget();
      //       }),
      // ),
    );
  }
}
