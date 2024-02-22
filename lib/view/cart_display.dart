import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:machine_test_opine/controller/product_controller.dart';
import 'package:machine_test_opine/model/meal_model.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(MaterialApp(home: Cart(),));
}

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {

    ProductController productController = Provider.of<ProductController>(context);

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Cart Page"),
      ),

      body: productController.cart.isEmpty ? 
      Center(
        child: Text("No items added"),
      ) :
      ListView.builder(
        itemCount: productController.cart.length,
        itemBuilder: (context, index){
          Meal meal = productController.cart[index];
          return Padding(
            padding: EdgeInsets.all(screenWidth *0.02),
            child: Card(
              child: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 100,
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        child: CachedNetworkImage(
                          imageUrl: meal.strMealThumb ?? ""
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                Text(meal.strMeal ?? '', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                
                                SizedBox(height: 12),
                    
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                      color: Colors.black,
                                        borderRadius: BorderRadius.circular(50)
                                      ),
                                      child: IconButton(color: Colors.white,
                                        onPressed: (){
                                      productController.addCart(meal);
                                        }, icon: Icon(Icons.add)),
                                    ),
                    
                                    Container(
                                      decoration: BoxDecoration(
                                      color: Colors.black,
                                        borderRadius: BorderRadius.circular(50)
                                      ),
                                      child: IconButton(color: Colors.white,
                                        onPressed: (){
                                      productController.remove(meal);
                                        }, icon: Icon(Icons.remove)),
                                    ),
                    
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      color: Colors.yellow,
                                      child: Text(productController.total(meal).toString()))
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                        
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          productController.removeItem(meal);
                          ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.red,
                                    content: Text("Successfully removed item from cart"),
                                    duration: Duration(seconds: 2),));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                          decoration: BoxDecoration(
                          color: Colors.red,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text("Remove"),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
    );
  }
}