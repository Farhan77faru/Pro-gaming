// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';
import 'package:get/get.dart';
import 'package:pro_gamer/firebasehelper/firebase_firestore.dart';
import 'package:pro_gamer/model/category_model.dart';

import 'collection_page.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<CategoryModel> categoriesList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getCategoryList();
  }

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    FirebaseFirestoreHelper.instance.updateTokenFromFirebase();
    categoriesList = await FirebaseFirestoreHelper.instance.getCategories();
    setState(() {
      isLoading = false;
    });
  }

  final itemList = const [
    'https://tse4.mm.bing.net/th?id=OIP.cjaYp86sG24rq4bZhjwakQHaIA&pid=Api&P=0&h=220',
    'https://i.pinimg.com/originals/9e/70/b0/9e70b0c15b2f93191180df01d0463192.gif',
    'https://tse3.mm.bing.net/th?id=OIP.7G-O4c-hiQ-fASWvmihhiAAAAA&pid=Api&P=0&h=220'
  ];

  List<CarouselItem> get carouselItems => itemList
      .map((imageUrl) => CarouselItem(
            image: NetworkImage(imageUrl),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Categories",
          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Center(
            child: CustomCarouselSlider(
              items: carouselItems,
              height: 200,
              subHeight: 50,
              width: MediaQuery.of(context).size.width * 0.9,
              autoplay: true,
              showSubBackground: false,
              indicatorPosition: IndicatorPosition.none,
              showText: false,
            ),
          ),
        const  SizedBox(height: 30,),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                      ),
                      itemCount: categoriesList.length,
                      itemBuilder: (context, index) {
                        final category = categoriesList[index];
                        return CategorySelect(
                          imageUrl: category.image,
                          categoryModel: category,
                        );
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class CategorySelect extends StatelessWidget {
  final String imageUrl;
  final CategoryModel categoryModel;

  const CategorySelect({
    Key? key,
    required this.imageUrl,
    required this.categoryModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => CollectionPage(categoryModel: categoryModel),);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
  children: [
    Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding:const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7), 
          borderRadius: BorderRadius.circular(
          10
          ),
        ),
        child: Text(
          categoryModel.name,
          style:const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18, 
          ),
        ),
      ),
    ),
  ],
),

      ),
    );
  }
}
