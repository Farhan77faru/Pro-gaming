import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_gamer/constants/dimensions.dart';
import 'package:pro_gamer/model/user_model.dart';
import 'package:pro_gamer/provider/app_provider.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? image;
  void takePicture() async {
    XFile? value = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
    );
    if (value != null) {
      setState(() {
        image = File(value.path);
      });
    }
  }

  TextEditingController name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    appProvider.getUserInfoFirebase();
    return Scaffold(
                        backgroundColor: Colors.black,

      appBar: AppBar(
                          backgroundColor: Colors.black,
                                    iconTheme:const IconThemeData(color: Colors.white),


        centerTitle: true,
        title: const Text(
          "Profile",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            image == null
                ? GestureDetector(
                    onTap: () {
                      takePicture();
                    },
                    child: const CircleAvatar(
                      radius: 70,
                      child: Icon(Icons.camera_alt),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      takePicture();
                    },
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: FileImage(image!),
                    ),
                  ),
            SizedBox(
              height: Dimensions.height10,
            ),
            TextFormField(
              controller: name,
              decoration:const InputDecoration(hintText: "Name",
               hintStyle:
                      TextStyle(color: Color.fromARGB(255, 135, 131, 131)),),
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            TextButton(
                onPressed: () async {
                  UserModel userModel =
                      appProvider.getUserInformation.copyWith(name: name.text);
                  appProvider.updateUserinfoFirebase(context, userModel, image);
                },
                child: const Text("Update"))
          ],
        ),
      ),
    );
  }
}
