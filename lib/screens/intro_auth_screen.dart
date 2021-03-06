import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:zoom_clone/authentication/navigate_auth_screen.dart';
import 'package:zoom_clone/variables.dart';

class IntroAuthScreen extends StatefulWidget {
  @override
  _IntroAuthScreenState createState() => _IntroAuthScreenState();
}

class _IntroAuthScreenState extends State<IntroAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: 'Welcome',
          body: 'Welcome to PriveConf, the best private video conference app!',
          image: Center(
            child: Image.asset(
              'images/welcome.png',
              height: 175,
            ),
          ),
          decoration: PageDecoration(
            bodyTextStyle: myTextStyle(20, Colors.black),
            titleTextStyle: myTextStyle(20, Colors.black),
          ),
        ),
        PageViewModel(
          title: 'Easy to use interface',
          body: 'Join or start meetings now! It only takes a few seconds!',
          image: Center(
            child: Image.asset(
              'images/conference.png',
              height: 175,
            ),
          ),
          decoration: PageDecoration(
            bodyTextStyle: myTextStyle(20, Colors.black),
            titleTextStyle: myTextStyle(20, Colors.black),
          ),
        ),
        PageViewModel(
          title: 'Secure and private',
          body:
              'Your security is important. This app uses the JitsiMeet API, an open-source, secure and reliable service!',
          image: Center(
            child: Image.asset(
              'images/secure.jpg',
              height: 200,
            ),
          ),
          decoration: PageDecoration(
            bodyTextStyle: myTextStyle(20, Colors.black),
            titleTextStyle: myTextStyle(20, Colors.black),
          ),
        ),
      ],
      onDone: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NavigateAuthScreen(),
          ),
        );
      },
      onSkip: () {
        print('skip');
      },
      showSkipButton: true,
      skip: const Icon(Icons.skip_next, size: 45),
      next: const Icon(Icons.arrow_forward_ios),
      done: Text(
        'Done',
        style: myTextStyle(20, Colors.black),
      ),
    );
  }
}
