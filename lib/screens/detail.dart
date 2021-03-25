import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_eats/notifier/food_notifier.dart';
import 'package:urban_eats/screens/food_add_form.dart';

class FoodDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);
    return Scaffold(
      appBar: AppBar(title: Text(foodNotifier.currentFood.name)),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                Image.network(foodNotifier.currentFood.image != null
                    ? foodNotifier.currentFood.image
                    : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg'),
                SizedBox(
                  height: 32,
                ),
                Text(
                  foodNotifier.currentFood.name,
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
                Text(foodNotifier.currentFood.category,
                    style:
                        TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
                Text(
                  foodNotifier.currentFood.price,
                  style: TextStyle(fontSize: 20),
                )
                /*GridView.count(
                shrinkWrap: true, 
                crossAxisCount: 3,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                /*children: foodNotifier.currentFood.subIngredients.map((ingredient) => Card(
                  color: Colors.black54,
                  child: Center(
                    child: Text(ingredient),
                  ),
                )).toList()*/
                )*/
              ],
            ),
            
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return FoodAddForm(
                  isUpdating: true,
                );
              },
            ),
          );
        },
        child: Icon(Icons.edit),
        foregroundColor: Colors.white,
      ),
    );
  }
}
