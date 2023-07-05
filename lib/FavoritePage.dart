import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../more.dart';
import 'app.dart';
import 'model/product.dart';
import 'model/products_repository.dart';
import 'more.dart';

class FavoritePage extends StatefulWidget {
  FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();

}

class _FavoritePageState extends State<FavoritePage> {

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    const title = 'Favorite Hotel';

    if (appState.favorites.isEmpty) {
      return const Center(
        child: Text('No favorites yet.'),
      );
    }

    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
            title: const Text(title),
            centerTitle: true
        ),
        body: ListView.builder(
          itemCount: appState.favorites.length,
          itemBuilder: (context, index) {
            final item = appState.favorites[index];
            return Dismissible(
              key: Key(item),
              onDismissed: (direction) {
                setState(() {
                  appState.favorites.removeAt(index);
                });
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('$item dismissed')));
              },
              background: Container(color: Colors.red),
              child: ListTile(
                title: Text(item),
              ),
            );
          },
        ),
      ),
    );
  }
}
