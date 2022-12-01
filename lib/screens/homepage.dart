import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stts;
import 'package:wee/models/translate.dart';
import 'package:wee/models/transtext.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _speechToText = stts.SpeechToText();

  bool islistening = false;
  String text = "please press the button before speaking.";
  void listen() async {
    if (!islistening) {
      bool available = await _speechToText.initialize(
          onStatus: (status) => print("$status"),
          onError: (errorNotification) => print("$errorNotification"));
      if (available) {
        setState(() {
          islistening = true;
        });
        _speechToText.listen(
          onResult: (result) => setState(() {
            text = result.recognizedWords;
            transText = text;
            // Timer(Duration(seconds: 3), () {
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => Translate(title: text)));
            // });
          }),
        );
      }
    } else {
      setState(() {
        islistening = false;
      });
      _speechToText.stop();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _speechToText = stts.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Speech to text",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(text,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                islistening == false;

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Translate(title: text)));
              },
              child: Text("DONE"),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: islistening,
        repeat: true,
        endRadius: 80,
        glowColor: Colors.red,
        duration: Duration(milliseconds: 1000),
        child: FloatingActionButton(
          onPressed: () {
            listen();
            // if (islistening == false &&
            //     text == "please press the button before speaking.") {
            //   listen();
            // } else {

            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => Translate(title: text)));
            // }
          },
          child: Icon(islistening ? Icons.mic : Icons.mic_none),
        ),
      ),
    );
  }
}
