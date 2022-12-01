import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:translator/translator.dart';

class Translate extends StatefulWidget {
  const Translate({super.key, required this.title});
  final String title;

  @override
  State<Translate> createState() => _TranslateState();
}

class _TranslateState extends State<Translate> {
  final String translationText = "";
  TextEditingController textcontroller = TextEditingController();

  var translatedPhrase = "";

  var translator = GoogleTranslator();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textcontroller.text = widget.title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Translate",
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: textcontroller,
                    ),
                    MaterialButton(
                        child: const Text("Translate"),
                        color: Colors.blue,
                        onPressed: (() {
                          setState(() {
                            translator
                                .translate(textcontroller.text,
                                    from: "en", to: "ta")
                                .then((t) {
                              setState(() {
                                translatedPhrase = t.text;
                              });
                            });
                          });
                        }))
                  ],
                ),
              ),
            ),
            Flexible(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        translatedPhrase,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          MaterialButton(
                            child: const Icon(Icons.clear),
                            onPressed: () {},
                          ),
                          MaterialButton(
                            child: const Icon(Icons.content_copy),
                            onPressed: () {
                              Clipboard.setData(
                                  ClipboardData(text: translatedPhrase));
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
