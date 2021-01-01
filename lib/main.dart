import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/detail/detail_restaurant_bloc.dart';
import 'package:restaurant_app/bloc/list/restaurant_bloc.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/ui/home_page.dart';
import 'package:restaurant_app/ui/splash_screen_page.dart';

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
        },
      ),
    );
  }
}

