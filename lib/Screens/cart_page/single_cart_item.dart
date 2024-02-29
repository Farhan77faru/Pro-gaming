// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pro_gamer/constants/constants.dart';
import 'package:pro_gamer/constants/dimensions.dart';
import 'package:pro_gamer/firebasehelper/firebase_firestore.dart';
import 'package:provider/provider.dart';
import '../../provider/app_provider.dart';

class CartItemCheckout extends StatefulWidget {
  const CartItemCheckout({
    super.key,
  });

  @override
  State<CartItemCheckout> createState() => _CartItemCheckoutState();
}

int groupValue = 1;

class _CartItemCheckoutState extends State<CartItemCheckout> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: Dimensions.height100,
          child: Column(
            children: [
              InkWell(
                onTap: () async {
                  if (groupValue == 1) {
                    showLoaderDialog(context);
                    bool value = await FirebaseFirestoreHelper.instance
                        .uploadOrderedProductFirebase(
                            appProvider.getBuyProductList,
                            context,
                            "Cash on delivery" );

                    appProvider.clearBuyProduct();

                    if (value) {
                      await Future.delayed(const Duration(seconds: 2));
                      Navigator.of(context, rootNavigator: true).pop();
                      Navigator.of(context).pop();
                    }
                  } else {
                    
                    // int value = double.parse(appProvider.totalPriceBuyProductList().toString())
                    // .round()
                    // .toInt();
                    // String totalPrice = (value * 100).toString();
                    //  await StripeHelper.instance
                    //     .makePayment(totalPrice.toString(),context);
                    
                  }
                },
                child: Container(
                  height: Dimensions.height50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.red,
                  ),
                  child: const Center(
                    child: Text(
                      "Continue",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme:const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          "Checkout",
          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
        ),
     
      ),
      body: 
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          
          children: [
            SizedBox(
              height: Dimensions.height10,
            ),
            Container(
              height: Dimensions.height100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius10),
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 3)),
              width: double.infinity,
              child: Row(
                children: [
                  Radio(
                      value: 1,
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value!;
                        });
                      }),
                  const Icon(Icons.money),
                  const Text(
                    "Cash on Delivery",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Dimensions.height10,
            ),
            Container(
              height: Dimensions.height100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius10),
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 3)),
              width: double.infinity,
              child: Row(
                children: [
                  Radio(
                      value: 2,
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value!;
                        });
                      }),
                  const Icon(Icons.money),
                  const Text(
                    "Payment Online",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}