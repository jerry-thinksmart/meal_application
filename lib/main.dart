import 'package:flutter/material.dart';
import 'package:meal_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import '/login_page.dart';
import '/new_meal.dart';
import '/screens/admin-categories_screen.dart';
import '/screens/admin-tab_screen.dart';
import './screens/auth_screen.dart';
import './providers/auth.dart';

import './dummy_data.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/filters_screen.dart';
import './screens/categories_screen.dart';
import './models/meal.dart';
import './login_details.dart';
import './screens/meal_screen.dart';
import './providers/products.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<LoginDetails> _userDetails = [];

  void _addNewLoginDetails(String loginEmail, double loginPassword) {
    final newLogin = LoginDetails(
      email: loginEmail,
      password: loginPassword,
    );
    setState(() {
      _userDetails.add(newLogin);
    });
  }

  void _addNewMeal(
    String id,
    List<String> categories,
    String title,
    String imageURL,
    List<String> ingredients,
    List<String> steps,
    int duration,
    Complexity complexity,
    Affordability affordability,
    bool isGlutenFree,
    bool isLactoseFree,
    bool isVegan,
    bool isVegetarian,
  ) {
    // final addMeal = Meal(
    //   id: id,
    //   categories: categories,
    //   title: title,
    //   imageUrl: imageURL,
    //   ingredients: ingredients,
    //   steps: steps,
    //   duration: duration,
    //   complexity: complexity,
    //   // affordability: afforfdability,
    //   isGlutenFree: isGlutenFree,
    //   isLactoseFree: isLactoseFree,
    //   isVegan: isVegan,
    //   isVegetarian: isVegetarian,
    // );

    setState(() {
      // DUMMY_MEALS.add(addMeal);
    });
  }

  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
        );
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: Products(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
            title: 'DeliMeals',
            theme: ThemeData(
              primarySwatch: Colors.pink,
              // accentColor: Colors.amber,
              canvasColor: Color.fromRGBO(255, 254, 229, 1),
              fontFamily: 'Raleway',
              textTheme: ThemeData.light().textTheme.copyWith(
                      // body1: TextStyle(
                      //   color: Color.fromRGBO(20, 51, 51, 1),
                      // ),
                      // body2: TextStyle(
                      //   color: Color.fromRGBO(20, 51, 51, 1),
                      // ),
                      subtitle1: TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold,
                  )),
            ),
            home: auth.isAuth
                ? TabsScreen(_favoriteMeals)
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen(),
                  ),
            // initialRoute: '/', // default is '/'
            routes: {
              // '/': (ctx) => LoginPage(_addNewLoginDetails),
              AuthScreen.routeName: (context) => AuthScreen(),
              LoginPage.routeName: (context) => LoginPage(_addNewLoginDetails),
              NewMeal.routeName: (context) => NewMeal(_addNewMeal),
              AdminTabsScreen.routeName: (context) =>
                  AdminTabsScreen(_favoriteMeals),
              TabsScreen.routeName: (context) => TabsScreen(_favoriteMeals),
              AdminCategoriesScreen.routeName: (context) =>
                  AdminCategoriesScreen(),
              CategoriesScreen.routeName: (context) => CategoriesScreen(),
              CategoryMealsScreen.routeName: (ctx) =>
                  CategoryMealsScreen(_availableMeals),
              MealDetailScreen.routeName: (ctx) =>
                  MealDetailScreen(_toggleFavorite, _isMealFavorite),
              FiltersScreen.routeName: (ctx) =>
                  FiltersScreen(_filters, _setFilters),
              EditProductScreen.routeName: (ctx) => EditProductScreen(),
            },
            onGenerateRoute: (settings) {
              print(settings.arguments);
              // if (settings.name == '/meal-detail') {
              //   return ...;
              // } else if (settings.name == '/something-else') {
              //   return ...;
              // }
              // return MaterialPageRoute(builder: (ctx) => CategoriesScreen(),);
            },
            onUnknownRoute: (settings) {
              return MaterialPageRoute(
                builder: (ctx) => CategoriesScreen(),
              );
            }),
      ),
    );
  }
}
