import 'package:flutter/material.dart';
import 'package:jay_feeling/api/audio_handler.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({Key? key}) : super(key: key);

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  //Instance of audioRecorder
  final recorder = SoundRecorder();
  @override
  void initState() {
    super.initState();

    recorder.init();
  }

  @override
  void dispose(){
    recorder.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:[
          buildStart(),
          buildPlaybackButton(),
        ]
      ),
    );
  }

  Widget buildStart() {
    final isRecording = recorder.isRecording;
    final icon = isRecording ? Icons.stop : Icons.mic;
    final text = isRecording ? 'STOP': 'START';
    final primary = isRecording ? Colors.red : Colors.white;
    final onPrimary = isRecording ? Colors.red : Colors.white;

    return Center(
      child: ElevatedButton.icon(
        onPressed: () async {
          final isRecording = await recorder.toggleRecording();
          setState(() {});
        },
        icon: Icon(icon),
        label: Text(text),
      ),
    );
  }

  Widget buildPlaybackButton() {
    final isPlaying = recorder.isPlaying;
    final icon = isPlaying ? Icons.stop : Icons.play_arrow;
    final text = isPlaying ? 'STOP': 'PLAY';
    final primary = isPlaying ? Colors.red : Colors.white;
    final onPrimary = isPlaying ? Colors.red : Colors.white;

    return ElevatedButton.icon(
      onPressed: () async {
        final isplaying = await recorder.togglePlay();
        setState(() {});
      },
      icon: Icon(icon),
      label: Text(text),
    );
  }


}

