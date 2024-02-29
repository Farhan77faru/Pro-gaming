// ignore_for_file: unused_element, prefer_const_constructors, sort_child_properties_last, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';
import 'package:pro_gamer/Screens/cart_page/item_screen.dart';
// import 'package:pro_gamer/Carousel_Slider/Home_page_sliders/actions.dart';
// import 'package:pro_gamer/Carousel_Slider/Home_page_sliders/adventure.dart';
// import 'package:pro_gamer/Carousel_Slider/Home_page_sliders/puzzle.dart';
// import 'package:pro_gamer/Carousel_Slider/Home_page_sliders/roleplaying.dart';
// import 'package:pro_gamer/Carousel_Slider/Home_page_sliders/simulation.dart';
// import 'package:pro_gamer/Carousel_Slider/Home_page_sliders/sports.dart';
// import 'package:pro_gamer/Carousel_Slider/Home_page_sliders/strategy.dart';
import 'package:pro_gamer/Screens/navigator.dart';
import 'package:pro_gamer/Screens/settings.dart';
import 'package:pro_gamer/constants/dimensions.dart';
import 'package:pro_gamer/firebasehelper/firebase_firestore.dart';
import 'package:pro_gamer/model/product_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<ProductModel> productModelList;
  TextEditingController searchController = TextEditingController();
  List<ProductModel> filteredProductList = [];

  @override
  void initState() {
    super.initState();
    productModelList = [];
    _getCategoryList();
  }

  void _getCategoryList() async {
    try {
      FirebaseFirestoreHelper.instance.updateTokenFromFirebase();
      final List<ProductModel> productList =
          await FirebaseFirestoreHelper.instance.getfeaturedGames();
      setState(() {
        productModelList = productList;
        productModelList.shuffle();
      });
      print('Fetched products:');
      for (var product in productModelList) {
        print('Name: ${product.name}, Image: ${product.image}');
      }
    } catch (error) {
      print('Error fetching products: $error');
    }
  }

  final itemList = const [
    'https://www.tastefulspace.com/wp-content/uploads/2019/10/The-Video-Game-Advantage-Everything-to-Know-About-Online-Gaming.jpeg',
    'https://www.connectontech.com/wp-content/uploads/sites/38/2022/06/Video-Game-Picture1.jpg',
    'https://wallpapercave.com/wp/wp7664856.png'
  ];

  List<CarouselItem> get carouselItems => itemList
      .map((imageUrl) => CarouselItem(
            image: NetworkImage(imageUrl),
          ))
      .toList();

  void filterProducts(String query) {
    setState(() {
      filteredProductList = productModelList
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://yt3.ggpht.com/a/AATXAJxeUc08uxHE2j5ePdT4DhbSbAvVHxZ5s_MyCA=s900-c-k-c0xffffffff-no-rj-mo'), 
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BottomNavigation(),
              ),
            );
          },
        ),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              'Lets Play',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Settings(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: Stack(
              children: [
                InkWell(
                  onTap: () {
                    showSearch(
                        context: context,
                        delegate: ProductSearchDelegate(productModelList));
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.0, vertical: 13),
                    child: Text(
                      'Search...',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: ProductSearchDelegate(productModelList),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  SizedBox(height: 10),
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
                  SizedBox(height: 20),
                  productModelList.isEmpty
                      ? Center(
                          child: Text(
                            "No Games",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      :GridView.builder(
  itemCount: productModelList.length,
  primary: false,
  shrinkWrap: true,
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 0.66,
  ),
  itemBuilder: (context, index) {
    final product = productModelList[index];
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color:  const Color.fromARGB(255, 46, 45, 45),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              aspectRatio: 1, 
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  product.image,
                  fit: BoxFit.cover, 
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style:const TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
               const SizedBox(height: 10),
                Text(
                  "₹${product.price}",
                  style:const TextStyle(
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
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Chip(
        label: InkWell(
          onTap: onTap,
          child: Container(
            child: Text(
              label,
              style: TextStyle(color: Colors.black),
            ),
            width: 80, 
            height: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class ProductSearchDelegate extends SearchDelegate<String> {
  final List<ProductModel> productList;

  ProductSearchDelegate(this.productList);

  @override
  List<Widget> buildActions(BuildContext context) {

    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
  
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    
    final filteredProducts = productList
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ProductList(products: filteredProducts);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
  
    final suggestionList = productList
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ProductList(products: suggestionList);
  }
}

class ProductList extends StatelessWidget {
  final List<ProductModel> products;

  const ProductList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius10),
            color: Color(0xFFD4ECF7),
            boxShadow:const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: Dimensions.height10,
              bottom: Dimensions.height10,
              left: Dimensions.width10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '30% off',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: Dimensions.width10,
                    bottom: Dimensions.height15,
                  ),
                  child: InkWell(
                    onTap: () {
                 
                    },
                    child: Image.network(
                      product.image,
                      height: Dimensions.height150,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      Text(
                        "₹${product.price}",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
