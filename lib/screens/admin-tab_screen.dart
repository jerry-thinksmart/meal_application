import 'package:flutter/material.dart';
import '/screens/admin-categories_screen.dart';
import '/new_meal.dart';
import '../widgets/admin-main_drawer.dart';
import './admin-favorites_screen.dart';
import '../models/meal.dart';
// import '../widgets/meal_item.dart';
import '../dummy_data.dart';

class AdminTabsScreen extends StatefulWidget {
  static const routeName = '/admin-favorite-meals';

  final List<Meal> favoriteMeals;

  AdminTabsScreen(this.favoriteMeals);

  @override
  _AdminTabsScreenState createState() => _AdminTabsScreenState();
}

class _AdminTabsScreenState extends State<AdminTabsScreen> {
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
    final addMeal = Meal(
      id: id,
      categories: categories,
      title: title,
      imageUrl: imageURL,
      ingredients: ingredients,
      steps: steps,
      duration: duration,
      complexity: complexity,
      affordability: affordability,
      isGlutenFree: isGlutenFree,
      isLactoseFree: isLactoseFree,
      isVegan: isVegan,
      isVegetarian: isVegetarian,
    );

    setState(() {
      DUMMY_MEALS.add(addMeal);
    });
  }

  void _startAddNewMeal(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewMeal(_addNewMeal),
        );
      },
    );
  }

  List<Map<String, Object>>? _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': AdminCategoriesScreen(),
        'title': 'Admin Categories Screen',
      },
      {
        'page': AdminFavoritesScreen(widget.favoriteMeals),
        'title': 'Your Favorite',
      },
      {
        'page': NewMeal(_addNewMeal),
        'title': 'New Meal Items',
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages![_selectedPageIndex]['title'] as String),
      ),
      drawer: AdminMainDrawer(),
      body: _pages![_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        // selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        // type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            // title: Text('Categories'),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            // title: Text('Favorites'),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: IconButton(
              onPressed: () => _startAddNewMeal(context),
              icon: Icon(Icons.add),
            ),
            // title: Text('Categories'),
            label: 'Add',
          ),
        ],
      ),
    );
  }
}
