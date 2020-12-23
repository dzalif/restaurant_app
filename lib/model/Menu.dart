import 'Drink.dart';
import 'Food.dart';

class Menu {
  List<Food> foods;
  List<Drink> drinks;

  Menu({this.foods, this.drinks});

  Menu.fromJson(Map<String, dynamic> json) {
    if (json['foods'] != null) {
      foods = new List<Food>();
      json['foods'].forEach((v) {
        foods.add(new Food.fromJson(v));
      });
    }
    if (json['drinks'] != null) {
      drinks = new List<Drink>();
      json['drinks'].forEach((v) {
        drinks.add(new Drink.fromJson(v));
      });
    }
  }
}