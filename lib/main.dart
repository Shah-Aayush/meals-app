import 'package:flutter/material.dart';

import './models/meal.dart';
import './dummy_data.dart';
import './error_screen.dart';
import './screens/filters_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';
// import './screens/categories_screen.dart';
import './screens/tabs_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  final String routeName = '/';
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoritedMeals = [];

  bool _isMealFavorite(String id) {
    return _favoritedMeals.any((meal) => meal.id == id);
  }

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      print(
          'BEFORE : ${_filters['gluten']} ${_filters['lactose']} ${_filters['vegetarian']} ${_filters['vegan']}');
      _filters = filterData;
      print(
          'AFTER : ${_filters['gluten']} ${_filters['lactose']} ${_filters['vegetarian']} ${_filters['vegan']}');

      _availableMeals = DUMMY_MEALS.where((meal) {
        if ((_filters['gluten'] as bool) && !meal.isGlutenFree) {
          return false;
        }
        if ((_filters['lactose'] as bool) && !meal.isLactoseFree) {
          return false;
        }
        if ((_filters['vegan'] as bool) && !meal.isVegan) {
          return false;
        }
        if ((_filters['vegetarian'] as bool) && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoritedMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoritedMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoritedMeals
            .add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
              headline5: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              headline4: TextStyle(
                fontSize: 17,
                fontFamily: 'Raleway',
                color: Colors.black,
              ),
            ),
      ),
      // home: CategoriesScreen(),
      // initialRoute: '/', //default is '/'. if we want to provide another argument as default home route then we can define it here.
      routes: {
        //for the app which has multiple screens, this routes concept is useful as it  requires pre registration of all the screens which are available, so that we can see which routes/paths/screens are available through watching the main.dart file only. it is convenient for more screen apps.
        widget.routeName: (ctx) => TabsScreen(
            _favoritedMeals), //this defines the home screen of the page. it will work if we don't provide home key in materialApp.
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(
            _availableMeals), //defined without hardcoding the route value.
        // '/category-meals': (ctx) => CategoryMealsScreen(),       //defined with hardcoding the route value.
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_toggleFavorite, _isMealFavorite,),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
      },
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        print(settings.arguments);
        return MaterialPageRoute(
            builder: (ctx) =>
                MealDetailScreen(_toggleFavorite, _isMealFavorite));
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => ErrorScreen());
      },
    );
  }
}

/*
//we can add this in materialApp : 

onGenerateRoute: (settings) {
        //if some path is not defained in routes, then it will take to this default page provided here.
        print(settings.arguments);
        if (settings.name=='/meal-detail'){
          return ...;
        }
        else if(settings.name=='/category-meals'){
           return ...;
        }
        
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },


*/
