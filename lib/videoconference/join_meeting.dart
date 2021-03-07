import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:zoom_clone/variables.dart';

class JoinMeeting extends StatefulWidget {
  @override
  _JoinMeetingState createState() => _JoinMeetingState();
}

class _JoinMeetingState extends State<JoinMeeting> {
  TextEditingController nameController = TextEditingController();
  TextEditingController roomController = TextEditingController();
  bool isVideoDisabled = true;
  bool isAudioMuted = true;
  String username = '';

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
    });
  }

  void joinMeeting() async {
    print('ROOM: => ${roomController.text}');
    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      //featureFlag.resolution = FeatureFlagVideoResolution.MD_RESOLUTION;

      // Map<FeatureFlagEnum, bool> featureFlags = {
      //   FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
      // };
      // if (Platform.isAndroid) {
      //   featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      // } else if (Platform.isIOS) {
      //   featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
      // }

      var options = JitsiMeetingOptions()
        ..room = roomController.text
        ..userDisplayName =
            nameController.text.isEmpty ? username : nameController.text
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoDisabled
        ..featureFlag = featureFlag;
      // ..featureFlag.welcomePageEnabled = false
      // ..featureFlag.callIntegrationEnabled = Platform.isAndroid ? false : true
      // ..featureFlag.pipEnabled = Platform.isIOS ? false : true;

      await JitsiMeet.joinMeeting(options);
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 24),
              Text(
                'Room code',
                style: myTextStyle(20),
              ),
              SizedBox(height: 20),
              PinCodeTextField(
                appContext: context,
                autoDisposeControllers: false,
                length: 6,
                animationType: AnimationType.fade,
                animationDuration: Duration(milliseconds: 300),
                pinTheme: PinTheme(shape: PinCodeFieldShape.underline),
                controller: roomController,
                onChanged: (value) {
                  //
                },
              ),
              SizedBox(height: 10),
              TextField(
                controller: nameController,
                style: myTextStyle(20),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText:
                      'Name (Leave blank if you want to use your username)',
                  labelStyle: myTextStyle(15),
                ),
              ),
              SizedBox(height: 16),
              CheckboxListTile(
                title: Text(
                  'Video Disabled',
                  style: myTextStyle(18, Colors.black),
                ),
                value: isVideoDisabled,
                onChanged: (value) {
                  setState(() {
                    isVideoDisabled = value;
                  });
                },
              ),
              SizedBox(height: 16),
              CheckboxListTile(
                title: Text(
                  'Audio Muted',
                  style: myTextStyle(18, Colors.black),
                ),
                value: isAudioMuted,
                onChanged: (value) {
                  setState(() {
                    isAudioMuted = value;
                  });
                },
              ),
              SizedBox(height: 20),
              Text(
                'Of course, you can customise your settings in the meeting',
                style: myTextStyle(15),
                textAlign: TextAlign.center,
              ),
              Divider(
                height: 48,
                thickness: 2,
              ),
              InkWell(
                onTap: () => joinMeeting(),
                child: Container(
                  width: double.maxFinite,
                  height: 64,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: GradientColors.facebookMessenger),
                  ),
                  child: Center(
                    child: Text(
                      'Join Meeting!',
                      style: myTextStyle(20, Colors.white),
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
}
