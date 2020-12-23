import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:restaurant_app/model/Drink.dart';
import 'package:restaurant_app/model/Food.dart';
import 'package:restaurant_app/model/Menu.dart';
import 'package:restaurant_app/model/Restaurant.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail_page';

  final Restaurant restaurant;

  const DetailPage({@required this.restaurant});

  Widget _buildFoods(BuildContext context, Menu menus) {
    return Container(
      height: 60,
      child: ListView.builder(
        itemCount: menus.foods.length,
        itemBuilder: (context, index) {
          return _buildFoodItem(context, menus.foods[index]);
        },
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: ScrollPhysics(),
      ),
    );
  }

  Widget _buildDrinks(BuildContext context, Menu menus) {
    return Container(
      height: 60,
      child: ListView.builder(
        itemCount: menus.drinks.length,
        itemBuilder: (context, index) {
          return _buildDrinkItem(context, menus.drinks[index]);
        },
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: ScrollPhysics(),
      ),
    );
  }

  Widget _buildFoodItem(BuildContext context, Food food) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Colors.deepOrange, Colors.deepOrangeAccent],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(food.name, style: TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDrinkItem(BuildContext context, Drink drink) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Colors.orange, Colors.orangeAccent],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(drink.name, style: TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Hero(
                    tag: restaurant.pictureId,
                    child: Image.network(restaurant.pictureId),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8.0,),
                          Text(
                            restaurant.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                fontFamily: 'Merriweather'),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: Icon(Icons.location_on,
                                    size: 16.0, color: Colors.deepOrange),
                              ),
                              Text(
                                restaurant.city,
                                style: TextStyle(color: Colors.deepOrange),
                              )
                            ],
                          ),
                          SizedBox(height: 16.0),
                          Text(restaurant.description),
                          SizedBox(height: 8.0),
                        ],
                      ))
                ],
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Foods',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                  ),
                  _buildFoods(context, restaurant.menus),
                ],
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Drinks',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                  ),
                  _buildDrinks(context, restaurant.menus),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
