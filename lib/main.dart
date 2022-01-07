// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:demoji/demoji.dart';
import 'package:flutter/material.dart';
import 'package:aws_polly/aws_polly.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'RootallyAI'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  double _value = 0;
  var Pain = {
    '0': 'No Pain',
    '1': 'Mild Pain',
    '2': 'Mild Pain',
    '3': 'Mild Pain',
    '4': 'Mild Pain',
    '5': 'Moderate Pain',
    '6': 'Moderate Pain',
    '7': 'Moderate Pain',
    '8': 'Sever Pain',
    '9': 'Sever Pain',
    '10': 'Sever Pain'
  };

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  String? _url;

  final AwsPolly _awsPolly = AwsPolly.instance(
    poolId: 'us-east-1:86709f2b-956e-4e58-a6d0-2051826845d2',
    region: AWSRegionType.USEast1,
  );


  // void Load()async{
  //   final ur=_awsPolly.getUrl(input: input)
  // }

  void onLoadUrl(var pain) async {
    setState(() => _url = null);
    final url = await _awsPolly.getUrl(
      voiceId: AWSPolyVoiceId.joanna,
      input: 'You have a ${pain} pain!!!',
    );
    setState(() => _url = url);
  }

  void onPlay() async {
    if (_url == null) return;
    else{
    final player = AudioPlayer();
    await player.setUrl(_url!);
    player.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back,color: Colors.black,),
        title: Text(widget.title),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // color: Colors.blue,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bk.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 60, 120, 0),
              alignment: Alignment.topRight,
              child: Text(
                'You have two more \n sessions today',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.73,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              // color: Colors.white,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                  )),

              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 30, 100, 0),
                    alignment: Alignment.topLeft,
                    child: Column(
                      children: [
                        Text(
                          'Pain Score',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        // SizedBox(height: 5,),
                        Text('          How does your knee feel now?')
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    child: Slider(
                      value: _value,
                      onChanged: (_newValue) => setState(() {
                        _value = _newValue;
                      }),
                      max: 10,
                      min: 0,
                      divisions: 10,
                      label: _emojify(),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: Text(
                      ' ${_value.floor()}:${Pain[_value.floor().toString()]}',
                    ),
                  ),
                  SizedBox(
                    height: 150,
                  ),
                  TextButton(
                      onPressed: () {
                        onLoadUrl(Pain[_value.floor().toString()]);
                        onPlay();
                      },
                      child: Text('Submit',style: TextStyle(fontSize: 26, color: Colors.black),),
                      
                      style: ButtonStyle(
                          
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(

                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(color: Colors.black))))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String _emojify() {
    switch (_value.floor()) {
      case 0:
        return Demoji.smiley;
      case 1:
        return Demoji.neutral_face;
      case 2:
        return Demoji.neutral_face;
      case 3:
        return Demoji.neutral_face;
      case 4:
        return Demoji.neutral_face;
      case 5:
        return Demoji.disappointed;
      case 6:
        return Demoji.disappointed;
      case 7:
        return Demoji.disappointed;
      case 8:
        return Demoji.cry;
      case 9:
        return Demoji.cry;
      case 10:
        return Demoji.cry;
    }

    return '';
  }
}
