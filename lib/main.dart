import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/detail/bloc/detail_restaurant_bloc.dart';
import 'package:restaurant_app/home/bloc/restaurant_bloc.dart';
import 'package:restaurant_app/detail/ui/detail_page.dart';
import 'package:restaurant_app/home/ui/home_page.dart';
import 'package:restaurant_app/search/bloc/search_bloc.dart';
import 'package:restaurant_app/search/ui/search_page.dart';
import 'package:restaurant_app/splash/splash_screen_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RestaurantBloc>(
          create: (context) => RestaurantBloc(),
        ),
        BlocProvider<DetailRestaurantBloc>(
          create: (context) => DetailRestaurantBloc(),
        ),
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Restaurant App',
        theme: ThemeData(
          primarySwatch: Colors.red,
          accentColor: Colors.redAccent
        ),
        initialRoute: SplashScreenPage.routeName,
        routes: {
          SplashScreenPage.routeName: (context) => SplashScreenPage(),
          HomePage.routeName: (context) => HomePage(),
          DetailPage.routeName: (context) => DetailPage(
              restaurantId: ModalRoute.of(context).settings.arguments),
          SearchPage.routeName: (context) => SearchPage(),
        },
      ),
    );
  }
}

