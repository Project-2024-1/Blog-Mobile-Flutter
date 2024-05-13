import 'dart:async';

import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:tudotaichinh/page/home/home_page.dart';
import 'package:tudotaichinh/page/splash/splash_page.dart';
import 'package:tudotaichinh/provider/home_tab/HomeTabNotifier.dart';

class Application extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Application();
}

class _Application extends State<Application> {
  bool _initialized = false;
  final GlobalKey<NavigatorState> _navigator = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // _subscription?.cancel();
    super.dispose();
  }

  Widget _root() {
    print('run root');
    return MaterialApp(
      title: 'ONGRIT',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('ja', ''), // Japan language, no country code
      ],
      theme: ThemeData(
        // fontFamily: 'HiraginoKakuGothicPro',
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff95C1E7),
        ),
        primaryColorDark: Color.fromRGBO(24, 25, 27, 1),
        primaryColor: Color(0xff95C1E7),
        textTheme:
            const TextTheme(bodyText2: TextStyle(color: Color(0xff1c1c1c))),
        tabBarTheme: TabBarTheme(),
      ),
      initialRoute: '/splash',
      navigatorKey: _navigator,
      routes: {
        '/splash': (context) => const SplashPage(),

        // '/login': (context) => LoginPage(),
        //
        // '/auth/register': (context) => RegisterPage(),
        //
        // '/auth/send-mail-forgot-password': (context) => SendEmailForgotPasswordPage(),
        //
        // '/auth/resend-verify-email-after': (context) => SendEmailForgotPasswordAfterPage(),

        '/home': (context) => const HomePage(),

        // '/chat_list_friend_group' : (context) {
        //   final args = ModalRoute.of(context)!.settings.arguments as Map?;
        //   final getConversations = args?['get_conversations'];
        //   return  ChatListPageGroup(getConversations: getConversations);
        // },
      },
    );
  }

  Widget buildProvider() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeTabNotifier>(
          create: (context) => HomeTabNotifier(),
          lazy: false,
        ),
      ],
      child: buildWrapRootChild(),
    );
  }

  Widget buildWrapRootChild() {
    // if (_initialized == false) {
    //   return MaterialApp(
    //     routes: {"/": (context) => Container(
    //       child: Text('error'),
    //     )},
    //   ); // empty app
    // }
    return OverlaySupport.global(child: _root());
  }

  @override
  Widget build(BuildContext context) {
    return buildProvider();
  }
}
