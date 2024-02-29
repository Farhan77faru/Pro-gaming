// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:pro_gamer/constants/dimensions.dart';
import 'package:pro_gamer/firebasehelper/firebase_firestore.dart';
import 'package:pro_gamer/model/order_model.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          title: Text(
            "Your Purchased Items",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: FutureBuilder(
            future: FirebaseFirestoreHelper.instance.getUserOrder(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.data!.isEmpty ||
                  snapshot.data == null ||
                  !snapshot.hasData) {
                return const Center(
                  child: Text(
                    "No order Found",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    OrderModel orderModel = snapshot.data![index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ExpansionTile(
                          tilePadding: EdgeInsets.zero,
                          collapsedShape: const RoundedRectangleBorder(
                              side: BorderSide(color: Colors.red, width: 2.3)),
                              
                          shape: const RoundedRectangleBorder(
                              side: BorderSide(color: Colors.red, width: 2.3)),
                              
                          title: Row(
                            
                            children: [
                              
                            Container(
                              height: Dimensions.height150,
                              width: Dimensions.width130,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      orderModel.products[0].image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(orderModel.products[0].name,
                                        style: const TextStyle(
                                            fontSize: 13, color: Colors.white)),
                                    SizedBox(
                                      height: Dimensions.height10,
                                    ),
                                    orderModel.products.length > 1
                                        ? SizedBox.fromSize()
                                        : Column(children: [
                                            SizedBox(
                                              height: Dimensions.height10,
                                            ),
                                          ]),
                                    Text(
                                        "Total Price: ₹${orderModel.totalprice.toStringAsFixed(2)}",
                                        style: const TextStyle(
                                            fontSize: 13, color: Colors.white)),
                                    SizedBox(
                                      height: Dimensions.height10,
                                    ),
                                    Text("Order Status: ${orderModel.status}",
                                        style: const TextStyle(
                                            fontSize: 13, color: Colors.white)),
                                    orderModel.status == "pending" ||
                                            orderModel.status == "Delivery"
                                        ? TextButton(
                                            onPressed: () async {
                                              await FirebaseFirestoreHelper
                                                  .instance
                                                  .updateOrder(
                                                      orderModel, "cancel");
                                              orderModel.status = "cancel";
                                              setState(() {});
                                            },
                                            child: const Text("Cancel Order",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          )
                                        : SizedBox.fromSize(),
                                    orderModel.status == "Delivery"
                                        ? TextButton(
                                            onPressed: () async {
                                              await FirebaseFirestoreHelper
                                                  .instance
                                                  .updateOrder(
                                                      orderModel, "completed");
                                              orderModel.status = "completed";
                                              setState(() {});
                                            },
                                            child: const Text("Delivered Order",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          )
                                        : SizedBox.fromSize()
                                  ]),
                            )
                          ]),

                          iconColor: Colors.blue,
                          
                          children: orderModel.products.length > 1
                              ? 
                              
                              [
                                
                                  const Text("Details"),
                                  const Divider(
                                    color: Colors.red,
                                  ),
                                  ...orderModel.products.map((singleproduct) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, top: 6),
                                      child: Column(
                                        children: [
                                          Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.baseline,
                                              textBaseline:
                                                  TextBaseline.alphabetic,
                                              children: [
                                                Container(
                                                  height: Dimensions.height50,
                                                  width: Dimensions.width50,
                                                  color: Colors.red
                                                      .withOpacity(0.5),
                                                  child: Image.network(
                                                      singleproduct.image),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                      height:
                                                          Dimensions.height130,
                                                      child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                    singleproduct
                                                                        .name,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        color: Colors
                                                                            .white)),
                                                                SizedBox(
                                                                  height: Dimensions
                                                                      .height10,
                                                                ),
                                                                Column(
                                                                    children: [
                                                                      SizedBox(
                                                                        height:
                                                                            Dimensions.height10,
                                                                      ),
                                                                    ]),
                                                                Text(
                                                                    " Price: ₹${singleproduct.price.toString()}",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13,color: Colors.white,
                                                                    )),
                                                              ]))),
                                                )
                                              ]),
                                          const Divider()
                                        ],
                                      ),
                                    );
                                  }).toList()
                                ]
                              : [],),
                    );
                  },
                ),
              );
            }));
  }
}
