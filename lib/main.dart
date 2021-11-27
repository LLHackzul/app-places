import 'package:app_places/screens/user_favorites_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/tabs_screen.dart';
import './providers/places_provider.dart';
import './screens/place_detail_screen.dart';
import './screens/site_detail_screen.dart';
import './providers/auth.dart';

import './providers/site.dart';
import './providers/sites_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => Auth(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => Places(),
          ),
          ChangeNotifierProxyProvider<Auth, Sites>(
            update: (ctx, auth, previousSites) => Sites(
                previousSites == null ? [] : previousSites.items,
                auth.isAuth ? auth.userId : ''),
            create: (ctx) => Sites([], ''),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, authData, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                  color: Colors.white,
                  iconTheme: IconThemeData(color: Colors.black87)),
              primarySwatch: Colors.pink,
              canvasColor: const Color.fromRGBO(255, 254, 229, 1),
              scaffoldBackgroundColor: Colors.white,
              textTheme: ThemeData.light().textTheme.copyWith(
                    bodyText1:
                        const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                    bodyText2:
                        const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                  ),
            ),
            home: authData.isAuth
            ? TabsScreen()
            : FutureBuilder(
              future: authData.tryAutoLogin(),
              builder: (ctx, authResultSnapshot)=>
              authResultSnapshot.connectionState==ConnectionState.waiting
                ? Center(child: CircularProgressIndicator(),): TabsScreen()),
            routes: {
              PlaceDetailScreen.routeName: (ctx) => PlaceDetailScreen(),
              SiteDetailScreen.routeName: (ctx) => SiteDetailScreen(),
              UserFavoritesScreen.routeName: (ctx)=> UserFavoritesScreen(),
            },
          ),
        ));
  }
}
