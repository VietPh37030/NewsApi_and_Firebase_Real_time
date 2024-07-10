//Packages
import 'package:flutter/material.dart';
import 'package:new_paper_pj/Landing/splash.dart';
import 'package:new_paper_pj/inner_screens/blog_details.dart';
import 'package:new_paper_pj/providers/news_provider.dart';
import 'package:provider/provider.dart';

//Screens
import 'screens/home_screen.dart';

//Consts
import 'consts/theme_data.dart';

//Providers
import 'providers/theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //Need it to access the theme Provider
  ThemeProvider themeChangeProvider = ThemeProvider();

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  //Fetch the current theme
  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
    await themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          //Notify about theme changes
          return themeChangeProvider;
        }),
        ChangeNotifierProvider(create: (_) {
          return NewsProvider();
        })
      ],
      child:
      //Notify about theme changes
      Consumer<ThemeProvider>(builder: (context, themeChangeProvider, ch) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'New App',
          theme: Styles.themeData(themeChangeProvider.getDarkTheme, context),
          home: const Splash(),
          routes: <String, WidgetBuilder>{
            NewsDetailsScreen.routeName :(ctx) => const NewsDetailsScreen(),
          },
        );
      }),
    );
  }
}
