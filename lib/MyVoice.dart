import 'package:flutter/material.dart';
import 'package:vonaapp/TextToSpeechAPI.dart';
import 'package:vonaapp/voice.dart';
import 'dart:io';
import 'package:audioplayer/audioplayer.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:speech_recognition/speech_recognition.dart';
//import 'package:flare_flutter/flare_actor.dart';


class MyVoice extends StatefulWidget {
  MyVoice({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MyVoiceState createState() => _MyVoiceState();
}

class _MyVoiceState extends State<MyVoice> {

  Voice _selectedVoice;
  AudioPlayer audioPlugin = AudioPlayer();
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;

  String resultText = "";


  initState() {
    super.initState();
    initSpeechRecognizer();
    getVoices();
  }

  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setAvailabilityHandler(
          (bool result) => setState(() => _isAvailable = result),
    );

    _speechRecognition.setRecognitionStartedHandler(
          () => setState(() => _isListening = true),
    );

    _speechRecognition.setRecognitionResultHandler(
          (String speech) => setState(() => resultText = speech),
    );

    _speechRecognition.setRecognitionCompleteHandler(
          () => setState(() => _isListening = false),
    );

    _speechRecognition.activate().then(
          (result) => setState(() => _isAvailable = result),
    );
  }

  void synthesizeText(String text) async {
    if (audioPlugin.state == AudioPlayerState.PLAYING) {
      await audioPlugin.stop();
    }
    final String audioContent = await TextToSpeechAPI().synthesizeText(
        text, _selectedVoice.name, _selectedVoice.languageCodes.first);
    if (audioContent == null) return;
    final bytes = Base64Decoder().convert(audioContent, 0, audioContent.length);
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/wavenet.mp3');
    await file.writeAsBytes(bytes);
    await audioPlugin.play(file.path, isLocal: true);
  }

  void getVoices() async {
    final voices = await TextToSpeechAPI().getVoices();
    if (voices == null) return;
    setState(() {
      _selectedVoice = voices.firstWhere((e) => e.name == 'en-US-Wavenet-F' &&
          e.languageCodes.first == 'en-US' && e.pitch == 1.20,
          orElse: () => Voice('en-US-Wavenet-F', 'FEMALE', ['en-US'], 1.2));
      //_voices = voices;
    });
  }

  @override
  Widget build(BuildContext context) {

    /*final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        child: Image.asset('assets/VONA.flr'),
      ),
    );*/
    return new Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Color.fromRGBO(255, 188, 62, 1),
        //color: Color.fromARGB(1, 255, 188, 62),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: "btn1",
                  child: Icon(Icons.mic),
                  onPressed: (){
                    if (_isAvailable && !_isListening)
                      _speechRecognition
                          .listen(locale: "en_US")
                          .then((result) => print('$result'));
                  },
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
                FloatingActionButton(
                  heroTag: "btn2",
                  child: Icon(Icons.play_circle_outline),
                  onPressed: (){
                    if(resultText.contains("donkey") || resultText.contains("cat"))
                      synthesizeText("You are excellent!");
                    else
                      synthesizeText("That is wrong");
                  },
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


