
// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:pro_gamer/constants/constants.dart';
import 'package:pro_gamer/constants/dimensions.dart';
import 'package:pro_gamer/model/product_model.dart';
import 'package:provider/provider.dart';
import '../../provider/app_provider.dart';

class SingleCart extends StatefulWidget {
 final  ProductModel singleProduct;
  const SingleCart({super.key,required this.singleProduct});

  @override
  State<SingleCart> createState() => _SingleCartState();
}

class _SingleCartState extends State<SingleCart> {
  int count =1;

  @override
  void initState() {
  count = widget.singleProduct.count??1;
   setState(() {});
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius10),
              border: Border.all(color: Colors.red, width: 2.3),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 140,
                    color: Colors.red.withOpacity(0.5),
                    child: Image.network(
                      widget.singleProduct.image),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Container(
                      height: 140,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.singleProduct.name,
                                  style:const TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: Dimensions.height10,),
                                
                                 SizedBox(
                                      height: Dimensions.height30,
                                    ),
                               
                          
                                 
                              ]),
                              Text(
                               "₹${widget.singleProduct.price}" ,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                           InkWell(
                            onTap: () {
                    AppProvider appProvider =  Provider.of<AppProvider>(context,listen: false);
                    appProvider.removeCartProduct(widget.singleProduct);
                    ShowMessage("Removed From  Cart");
                            },
                            child:const Icon(Icons.delete,color: Colors.red,)),
               ] ),
                      ),
                    ))
              ],
            ),
          ),
    );
  }
  
}