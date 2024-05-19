import 'package:flutter/material.dart';
import 'package:food_reciepe_app/config/routes/routes.dart';
import 'package:food_reciepe_app/view/screens/favourite_items_screen.dart';
import 'package:food_reciepe_app/view/screens/home.dart';
import 'package:food_reciepe_app/view/screens/splash_Screen.dart';

class Routes{
  static Route<dynamic>  generateRoute(RouteSettings settings){
    switch(settings.name){
      case RoutesName.splash:
        return MaterialPageRoute(builder: (BuildContext context) => const SplashScreen());

      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context) => const Home());


      case RoutesName.favourite:
        return MaterialPageRoute(builder: (BuildContext context)=> const FavoritesScreen());
        
      default:
        return MaterialPageRoute(builder: (_){
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });

    }
  }
}