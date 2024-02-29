// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pro_gamer/Screens/profile/single_favorite.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          "Favorites",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: appProvider.getfavoriteProductList.isEmpty
          ? const Center(
              child: Text(
                "No Favorite Items",
                style: TextStyle(color: Colors.white),
              ),
            )
          : ListView.builder(
              itemCount: appProvider.getfavoriteProductList.length,
              itemBuilder: ((context, index) {
                return SingleFavoriteCard(
                    singleProduct: appProvider.getfavoriteProductList[index]);
              }),
            ),
    );
  }
}
