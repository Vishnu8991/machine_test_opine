import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:machine_test_opine/model/category_model.dart';
import 'package:machine_test_opine/service/category_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:machine_test_opine/view/meal_display.dart';


class CategoryDisplay extends StatefulWidget {
  @override
  _CategoryDisplayState createState() => _CategoryDisplayState();
}

class _CategoryDisplayState extends State<CategoryDisplay> {
  List<Category> dataList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    try {
      var response = await HttpDataService.fetchData();
      var jsonData = json.decode(response);
      Categories categories = Categories.fromJson(jsonData);
      setState(() {
        dataList = categories.categories ?? [];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              alignment: Alignment.center,
              color: Colors.black87,
              height: screenHeight * 0.1,
              child: Text(
                "Try our new dishes today",
                style: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.02),
                child: ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    Category category = dataList[index];
                    return InkWell(
                      onTap: () => MealsDisplay(context, category.strCategory ?? ""),
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(screenWidth * 0.01),
                          height: screenHeight * 0.12,
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(screenWidth * 0.05),
                                child: CachedNetworkImage(imageUrl: category.strCategoryThumb ?? ""),
                              ),
                              Expanded(
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(category.strCategory ?? "", style: TextStyle(fontSize: screenWidth * 0.06, fontWeight: FontWeight.bold),),
                                      SizedBox(height: screenHeight * 0.01),
                                      Expanded(
                                        child: Text(category.strCategoryDescription ?? "", style: TextStyle(color: Colors.grey, fontSize: screenWidth * 0.030), maxLines: 3,),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void MealsDisplay(BuildContext context, String category) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => MealDisplay(category)),
  );
}
