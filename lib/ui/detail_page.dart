import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/api/api_service.dart';
import 'package:restaurant_app/bloc/detail/detail_restaurant_bloc.dart';
import 'package:restaurant_app/model/detail_restaurant_response.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/detail_page';

  final String restaurantId;

  const DetailPage({@required this.restaurantId});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    context.read<DetailRestaurantBloc>()..add(GetDetailRestaurant(widget.restaurantId));
    super.initState();
  }

  Widget _buildLoading() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Text('There is unknown error'),
    );
  }

  Widget _buildRestaurant(BuildContext context, DetailRestaurant restaurant) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                Hero(
                  tag: ApiService.BASE_URL_IMAGE + restaurant.pictureId,
                  child: Image.network(ApiService.BASE_URL_IMAGE + restaurant.pictureId),
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
    );
  }

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
        title: Text('Detail Restaurant'),
        backgroundColor: Colors.orange,
      ),
      body: BlocBuilder<DetailRestaurantBloc, DetailRestaurantState>(
        builder: (context, state) {
          if (state is DetailRestaurantInitial) {
            return _buildLoading();
          } else if (state is DetailRestaurantLoading) {
            return _buildLoading();
          } else if (state is DetailRestaurantSuccess) {
            return _buildRestaurant(context, state.restaurant.restaurant);
          } else if (state is DetailRestaurantError) {
            return _buildError();
          } else {
            return _buildLoading();
          }
        },
      ),
    );
  }
}
