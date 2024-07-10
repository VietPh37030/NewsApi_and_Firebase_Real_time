import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_paper_pj/screens/bookmarks_screen.dart';
import 'package:new_paper_pj/screens/home_screen.dart';
import 'package:new_paper_pj/widgets/vertical_spacing.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Drawer(
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(child: Image.asset('assets/images/newspaper.png')),
                   Text('Fake247news',style: GoogleFonts.bonaNova(

                  ),),
                ],
              ),
            ),
            VerticalSpacing(20),
            ListTilesWidget(
              label: "Trang chủ",
              fct: () {
                Navigator.push(
                    context,
                    PageTransition(
                    child: const HomeScreen(),
                type: PageTransitionType.rightToLeft,
                inheritTheme: true,
                ctx:context
                ),
                );
              },
              icon: IconlyBold.home,
            ),
            ListTilesWidget(
              label: "Bookmarks",
              fct: () {
                Navigator.push(
                  context,
                  PageTransition(
                      child: const BookmarksScreen(),
                      type: PageTransitionType.rightToLeft,
                      inheritTheme: true,
                      ctx:context
                  ),


                );
              },
              icon: IconlyBold.bookmark,
            ),
            ListTilesWidget(
              label: "Liên hệ",
              fct: () {},
              icon: IconlyBold.calling,
            ),
            ListTilesWidget(
              label: "Chia sẻ App",
              fct: () {},
              icon: FontAwesomeIcons.shareAlt,
            ),
            Divider(thickness: 5,),
            SwitchListTile(
                title: Text(
                  themeProvider.getDarkTheme ? 'Dark' : 'Light',
                ),
                secondary: Icon(
                  themeProvider.getDarkTheme ? Icons.dark_mode : Icons.light_mode,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                value: themeProvider.getDarkTheme,
                onChanged: (bool value) {
                  setState(() {
                    themeProvider.setDarkTheme = value;
                  });
                }),
            // Thêm các ListTiles khác nếu cần
          ],
        ),
      ),
    );
  }
}

class ListTilesWidget extends StatelessWidget {
  const ListTilesWidget({
    Key? key,
    required this.label,
    required this.fct,
    required this.icon,
  }) : super(key: key);
  final String label;
  final Function fct;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.secondary,),
      title: Text(
        label,
        style: const TextStyle(fontSize: 16),
      ),
      onTap: () {
        fct();
      },
    );
  }
}
