// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pro_gamer/Screens/cart_page/item_screen.dart';
import 'package:pro_gamer/constants/dimensions.dart';
import 'package:pro_gamer/firebasehelper/firebase_firestore.dart';
import 'package:pro_gamer/model/category_model.dart';

import '../model/product_model.dart';

class CollectionPage extends StatefulWidget {
  final CategoryModel categoryModel;
  const CollectionPage({super.key, required this.categoryModel});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  List<ProductModel> productModelList = [];
  bool isLoading = false;
  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    productModelList = await FirebaseFirestoreHelper.instance
        .getCategoryProducts(widget.categoryModel.id);
    productModelList.shuffle();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
                  iconTheme: IconThemeData(color: Colors.white),

          centerTitle: true,
          title: Text(
            "Collections",
            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
          ),
        ),
        body: isLoading
            ? Center(
                child: Container(
                  height: Dimensions.height100,
                  width: Dimensions.width100,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          widget.categoryModel.name,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                      ),
                      productModelList.isEmpty
                          ? Center(
                              child: Text("Products is Empty",
                              style: TextStyle(color: Colors.white),),
                            )
                          : GridView.builder(
                              itemCount: productModelList.length,
                              primary: false,
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.66,
                              ),
                              itemBuilder: (context, index) {
                                final product = productModelList[index];
                                return Container(
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromARGB(255, 33, 33, 33),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ItemScreen(
                                                singleProduct: product,
                                              ),
                                            ),
                                          );
                                        },
                                        child: AspectRatio(
                                          aspectRatio:
                                              1, 
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              product.image,
                                              fit: BoxFit
                                                  .cover, 
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product.name,
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              "₹${product.price}",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ],
                  ),
                ),
              ));
  }
}
