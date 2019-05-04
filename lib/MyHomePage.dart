import 'package:flutter/material.dart';
import 'package:vonaapp/TextToSpeechAPI.dart';
import 'package:vonaapp/voice.dart';
import 'dart:io';
import 'package:audioplayer/audioplayer.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //List<Voice> _voices = [];
  Voice _selectedVoice;
  AudioPlayer audioPlugin = AudioPlayer();
  final TextEditingController _searchQuery = TextEditingController();


  initState() {
    super.initState();
    getVoices();
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
    return new Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 4.0,
        child: Icon(Icons.audiotrack),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        onPressed: () {
          final text = "UH OH! can you say that again?";
          if (text.length == 0 || _selectedVoice == null) return;
          synthesizeText(text);
        },
      ),
    );
  }

}

class VonaImageAsset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('assets/vona_excited.png');
    Image image = Image(image: assetImage);
    return Container(child: image,);
  }
}

