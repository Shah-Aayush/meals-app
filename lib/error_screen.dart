import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import "dart:math";

import './main.dart';

String get randomErrorAnimation {
  var listOfAnimations = [
    'https://assets6.lottiefiles.com/packages/lf20_kcsr6fcp.json',
    'https://assets3.lottiefiles.com/packages/lf20_rDB3bm.json',
    'https://assets3.lottiefiles.com/packages/lf20_GIyuXJ.json',
    'https://assets3.lottiefiles.com/packages/lf20_1vhutqov.json',
    'https://assets3.lottiefiles.com/packages/lf20_58bmsu1o.json',
    'https://assets3.lottiefiles.com/packages/lf20_ukmmbtae.json',
    'https://assets3.lottiefiles.com/private_files/lf30_9pjelogw.json',
    'https://assets3.lottiefiles.com/packages/lf20_r71cen62.json',
    'https://assets3.lottiefiles.com/packages/lf20_c8szgzpw.json',
  ];
  return listOfAnimations[Random().nextInt(listOfAnimations.length)];
}

class ErrorScreen extends StatelessWidget {
  void goBack(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed(
      MyApp().routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item not found!'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 6, bottom: 10),
                child: Column(
                  children: [
                    Text(
                      'Oops!',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Something went wrong.',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
              Lottie.network(
                randomErrorAnimation,
                height: MediaQuery.of(context).size.height / 3,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  onPressed: () => goBack(context),
                  child: Text('Go to Homepage'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
