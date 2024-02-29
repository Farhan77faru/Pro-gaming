import 'package:flutter/material.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({Key? key}) : super(key: key);

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
         iconTheme:const IconThemeData(color: Colors.white),
        title:const Text('Checkout',
         style: TextStyle(
                color: Colors.white)
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
          const  Text(
              'Review Your Order',
              style: TextStyle(
                 color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          const  SizedBox(height: 20),
            Card(
              child: ListTile(
                title:const Text('Product Name'),
                subtitle:const Text('Price: \$100'),
                trailing: IconButton(
                  icon:const Icon(Icons.edit),
                  onPressed: () {

                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                title:const Text('Another Product Name'),
                subtitle:const Text('Price: \$50'),
                trailing: IconButton(
                  icon:const Icon(Icons.edit),
                  onPressed: () {
                    
                  },
                ),
              ),
            ),
          const  SizedBox(height: 20),
          const  Text(
              'Total: \$150',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          const  SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                
              },
              child:const Text('Complete Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}

      