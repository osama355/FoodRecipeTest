import 'package:flutter/material.dart';
import 'package:food_reciepe_app/config/routes/routes.dart';
import 'package:food_reciepe_app/config/routes/routes_name.dart';
import 'package:food_reciepe_app/provider/favourite_item_provider.dart';
import 'package:food_reciepe_app/provider/search_provide.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SearchProvider()),
          ChangeNotifierProvider(create: (_) => FavouriteItemProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: "Poppins",
            useMaterial3: true,
          ),
          initialRoute: RoutesName.splash,
          onGenerateRoute: Routes.generateRoute,
        ));
  }
}
