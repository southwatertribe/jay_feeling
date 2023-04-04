import 'package:flutter/material.dart';
import 'package:jay_feeling/api/audio_handler.dart';
import 'package:jay_feeling/api/sound_handler.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({Key? key}) : super(key: key);

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  //Instance of audioRecorder
  final audioHandler = AudioHandler();
  bool isRecording = false;
  bool isPlaying = false;
  static const audioSavePath = 'voice_audio.aac';

  @override
  void initState() {
    super.initState();
    audioHandler.init();
  }

  @override
  void dispose() {
    audioHandler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildStart(),
            SizedBox(height: 16),
            buildPlaybackButton(),
          ],
        ),
      ),
    );
  }


  Widget buildPlaybackButton() {
    final icon = isPlaying ? Icons.stop : Icons.play_arrow;
    final text = isPlaying ? 'STOP' : 'PLAY';
    final primary = isPlaying ? Colors.red : Colors.white;
    final onPrimary = isPlaying ? Colors.red : Colors.white;

    return ElevatedButton.icon(
      onPressed: () async {
        if (isPlaying) {
          await audioHandler.stopPlaying();
        } else {
          await audioHandler.play(audioSavePath);
        }
        setState(() {
          isPlaying = !isPlaying;
        });
      },
      icon: Icon(icon),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        primary: primary,
        onPrimary: onPrimary,
      ),
    );
  }


  Widget buildStart() {
    final icon = isRecording ? Icons.stop : Icons.mic;
    final text = isRecording ? 'STOP': 'START';
    final primary = isRecording ? Colors.red : Colors.white;
    final onPrimary = isRecording ? Colors.red : Colors.white;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () async {
            if (isRecording) {
              await audioHandler.stopRecording();
            } else {
              await audioHandler.record(audioSavePath);
            }
            setState(() {
              isRecording = !isRecording;
            });
          },
          icon: Icon(icon),
          label: Text(text),
          style: ElevatedButton.styleFrom(
            primary: primary,
            onPrimary: onPrimary,
          ),
        ),
        SizedBox(height: 16),
        buildPlaybackButton(),
      ],
    );
  }

// Widget buildPlaybackButton() {
//   final isPlaying = recorder.isPlaying;
//   final icon = isPlaying ? Icons.stop : Icons.play_arrow;
//   final text = isPlaying ? 'STOP': 'PLAY';
//   final primary = isPlaying ? Colors.red : Colors.white;
//   final onPrimary = isPlaying ? Colors.red : Colors.white;
//
//   return ElevatedButton.icon(
//     onPressed: () async {
//       final isplaying = await recorder.togglePlay();
//       setState(() {});
//     },
//     icon: Icon(icon),
//     label: Text(text),
//   );
// }


}

