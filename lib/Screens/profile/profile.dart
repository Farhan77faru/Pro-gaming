// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_gamer/Screens/profile/favorate.dart';
import 'package:pro_gamer/Screens/profile/my_orders.dart';
import 'package:pro_gamer/Screens/profile/profile_edit.dart';
import 'package:pro_gamer/authentication/startpage.dart';
import 'package:pro_gamer/provider/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<AppProvider>(context, listen: false)
        .getUserInfoFirebase()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme:const IconThemeData(color: Colors.white),
        title:const Text(
          'Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon:const Padding(
              padding:  EdgeInsets.only(right: 10),
              child: Icon(Icons.logout_sharp, color: Colors.white),
            ),
            onPressed: () {
              _showLogoutDialog(context);
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(), 
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      color: Colors.blue,
                      padding:const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: appProvider
                                        .getUserInformation.image !=
                                    null
                                ? NetworkImage(
                                    appProvider.getUserInformation.image!)
                                : const AssetImage('lib/assets/profile-png-5.png')
                                    as ImageProvider,
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            appProvider.getUserInformation.name,
                            style:const TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                         const Text(
                            'Pro Gaming',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    title:const Text(
                      'Email',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      appProvider.getUserInformation.email,
                      style:const TextStyle(color: Colors.white),
                    ),
                    leading:const Icon(Icons.email, color: Colors.white),
                  ),
                  ListTile(
                    title:const Text(
                      'Phone number',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      appProvider.getUserInformation.phonenumber,
                      style:const TextStyle(color: Colors.white),
                    ),
                    leading:const Icon(Icons.phone, color: Colors.white),
                  ),
                  ListTile(
                    onTap: () {
                      Get.to(() =>const OrderPage());
                    },
                    title:const Text(
                      'Purchased Games',
                      style: TextStyle(color: Colors.white),
                    ),
                    leading:const Icon(Icons.shopping_bag, color: Colors.white),
                  ),
                  ListTile(
                    onTap: () {
                      Get.to(() =>const FavoritePage());
                    },
                    title:const Text(
                      'Favorite games',
                      style: TextStyle(color: Colors.white),
                    ),
                    leading:const Icon(Icons.favorite, color: Colors.white),
                  ),
                  ListTile(
                    onTap: () {
                      Get.to(() =>const EditProfilePage());
                    },
                    title:const Text(
                      'Edit Profile',
                      style: TextStyle(color: Colors.white),
                    ),
                    leading:const Icon(Icons.edit, color: Colors.white),
                  ),
                const  ListTile(
                    title: Text(
                      'About',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      'Passionate Flutter developer.',
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: Icon(Icons.info, color: Colors.white),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> logOut(BuildContext context) async {
    final _sharedPrefs = await SharedPreferences.getInstance();
    await _sharedPrefs.clear();

    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:const Text("Logout"),
          content:const Text("Are you sure you want to logout?"),
          actions: <Widget>[
            TextButton(
              child:const Text("No"),
              onPressed: () {
                Navigator.of(context).pop(); 
              },
            ),
            TextButton(
              child:const Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop(); 
                logOut(context); 
              },
            ),
          ],
        );
      },
    );
  }
}
