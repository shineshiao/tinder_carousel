

import 'package:localstorage/localstorage.dart';
import 'package:tinder_carousel/models/models.dart';
import 'package:tinder_carousel/models/name.dart';

class FavoriteListRepository {

  FavoriteListRepository();
  final LocalStorage storage = new LocalStorage('tinder_app');
  Future<List<User>> loadFavoriteList() async {
    await storage.ready;
    List<User> userList = new List();
    var items = storage.getItem('favorite_list');
    if (items != null) {
      userList = List<User>.from(
        (items as List).map(
          (result) => User(
          gender: result["gender"],
          name: Name.fromJson(result["name"]),
          location: Location.fromJson(result["location"]),
          email: result["email"],
          login: LoginInfo.fromJson(result["login"]),
          dob: DateTime.parse(result["dob"]),
          registered: DateTime.parse(result["registered"]),
          phone: result["phone"],
          cell: result["cell"],
          id: result["id"],
          picture: result["picture"],
          nat: result["nat"]
        ),
        ),
      );
    }
    return userList;
  }

  Future<void> saveFavoriteList(List<User> userList) async {
    await storage.ready;
    storage.setItem('favorite_list', userList);
  }
  
  Future<void> clearFavoriteList() async {
    await storage.ready;
    storage.clear();
  }
}