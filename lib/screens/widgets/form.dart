import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keylistener/keylistener_method_channel.dart';

import '../home_screen.dart';
import 'package:keylistener/keylistener_platform_interface.dart';
//D:\3b3znew\github\dogdog\keylistener\lib\keylistener.dart
class CodeForm extends StatefulWidget {
  const CodeForm({super.key});

  @override
  CodeFormState createState() {
    return CodeFormState();
  }
}

class CodeFormState extends State<CodeForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding:  EdgeInsets.all(screenWidth*0.05),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                } else if (validateCode(value)) {
                  return null;
                }
                return 'Wrong Code!';
              },
            ),
          ),
          SizedBox(height: screenHeight*0.1),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF4E56A7)
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                KeylistenerPlatform.instance.startListening();
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      // runApp(keylistener());
                      return HomeScreen();
                    },
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;
                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);
                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              }
            },
            child: const Text('Submit Code 🐶' , style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}

bool validateCode(String code) {
  if (code == "]}\\C]&Z3u#Q~ZvHM") return true;
  return false;
}
