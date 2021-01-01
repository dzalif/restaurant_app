import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/api/api_service.dart';
import 'package:restaurant_app/bloc/list/restaurant_bloc.dart';
import 'package:restaurant_app/model/restaurant_response.dart';
import 'package:restaurant_app/ui/detail_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<RestaurantBloc>()..add(GetListRestaurant());
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

  Widget _buildList(BuildContext context, RestaurantResponse response) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context)
          .loadString('assets/local_restaurant.json'),
      builder: (context, snapshot) {
        List<Restaurant> restaurants = response.restaurants;
        return ListView.builder(
          itemCount: restaurants.length,
          itemBuilder: (context, index) {
            return _buildRestaurantItem(context, restaurants[index]);
          },
          shrinkWrap: true,
          physics: ScrollPhysics(),
        );
      },
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return  GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DetailPage.routeName,
            arguments: restaurant.id);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                    child: Hero(
                      tag: ApiService.BASE_URL_IMAGE + restaurant.pictureId,
                      child: Image.network(
                        ApiService.BASE_URL_IMAGE + restaurant.pictureId,
                        fit: BoxFit.fill,
                      ),
                    )),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 2.0, 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              restaurant.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style:
                              const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Padding(
                                padding: EdgeInsets.only(bottom: 2.0)),
                            Text(
                              restaurant.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.black54,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                  size: 16.0,
                                ),
                                Text(restaurant.rating.toString()),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Restaurant',
          style: TextStyle(fontFamily: 'Merriweather'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {

            },
          )
        ],
      ),
      body: Container(
          child: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'List of Restaurants',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Merriweather'),
                  ),
                ),
              ),
              BlocBuilder<RestaurantBloc, RestaurantState>(
                  builder: (context, state) {
                    if (state is RestaurantLoading) {
                      return _buildLoading();
                    } else if (state is RestaurantSuccess) {
                      return _buildList(context, state.restaurants);
                    } else if (state is RestaurantError) {
                      return _buildError();
                    } else {
                      return _buildLoading();
                    }
                  }
              )
            ],
          ),
        ),
      )),
    );
  }
}
