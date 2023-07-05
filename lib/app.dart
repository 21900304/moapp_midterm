// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:midterm/search.dart';
import 'package:provider/provider.dart';


import 'FavoritePage.dart';
import 'home.dart';
import 'login.dart';
import 'more.dart';
import 'myPage.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => MyAppState(),
        child: MaterialApp(
          title: 'Shrine',
          initialRoute: '/login',
          routes: {
            '/favorite': (BuildContext context) => FavoritePage(),
            '/mypage': (BuildContext context) => const myPage(),
            '/search': (BuildContext context) => const SearchPage(),
            '/login': (BuildContext context) => const LoginPage(),
            '/': (BuildContext context) => const HomePage(),
          },
        ));
  }
}
class MyAppState extends ChangeNotifier {

  var favorites = [];
  var ids = [];
  var addresss = [];
  var stars = [];
  var phones = [];
  var dess = [];


  void toggleFavorite(int id, String name, String address, int star, String phone, String des) {
    if (favorites.contains(name)) {
      favorites.remove(name);
      ids.remove(id);
      addresss.remove(address);
      stars.remove(star);
      phones.remove(phone);
      dess.remove(des);
    } else {
      favorites.add(name);
      ids.add(id);
      addresss.add(address);
      stars.add(star);
      phones.add(phone);
      dess.add(des);
    }
    notifyListeners();
  }
}
