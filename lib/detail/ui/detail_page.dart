import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/network/api/api_service.dart';
import 'package:restaurant_app/detail/bloc/detail_restaurant_bloc.dart';
import 'package:restaurant_app/network/model/detail_restaurant_response.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Detail Restaurant'),
      ),
      body: BlocBuilder<DetailRestaurantBloc, DetailRestaurantState>(
        builder: (context, state) {
          if (state is DetailRestaurantInitial) {
            return _buildLoading();
          } else if (state is DetailRestaurantLoading) {
            return _buildLoading();
          } else if (state is DetailRestaurantNoInternet) {
            return _buildNoInternet();
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
      child: Text('There is unknown error', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildNoInternet() {
    return Center(
      child: Text('No internet connection, is your device online ?',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Category',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                  ),
                  _buildCategories(context, restaurant.categories),
                ],
              ),
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
          //REVIEWS
          Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Reviews',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                  ),
                  _buildReviews(context, restaurant.reviews)
                ],
              ),
            ),
          )
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

  Widget _buildCategories(BuildContext context, List<Category> categories) {
    return Container(
      height: 60,
      child: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return _buildCategoryItem(context, categories[index]);
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

  Widget _buildCategoryItem(BuildContext context, Category category) {
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
                colors: <Color>[Colors.green, Colors.lightGreen],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(category.name, style: TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildReviews(BuildContext context, List<Review> reviews) {
    return Container(
      height: 60,
      child: ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          return _buildReviewItem(context, reviews[index]);
        },
        shrinkWrap: true,
        physics: ScrollPhysics(),
      ),
    );
  }

  Widget _buildReviewItem(BuildContext context, Review review) {
    return ListTile(
      leading: Icon(Icons.account_circle),
      title: Text(review.name),
      subtitle: Text(review.review),
    );
  }

}
