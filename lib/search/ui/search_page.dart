import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant_app/detail/ui/detail_page.dart';
import 'package:restaurant_app/network/api/api_service.dart';
import 'package:restaurant_app/network/model/restaurant_response.dart';
import 'package:restaurant_app/search/bloc/search_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();
  SearchBloc searchBloc;

  @override
  void initState() {
    super.initState();
    searchBloc = BlocProvider.of<SearchBloc>(context);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Restaurant'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: (text) {
                    searchBloc.add(SearchRestaurant(text));
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search restaurant..'),
                ),
                _buildState()
              ],
            ),
          ),
        ),
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

  Widget _buildNoData() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Text('There is no restaurant found',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildError() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Text('There is unknown error',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildInitial() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/ic_search.svg',
            width: 70,
            height: 70,
          ),
          SizedBox(
            height: 16,
          ),
          Text('Please search for restaurant'),
        ],
      ),
    );
  }

  Widget _buildNoInternet() {
    return Center(
      child: Text('No internet connection, is your device online ?',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildList(List<Restaurant> restaurants) {
    return ListView.builder(
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        return _buildListItem(restaurants[index]);
      },
      shrinkWrap: true,
      physics: ScrollPhysics(),
    );
  }

  Widget _buildListItem(Restaurant restaurant) {
    return GestureDetector(
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

  Widget _buildState() {
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      if (state is SearchInitial) {
        return _buildInitial();
      } else if (state is SearchSuccess) {
        return _buildList(state.restaurants);
      } else if (state is SearchNoData) {
        return _buildNoData();
      } else if (state is SearchLoading) {
        return _buildLoading();
      } else if (state is SearchNoInternet) {
        return _buildNoInternet();
      } else if (state is SearchError) {
        return _buildError();
      } else {
        return _buildLoading();
      }
    });
  }
}
