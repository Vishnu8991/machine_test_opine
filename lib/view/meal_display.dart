import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:machine_test_opine/controller/product_controller.dart';
import 'package:machine_test_opine/model/meal_model.dart';
import 'package:machine_test_opine/service/meal_service.dart';
import 'package:machine_test_opine/view/cart_display.dart';
import 'package:provider/provider.dart';



class MealDisplay extends StatefulWidget {
  final String strCategory;

  MealDisplay(this.strCategory);

  @override
  _MealDisplayState createState() => _MealDisplayState();
}

class _MealDisplayState extends State<MealDisplay> {
  List<Meal> mealList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    try {
      var response = await HttpMealService.fetchMeals(widget.strCategory);
      var jsonData = json.decode(response);
      Meals meals = Meals.fromJson(jsonData);
      setState(() {
        mealList = meals.meals!;
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    ProductController productController = Provider.of<ProductController>(context); 

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child:
            IconButton(
              onPressed: (){Navigator.push(
               context,
               MaterialPageRoute(builder: (context) => Cart()),
                );
              }, 
              icon: Icon(Icons.shopping_cart, color: Colors.red,)) 
          )],
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(widget.strCategory),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(screenWidth * 0.02),
              child: GridView.builder(
                itemCount: mealList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (context, index) {
                  Meal meal = mealList[index];
                  return Padding(
                    padding: EdgeInsets.all(screenWidth * 0.02),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenWidth * 0.02)),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(screenWidth * 0.02),
                            image: DecorationImage(image: NetworkImage(meal.strMealThumb ?? ""), fit: BoxFit.cover)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              color: Colors.black87,
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.all(screenWidth * 0.01),
                                child: Column(
                                  children: [
                                    Text(
                                      meal.strMeal ?? "",
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                    

                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                      child: InkWell(
                                        onTap: (){
                                          productController.add(meal);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text("Successfully added to cart"),
                                    duration: Duration(seconds: 2),));
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: double.infinity,
                                          color: Colors.yellow,
                                          child: 
                                          Text("Add to cart")
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
