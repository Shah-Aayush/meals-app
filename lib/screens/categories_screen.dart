import 'package:flutter/material.dart';

import '../widgets/category_item.dart';
import '../dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(15), //previously 25.
      children: DUMMY_CATEGORIES
          .map((catData) =>
              CategoryItem(catData.id, catData.title, catData.color))
          .toList(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent:
            200, //every child which spans crossaxis width. for screen size 300 : it will contain only  1 child but for screen size 500 : it will contain 2 children.
        childAspectRatio: 3 / 2, //shows that  for 200 width, I want 300 height.
        crossAxisSpacing: 20, //spacing between children
        mainAxisSpacing: 20, //spacing between children
      ),
    );
  }
}
