import 'package:flutter/material.dart';

import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';
  final Function toggleFavorite;
  final Function isFavorite;
  MealDetailScreen(this.toggleFavorite, this.isFavorite);

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      width: MediaQuery.of(context).size.width / 1.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
        // borderRadius: BorderRadius.circular(5),
        color: Colors.pink,
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }

  Widget buildListViewContainer({
    required BuildContext context,
    required Widget child,
  }) {
    return Container(
      height: MediaQuery.of(context).size.height / 5,
      width: MediaQuery.of(context).size.width / 1.2,
      child: Scrollbar(
        // isAlwaysShown: true,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => mealId == meal.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${selectedMeal.title}'), //single $ will not work as more than one arguments is added. so adding parenthesis will work.
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3.1,
              // height: 300,
              width: double.infinity,
              child: Hero(
                transitionOnUserGestures: true,
                tag: 'imageFor${selectedMeal.id}',
                child: FadeInImage.assetNetwork(
                  image: selectedMeal.imageUrl,
                  placeholder: 'assets/images/food-placeholder.png',
                  imageErrorBuilder: (context, error, stackTrace) =>
                      Image.asset('assets/images/error-placeholder.png'),

                  fit: BoxFit.cover, //will resize and crop the image
                ),
                // Image.network(
                //   selectedMeal.imageUrl,
                //   fit: BoxFit.cover,
                // ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  buildSectionTitle(context, 'Ingredients'),
                  buildListViewContainer(
                    context: context,
                    child: ListView.builder(
                      itemBuilder: (ctx, index) => Card(
                        color: Theme.of(context).accentColor,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: Text(selectedMeal.ingredients[index]),
                        ),
                      ),
                      itemCount: selectedMeal.ingredients.length,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  buildSectionTitle(context, 'Steps'),
                  buildListViewContainer(
                    context: context,
                    child: ListView.builder(
                      itemBuilder: (ctx, index) => Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              child: Text('${index + 1}'),
                            ),
                            title: Text(
                              selectedMeal.steps[index],
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                          Divider(),
                        ],
                      ),
                      itemCount: selectedMeal.steps.length,
                    ),
                  ),
                ],
              ),
            ),
            // ElevatedButton(onPressed: () {}, child: Text('hello'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          // Icons.delete,
          (isFavorite(mealId)) ? Icons.star : Icons.star_outline,
        ),
        onPressed: () {
          // Navigator.of(context).pop(mealId);
          toggleFavorite(mealId);
        },
      ),
    );
  }
}
