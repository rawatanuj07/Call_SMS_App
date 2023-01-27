import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

late var _phoneNum;

class _MyAppState extends State<MyApp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final textController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 209, 205, 234),
        appBar: AppBar(
          title: Text('Call and SMS App'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.fromLTRB(20, 80, 20, 40),
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 250,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller: textController,
                          cursorColor: Colors.black,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[350],
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(50)),
                            hintText: 'Enter Phone Number',
                          ),
                        ),
                      )
                    ],
                  )),
              SizedBox(
                height: 40,
              ),
              MaterialButton(
                onPressed: () async {
                  setState(() {
                    _phoneNum = textController.text;
                  });

                  final _sms = 'sms:$_phoneNum';
                  if (await canLaunch(_sms)) {
                    await launch(_sms);
                  }
                },
                color: Colors.blue,
                child: Text('SMS'),
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _phoneNum = textController.text;
                  });

                  dynamic _call = 'tel:$_phoneNum';
                  if (await canLaunch(_call)) {
                    await launch(_call);
                  }
                },
                child: Text(
                  'CALL',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
