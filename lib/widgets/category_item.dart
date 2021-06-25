import 'package:flutter/material.dart';

import '../screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color bgColor;

  CategoryItem(this.id, this.title, this.bgColor);

  void selectCategory(BuildContext ctx, String id, String title) {
    Navigator.of(ctx).pushNamed(
      CategoryMealsScreen.routeName, //dynamic value
      // '/category-meals', //hardcoded value
      arguments: {
        'id': id,
        'title': title,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //InkWell is simply a GestureDetector which fires also a Ripple Effect!
      onTap: () => selectCategory(context, id, title),
      splashColor: Theme.of(context).primaryColor, //color of wave when tapping
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [bgColor.withOpacity(0.7), bgColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(
              15), //here we can't use const keyword as circular is not defined as const.
        ),
      ),
    );
  }
}


/*
//wrap title :
Wrap(
        direction: Axis.vertical,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline6,
          )
        ],
      ),
*/

/*
// if we have less screen apps then we can manage screen and data b/w them via this simple materialPageRoute and pushing screens on stacks.


Navigator.of(ctx).push(   //adding/pushing new page to the stack
      MaterialPageRoute(
        builder: (_) {
          return CategoryMealsScreen(id, title);
        },
      ),
    );
*/