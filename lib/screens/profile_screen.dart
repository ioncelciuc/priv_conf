import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:zoom_clone/variables.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = '';
  bool dataIsThere = false;
  TextEditingController usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    DocumentSnapshot userDoc =
        await userCollection.doc(FirebaseAuth.instance.currentUser.uid).get();
    setState(() {
      username = userDoc.data()['username'];
      dataIsThere = true;
    });
  }

  void editProfile() async {
    userCollection.doc(FirebaseAuth.instance.currentUser.uid).update({
      'username': usernameController.text,
    });
    setState(() {
      username = usernameController.text;
    });
    Navigator.pop(context);
  }

  void openEditProfileDialog() async {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          height: 200,
          child: Column(
            children: [
              SizedBox(height: 30),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30),
                child: TextField(
                  controller: usernameController,
                  style: myTextStyle(18, Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Update Username',
                    hintStyle: myTextStyle(16, Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 40),
              InkWell(
                onTap: () => editProfile(),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: GradientColors.facebookMessenger),
                  ),
                  child: Center(
                    child: Text(
                      'Update now!',
                      style: myTextStyle(17, Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[250],
      body: !dataIsThere
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                ClipPath(
                  clipper: OvalBottomBorderClipper(),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.5,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: GradientColors.facebookMessenger),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 2 - 64,
                    top: MediaQuery.of(context).size.height / 3.1,
                  ),
                  child: CircleAvatar(
                    radius: 64,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                        'https://webstockreview.net/images/profile-icon-png-9.png'),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(child: SizedBox(height: 300)),
                      Text(
                        username,
                        style: myTextStyle(40, Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30),
                      InkWell(
                        onTap: () => openEditProfileDialog(),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: GradientColors.facebookMessenger),
                          ),
                          child: Center(
                            child: Text(
                              'Edit Profile',
                              style: myTextStyle(17, Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
