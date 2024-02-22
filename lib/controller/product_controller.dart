import 'package:flutter/material.dart';
import 'package:machine_test_opine/model/meal_model.dart';

class ProductController extends ChangeNotifier{
  
  List <Meal> cart = [];
  Map<Meal, int> quantity = {};

  void add(Meal meal){
    if (!cart.contains(meal)) {
    cart.add(meal);
    quantity[meal] = 1;
    notifyListeners();
    }
  }


  void addCart(Meal meal){
    if (!cart.contains(meal)) {
    cart.add(meal);
    quantity[meal] = 1;
    notifyListeners();
    }
    else{
      quantity[meal] = quantity[meal]!+1;
    }
    notifyListeners();
  }
      

  void remove(Meal meal){
    if (quantity.containsKey(meal)) {
      if (quantity[meal]! > 1) {
        quantity[meal] = quantity[meal]!-1;
      notifyListeners();
      }else{
      cart.remove(meal);
      quantity.remove(meal);
    notifyListeners();

      }
    }
  }

  void removeItem(Meal meal){
    cart.remove(meal);
    quantity.remove(meal);
    notifyListeners();
  }

  int total(Meal meal){
    return quantity[meal] ?? 0;
  }
}